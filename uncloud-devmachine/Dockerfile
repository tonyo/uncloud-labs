FROM ghcr.io/iximiuz/labs/rootfs:ubuntu-docker

# Update Docker to latest stable
RUN --mount=type=bind,source=scripts,target=/tmp/scripts sudo /tmp/scripts/install-docker.sh

RUN curl -fsS https://get.uncloud.run/install.sh | sudo sh
