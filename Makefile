### Targets and structure inspired by https://github.com/iximiuz/labs-playgrounds/blob/main/Makefile

IMAGE_REPO = ghcr.io/unlabs-dev/uncloud-labs/rootfs
MANIFESTS_DIR = manifests
DOCKER_BUILD_FLAGS ?=
UNCLOUD_VERSION ?= v0.20.0

all:
	exit 1

build-img-%:
	docker build \
		--progress plain \
		$(DOCKER_BUILD_FLAGS) \
		--build-arg UNCLOUD_VERSION=$(UNCLOUD_VERSION) \
		-f ./rootfs-images/$*/Dockerfile \
		-t $(IMAGE_REPO):$* \
		-t $(IMAGE_REPO):$*-$(UNCLOUD_VERSION) \
		.
.PHONY: build-img-%

push-img-%: build-img-%
	docker push $(IMAGE_REPO):$*
	docker push $(IMAGE_REPO):$*-$(UNCLOUD_VERSION)
.PHONY: push-img-%

test-img-%: build-img-%
	@test -f rootfs-images/$*/test.sh || { echo "Error: rootfs-images/$*/test.sh not found"; exit 1; }
	docker run --rm $(IMAGE_REPO):$* bash -c "$$(cat rootfs-images/$*/test.sh)"
.PHONY: test-img-%

### Playgrounds

PLAYGROUND_IDS = \
	uncloud-cluster-64523f7c \
	uncloud-uninitialized-cluster-cacb63ae \
	uncloud-django-app-2b759193

PLAYGROUND_DIR = $(MANIFESTS_DIR)/playgrounds

# Save playground manifests locally
pull-playgrounds:
	@mkdir -p $(PLAYGROUND_DIR)
	@for id in $(PLAYGROUND_IDS); do \
		labctl playground manifest $$id > $(PLAYGROUND_DIR)/$$id.yaml && \
		echo ">>> Saved playground manifest for: $$id"; \
	done
.PHONY: pull-playgrounds

push-playgrounds:
	@for id in $(PLAYGROUND_IDS); do \
		echo '---'; \
		labctl playground update $$id -f $(PLAYGROUND_DIR)/$$id.yaml && \
		echo ">>> Pushed playground manifest for: $$id"; \
	done
.PHONY: push-playgrounds

### Tutorials

TUTORIALS_DIR = $(MANIFESTS_DIR)/tutorials
TUTORIALS_IDS = \
	uncloud-create-cluster-ebebf72b \
	uncloud-deploy-django-app-7a378bc3

pull-tutorials:
	@mkdir -p $(TUTORIALS_DIR)
	@for tutorial in $(TUTORIALS_IDS); do \
		echo '---'; \
		labctl content pull tutorial -f $$tutorial -d $(TUTORIALS_DIR)/$$tutorial; \
	done

push-tutorials:
	for id in $(TUTORIALS_IDS); do \
		echo '---'; \
		labctl content push tutorial -f $$id -d $(TUTORIALS_DIR)/$$id/ && \
		echo ">>> Pushed tutorial manifest for: $$id"; \
	done
.PHONY: push-tutorials

stream-tutorial:
	@echo "Available tutorials:"
	@for tutorial in $(TUTORIALS_IDS); do \
		echo " - $$tutorial"; \
	done
.PHONY: stream-tutorial

stream-tutorial/%:
	labctl content push tutorial -f -w $* -d $(TUTORIALS_DIR)/$*/
.PHONY: push-stream-tutorial/%

### Vendors

VENDORS_DIR = $(MANIFESTS_DIR)/vendors
VENDOR_IDS = uncloud

pull-vendors:
	@mkdir -p $(VENDORS_DIR)
	@for vendor in $(VENDOR_IDS); do \
		echo '---'; \
		labctl content pull vendor $$vendor -f -d $(VENDORS_DIR)/$$vendor; \
	done
.PHONY: pull-vendors

push-vendors:
	@for vendor in $(VENDOR_IDS); do \
		echo '---'; \
		labctl content push vendor $$vendor -f -d $(VENDORS_DIR)/$$vendor/ && \
		echo ">>> Pushed vendor: $$vendor"; \
	done
.PHONY: push-vendors

stream-vendor/%:
	labctl content push vendor -f -w $* -d $(VENDORS_DIR)/$*/
.PHONY: stream-vendor/%

IXIMIUZ_LABS_DIR = vendor/iximiuz-labs

download-iximiuz-rules:
	@mkdir -p $(IXIMIUZ_LABS_DIR)
	@if [ -d "$(IXIMIUZ_LABS_DIR)/.git" ]; then \
		echo ">>> Pulling latest changes from iximiuz/labs..."; \
		cd $(IXIMIUZ_LABS_DIR) && git pull; \
	else \
		echo ">>> Cloning iximiuz/labs repository..."; \
		git clone https://github.com/iximiuz/labs.git $(IXIMIUZ_LABS_DIR); \
	fi
	@echo ">>> Downloaded iximiuz/labs to $(IXIMIUZ_LABS_DIR)"
.PHONY: download-iximiuz-rules
