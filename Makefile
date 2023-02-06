PROGRAM := 7zz
FROM_IMAGE_TAG := kinetic
SEVEN_ZIP_VERSION := 2201
IMAGE_TAG := build-official-7zip
CONTAINER_TAG := $(IMAGE_TAG)-$(shell date +%s)

PREFIX := /usr/local
DIST_DIR := $(PREFIX)
DIST_BIN_DIR := $(DIST_DIR)/bin


all: $(PROGRAM)

$(PROGRAM): build
	docker container cp $(CONTAINER_TAG):/build/CPP/7zip/Bundles/Alone2/_o/7zz .

build:
	docker image build -t $(IMAGE_TAG) --build-arg FROM_IMAGE_TAG=$(FROM_IMAGE_TAG) --build-arg SEVEN_ZIP_VERSION=$(SEVEN_ZIP_VERSION) .
	docker container create --name $(CONTAINER_TAG) --rm $(IMAGE_TAG)

.PHONY: install
install: $(PROGRAM)
	install -m 755 $(PROGRAM) $(DIST_BIN_DIR)

.PHONY: clean
clean:
	rm -f $(PROGRAM)

