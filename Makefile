all: build
	.build/debug/SwenDemo

build:
	swift build -k
	swift build
