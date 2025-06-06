# Variables to configure the environment
FLUTTER?=flutter
DART?=dart



run:
	@echo "Running the application"
	$(FLUTTER) run 
build-debug:
	@echo "Building Flutter app for debug"
	$(FLUTTER) build apk --debug


build-release:
	@echo "Building Flutter app for release"
	$(FLUTTER) build apk --release --no-tree-shake-icons



build-aab:
	@echo "Building Flutter app bundle"
	$(FLUTTER) build appbundle --release


#  Generate the auto-generated files for the project using the build_runner
gen-code:
	@echo "Generating codes"
	$(DART) run build_runner build --delete-conflicting-outputs
