# uncloud-playgrounds

Playground and tutorial configurations for [iximiuz Labs](https://labs.iximiuz.com/) that showcase [Uncloud](https://uncloud.run) functionality.

## Root Filesystem Images

This repository builds the following rootfs images in the form of Docker images:

- **uncloud-devmachine**: Development environment with Docker and Uncloud CLI

  - `ghcr.io/tonyo/uncloud-playgrounds/rootfs:uncloud-devmachine`

- **uncloud-server**: Server environment with Docker and Uncloud server components

  - `ghcr.io/tonyo/uncloud-playgrounds/rootfs:uncloud-server`

These images can

### Image Repository

All images are published to [`ghcr.io/tonyo/uncloud-playgrounds/rootfs`](https://github.com/tonyo/uncloud-playgrounds/pkgs/container/uncloud-playgrounds%2Frootfs) with the corresponding tags.

## Development

### Prerequisites

- Docker
- Make

### Building and Pushing Images

```bash
# Build
make build-uncloud-devmachine
make build-uncloud-server

# Build and Push
make push-uncloud-devmachine
make push-uncloud-server

```

## Playground Management

### Managed Playgrounds

Currently managed playgrounds:

- [Uncloud Cluster](https://labs.iximiuz.com/playgrounds/uncloud-cluster-64523f7c)

### Persisting Manifests

Prerequisites:

- [labctl](https://github.com/iximiuz/labctl)

You can save the manifests of all the managed playgrounds locally to [`manifests/`](./manifests/) directory:

```bash
make pull-playgrounds
```

This is currently done purely for backup and version tracking reasons.
