.PHONY: build-web deploy-web

build-web: codegen
	@fvm flutter build web --release --no-source-maps --pwa-strategy offline-first --web-renderer auto --base-href /

deploy-web:
	@firebase deploy