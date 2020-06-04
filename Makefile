SHELL := /bin/bash

VERSION ?= 1.0.1
SWIFT_VERSION ?= 5.3-dev
REPO ?= mariusomdev/aws-lambda-swift

TAG ?= "$(REPO):$(VERSION)-swift-$(SWIFT_VERSION)"

build:
	@docker build -t $(TAG) .
	@docker tag $(TAG) $(REPO):latest
	@docker tag $(TAG) $(REPO):latest-swift-$(SWIFT_VERSION)

publish_container: build
	@docker push $(TAG)
	@docker push $(REPO):latest
	@docker push $(REPO):latest-swift-$(SWIFT_VERSION)

clean_layer:
	rm -r tmp/lib || true

create_layer: clean_layer
	mkdir -p tmp/lib
	docker run --rm --volume "$(shell pwd)/:/src" --workdir "/src" \
			$(TAG) \
			cp -t tmp/lib \
					/usr/lib/swift/linux/libBlocksRuntime.so \
					/usr/lib/swift/linux/libFoundation.so \
					/usr/lib/swift/linux/libFoundationNetworking.so \
					/usr/lib/swift/linux/libFoundationXML.so \
					/usr/lib/swift/linux/libdispatch.so \
					/usr/lib/swift/linux/libicudataswift.so.65 \
					/usr/lib/swift/linux/libicui18nswift.so.65 \
					/usr/lib/swift/linux/libicuucswift.so.65 \
					/usr/lib/swift/linux/libswiftCore.so \
					/usr/lib/swift/linux/libswiftDispatch.so \
					/usr/lib/swift/linux/libswiftGlibc.so \
					/usr/lib64/libatomic.so.1 \
					/usr/lib/swift/linux/libswiftSwiftOnoneSupport.so
	cd ./tmp; zip -r swift-lambda-layer.zip lib -x ".DS_Store"
	