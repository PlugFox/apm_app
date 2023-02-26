.PHONY: version doctor clean get codegen upgrade upgrade-major outdated dependencies format

version:
	@fvm flutter --version

doctor:
	@fvm flutter doctor

clean:
	@rm -rf coverage .dart_tool .packages pubspec.lock

get:
	@fvm flutter pub get

codegen: get format
	@fvm flutter pub run build_runner build --delete-conflicting-outputs
	@dart pub global run intl_utils:generate
	@protoc --dart_out=grpc:lib/src/common/model/generated -Iprotos protos/apm.proto

upgrade:
	@fvm flutter pub upgrade

upgrade-major:
	@fvm flutter pub upgrade --major-versions

outdated: get
	@fvm flutter pub outdated

dependencies: upgrade
	@fvm flutter pub outdated --dependency-overrides \
		--dev-dependencies --prereleases --show-all --transitive

format:
	@dart format --fix -l 120 .