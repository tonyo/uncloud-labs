# uncloud-labs

Playground and tutorial configurations for [iximiuz Labs](https://labs.iximiuz.com/) that showcase [Uncloud](https://uncloud.run) functionality.

## Root Filesystem Images

This repository builds the following rootfs images in the form of Docker images:

- **rootfs-images/uncloud-devmachine**: Development environment with Docker and Uncloud CLI
  - `ghcr.io/unlabs-dev/uncloud-labs/rootfs:uncloud-devmachine`

- **rootfs-images/uncloud-server**: Server environment with Docker and Uncloud server components
  - `ghcr.io/unlabs-dev/uncloud-labs/rootfs:uncloud-server`

- **rootfs-images/uncloud-django-app**: Development environment for the Django app tutorial
  - `ghcr.io/unlabs-dev/uncloud-labs/rootfs:uncloud-django-app`

These images can

### Image Repository

All images are published to [`ghcr.io/unlabs-dev/uncloud-labs/rootfs`](https://github.com/unlabs-dev/uncloud-labs/pkgs/container/uncloud-labs%2Frootfs) with the corresponding tags.

## Development

### Prerequisites

- Docker
- Make

### Building and Pushing Images

```bash
# Build
make build-img-uncloud-devmachine
make build-img-uncloud-server
make build-img-uncloud-django-app

# Build and Push
make push-img-uncloud-devmachine
make push-img-uncloud-server
make push-img-uncloud-django-app

```

Each image is tagged both as `<image>` (floating) and `<image>-<UNCLOUD_VERSION>`
(pinned — this is the tag playground manifests reference directly). If you
need to push an updated image (Dockerfile fix, dependency bump, etc.)
without changing `UNCLOUD_VERSION`, bump `BUILD_SUFFIX` in the [`Makefile`](./Makefile)
and commit it, so the pinned tag changes too. Then repoint the relevant
`manifests/playgrounds/*.yaml` entries at the new tag, e.g.:

```bash
# Makefile: BUILD_SUFFIX = 2
make push-img-uncloud-django-app
# => pushes rootfs:uncloud-django-app-v0.20.0-2
```

## Material Management

This section covers the management of playgrounds and tutorials hosted on iximiuz Labs.

### Prerequisites

- [labctl](https://github.com/iximiuz/labctl) - CLI tool for managing iximiuz Labs content

### Managed Tutorials

Currently managed tutorials:

- [Create an Uncloud Cluster](https://labs.iximiuz.com/tutorials/uncloud-create-cluster-ebebf72b) - `manifests/tutorials/uncloud-create-cluster-ebebf72b/`
- [Deploy a Django App with Uncloud](https://labs.iximiuz.com/tutorials/uncloud-deploy-django-app-7a378bc3) - `manifests/tutorials/uncloud-deploy-django-app-7a378bc3/`

### Managed Playgrounds

Currently managed playgrounds:

- [Initialized Uncloud Cluster](https://labs.iximiuz.com/playgrounds/uncloud-cluster-64523f7c) - `manifests/playgrounds/uncloud-cluster-64523f7c.yaml`
- [Uninitialized Uncloud Cluster](https://labs.iximiuz.com/playgrounds/uncloud-uninitialized-cluster-cacb63ae) - `manifests/playgrounds/uncloud-uninitialized-cluster-cacb63ae.yaml`

### Persisting Manifests

You can save the manifests of all managed playgrounds and tutorials locally to the [`manifests/`](./manifests/) directory:

```bash
make pull-playgrounds
```

This is currently done purely for backup and version tracking reasons. The manifests are organized as:

- `manifests/playgrounds/` - YAML files for playground configurations
- `manifests/tutorials/` - Markdown files and assets for tutorial content
