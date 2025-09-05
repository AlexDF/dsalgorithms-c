all:
	$(MAKE) build
	$(MAKE) install
	$(MAKE) clean

build:
	$(MAKE) build-deb-unsigned

build-local:
	rm -rf build
	mkdir build
	cd build && cmake .. -DBUILD_TESTS=ON && make

test-local:
	cd build && ctest

install:
	cd releases && \
	sudo chmod 644 *.deb && \
	ARCH=$$(dpkg --print-architecture) && \
	RUNTIME_DEB=$$(ls libdsalgorithms-c0_*_$$ARCH.deb 2>/dev/null | head -1) && \
	DEV_DEB=$$(ls libdsalgorithms-c-dev_*_$$ARCH.deb 2>/dev/null | head -1) && \
	if [ -z "$$RUNTIME_DEB" ] || [ -z "$$DEV_DEB" ]; then \
		echo "Error: Could not find .deb files for architecture $$ARCH"; \
		exit 1; \
	fi && \
	echo "Installing $$RUNTIME_DEB and $$DEV_DEB" && \
	cp $$RUNTIME_DEB $$DEV_DEB /tmp/ && \
	sudo apt-get install /tmp/$$RUNTIME_DEB /tmp/$$DEV_DEB && \
	rm /tmp/$$RUNTIME_DEB /tmp/$$DEV_DEB

uninstall:
	sudo apt-get remove -y libdsalgorithms-c-dev libdsalgorithms-c0

init-dev:
	$(MAKE) setup-git-hooks

setup-git-hooks:
	cp scripts/git-hooks/* .git/hooks/
	chmod +x .git/hooks/*

build-deb-unsigned:
	dpkg-buildpackage -us -uc
	$(MAKE) .move-deb-files

build-deb-signed:
	dpkg-buildpackage
	$(MAKE) .move-deb-files

.move-deb-files:
	mkdir -p releases
	mv \
	../libdsalgorithms-c*.deb \
	../dsalgorithms-c*.changes \
	../dsalgorithms-c*.buildinfo \
	../dsalgorithms-c*.tar.* \
	../libdsalgorithms-c*.ddeb \
	../dsalgorithms-c*.dsc \
	./releases \

DOCKER_IMAGE = dsalgorithms-deb-build-image

.create-docker-image:
	sudo docker build -t $(DOCKER_IMAGE) .

docker-build:
	$(MAKE) docker-build-deb-unsigned

docker-build-deb-unsigned:
	mkdir -p ./releases ./build-deb
	$(MAKE) .create-docker-image
	sudo docker run --rm \
		-v ${PWD}:/project-root:ro \
		-v ${PWD}/releases:/releases \
		-v ${PWD}/build-deb:/build-deb \
		-w /workspace-root/workspace \
		$(DOCKER_IMAGE) \
		/bin/bash -c " \
			cp -r /project-root/* . && \
			dpkg-buildpackage -us -uc && \
			mv ../*.deb ../*.changes ../*.buildinfo ../*.tar.* ../*.ddeb ../*.dsc /releases/ 2>/dev/null || true && \
			cp -R obj-*-gnu /build-deb && \
			/build-deb/obj-*/bin/Demo && \
			apt-get install /releases/libdsalgorithms-c0_0.1.0~alpha1-1_arm64.deb /releases/libdsalgorithms-c-dev_0.1.0~alpha1-1_arm64.deb && \
			cd tests && \
			rm -f ./test ./test-static && \
			gcc -static test.c -o test-static -ldsalgorithms-c && \
			gcc test.c -o test -ldsalgorithms-c && \
			printf '\n\nDynamic linking test (after installation):\n' && ./test && \
			printf '\nStatic linking test (after installation):\n' && ./test-static \
		"

docker-build-deb-signed:
	mkdir -p ./releases ./build-deb
	$(MAKE) .create-docker-image
	sudo docker run --rm \
		-v ${PWD}:/project-root:ro \
		-v ${PWD}/releases:/releases \
		-v ${PWD}/build-deb:/build-deb \
		-w /workspace-root/workspace \
		$(DOCKER_IMAGE) \
		/bin/bash -c " \
			cp -r /project-root/* . && \
			dpkg-buildpackage && \
			mv ../*.deb ../*.changes ../*.buildinfo ../*.tar.* ../*.ddeb ../*.dsc /releases/ 2>/dev/null || true && \
			cp -R obj-*-gnu /build-deb && \
			/build-deb/obj-*/bin/Demo \
		"

# Force rebuild of Docker image
rebuild-docker-image:
	sudo docker rmi $(DOCKER_IMAGE) 2>/dev/null || true
	$(MAKE) .create-docker-image

clean:
	sudo rm -rf build build-deb releases
#	debian/rules clean
	sudo rm -rf ./obj-*-gnu
	sudo rm -rf \
		./debian/.debhelper/ \
		./debian/debhelper-build-stamp \
		./debian/files \
		./debian/libdsalgorithms-c-dev/ \
		./debian/*.log \
		./debian/*.substvars \
		./debian/libdsalgorithms-c0/ \
		./debian/tmp/

.PHONY: build build-local test install build-local build-deb-unsigned build-deb-signed docker-build-deb-unsigned docker-build-deb-signed rebuild-docker-image clean
