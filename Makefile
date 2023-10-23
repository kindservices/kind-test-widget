run: build
	. ./build.sh && run
build:
	. ./build.sh && build
push: build
	. ./build.sh && push
installArgo:
	. ./build.sh && installArgo
dev:
	. ./build.sh && dev
clean:
	. ./build.sh && clean