.PHONY: setup

# choco install protoc
# brew install protobuf
# export PATH="$PATH:$PUB_CACHE/bin"
setup:
	@dart pub global activate protoc_plugin
	@dart pub global activate intl_utils
