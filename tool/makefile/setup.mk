.PHONY: setup update-firebase generate-icons generate-splash

setup:
	@npm install -g firebase-tools
	-firebase login
	@firebase init
#	@fvm flutter pub global activate intl_utils
	@dart pub global activate flutterfire_cli
	@flutterfire configure -y \
		--platforms=android,ios,macos,web,linux,windows \
		-i dev.plugfox.tab_router_example \
		-m dev.plugfox.tab_router_example \
		-a dev.plugfox.tab_router_example \
		-p playplugfox \
		-e plugfox@gmail.com \
		-o lib/src/common/constant/firebase_options.dart

add-hosting:
	@firebase init hosting
	@firebase init hosting:github

generate-icons: get
	@fvm flutter pub run icons_launcher:create --path icons_launcher.yaml

generate-splash: get
	@fvm flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml

# ! WARNING: DO NOT CALL THIS DIRECTLY !
keytool-genkey:
	@keytool -genkey -v -keystore android/app/tab_router_example.keystore -alias tab_router_example -keyalg RSA -keysize 2048 -validity 10000

keytool-list:
	@keytool -list -v -keystore ~/.android/debug.keystore.jks -alias androiddebugkey -storepass android -keypass android
