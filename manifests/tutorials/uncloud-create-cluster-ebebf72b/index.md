---
kind: tutorial

title: Creating a New Uncloud Cluster

description: |
  This is a description

categories:
  - linux
  - containers

tagz:
  - uncloud

createdAt: 2025-12-02
updatedAt: 2025-12-02

cover: __static__/cover.png

# Uncomment to embed (one or more) challenges.
# challenges:
#   challenge_name_1: {}
#   challenge_name_2: {}

# Uncomment to add (one or more) background tasks.
# tasks:
#   init_task_1:
#     init: true
#     run: ...
#   regular_task_1:
#     run: ...
playground:
  name: uncloud-uninitialized-cluster-cacb63ae
---

Docs: [How to Author Tutorials on iximiuz Labs](/tutorials/sample-tutorial)

# WIP

TODO: intro words, motivation, expand the section

Let's create a new Uncloud cluster.

You are currently on the developer machine.

Uncloud CLI (`uc` for short) is already installed (check out https://uncloud.run/docs/getting-started/install-cli for instructions)

## Initializing new cluster

```bash
uc machine init laborant@server-1 --no-dns --public-ip none
```

This will install Docker, corrosion, etc.

TODO: explain why '--no-dns' and '--public-ip none' are used here

You can get the list of machines in the cluster along with their configuration and status via `uc machine ls` (or `uc m ls`, if you want to save a few keystrokes) command:

```bash
laborant@dev-machine:~$ uc machine ls
NAME           STATE   ADDRESS         PUBLIC IP        WIREGUARD ENDPOINTS                      MACHINE ID
machine-incv   Up      10.210.0.1/24   -                172.16.0.3:51820, 65.109.107.161:51820   6cec579e3d6fb7ffb51c5503d163f1be
```

## Adding another machine to cluster

One initialized server is not really a cluster, right?

Let's add the second machine (`server-2`) to the cluster. The command is quite similar, the main difference is that we use `add` instead of `init`:

```bash
uc machine add laborant@server-2
```

Similar to `server-1`, `server-2` now has all the important components (Docker, Uncloud daemon, etc.) up and running.

Let's check the current state of the cluster:

```bash
laborant@dev-machine:~$ uc machine ls
NAME           STATE   ADDRESS         PUBLIC IP        WIREGUARD ENDPOINTS                      MACHINE ID
machine-incv   Up      10.210.0.1/24   -                172.16.0.3:51820, 65.109.107.161:51820   6cec579e3d6fb7ffb51c5503d163f1be
machine-m4wy   Up      10.210.1.1/24   -                172.16.0.4:51820, 65.109.107.161:51820   e84e115eff8570ecccc54947aa482f5c
```

Our cluster now consists of two nodes.

## Renaming cluster machines

By default, cluster nodes are assigned internal names with randomized suffixes such as `machine-incv` or `machine-m4wy`.
It is possible to override those names by using `-n/--name` option during `add` or `init` steps.

You can also rename the cluster nodes via `uc machine rename` command, for example:

```bash
laborant@dev-machine:~$ uc machine rename machine-incv s1
Machine "machine-incv" renamed to "s1" (ID: 42866c05a37171dbbc1165216e8f886e)
laborant@dev-machine:~$ uc machine rename machine-m4wy s2
Machine "machine-m4wy" renamed to "s2" (ID: 4c453ff7a1c870456cfd69f78e74a34a)
laborant@dev-machine:~$ uc machine ls
NAME   STATE   ADDRESS         PUBLIC IP        WIREGUARD ENDPOINTS                      MACHINE ID
s1     Up      10.210.0.1/24   -                172.16.0.3:51820, 65.109.107.161:51820   42866c05a37171dbbc1165216e8f886e
s2     Up      10.210.1.1/24   -                172.16.0.4:51820, 65.109.107.161:51820   4c453ff7a1c870456cfd69f78e74a34a

```

## Context management and connections

It is possible to manage more than one cluster from a single control node: Uncloud CLI client has context support,
letting you as user switch between them when necessary.

`uc ctx` is the subcommand used for context management; here's how you can list all available contexts on your control node:

```bash
laborant@dev-machine:~$ uc ctx ls
NAME      CURRENT   CONNECTIONS
default   ✓         2
```

As we see, only one context (`default`) is available and it is set as the current context (it will be used by default when the commands you run do not include `--context` option).
The output also says that the context has two connections. This means that the current configuration is aware of two nodes in the corresponding cluster, and knows how to connect to either of them.

To view the full context configuration including connection information, you can check the generated configuration file which is by default placed in `~/.config/uncloud/config.yaml` on your control node:

```yaml
laborant@dev-machine:~$ cat ~/.config/uncloud/config.yaml
current_context: default
contexts:
  default:
    connections:
      - ssh: laborant@server-1
        ssh_key_file: ~/.ssh/id_ed25519
      - ssh: laborant@server-2
        ssh_key_file: ~/.ssh/id_ed25519
```

TODO: add a note that a cluster might have one or more connections, and that every node can have more than one connection associated with it.

## Running a simple service

TODO: running a simple excalidraw service and accessing it via HTTP tab.
