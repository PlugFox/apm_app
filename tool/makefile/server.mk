.PHONY: server

server:
#	@mkdir -p package/server/lib/src/generated
	@protoc --dart_out=grpc:package/server/lib/src/generated \
			--proto_path=package/server/protos \
				package/server/protos/apm.proto