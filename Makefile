default: all

arm-20-build:
	bash ./build.sh build arm 20 build
arm-orin-22-build:
	bash ./build.sh build arm-orin 22 build
x86-22-build:
	bash ./build.sh build x86 22 build
x86-22-run: x86-22-build
	bash ./build.sh build x86 22 run

build-all: arm-20-build arm-orin-22-build x86-22-run

push-arm-20-build:
	bash ./build.sh push arm 20 build
push-x86-22-build:
	bash ./build.sh push x86 22 build
push-x86-22-run:
	bash ./build.sh push x86 22 run
push-arm-orin-22-build:
	bash ./build.sh push arm-orin 22 build

push-all: push-arm-20-build push-arm-orin-22-build push-x86-22-build push-x86-22-run

all: build-all push-all
