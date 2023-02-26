.PHONY: database

# Database codegen
database:
	@(cd package/database && dart pub get && dart run build_runner build --delete-conflicting-outputs)
