# Testing a Playground End-to-End with `labctl`

Use `labctl` to spin up a real playground instance and validate tutorial
changes against an actual Uncloud cluster, instead of guessing at CLI
output.

## Steps

1. **Start a playground session** from its manifest name (see
   `playground.name` in the tutorial's frontmatter, or the file name
   under `manifests/playgrounds/`):

   ```sh
   labctl playground start <playground-name>
   # => New <playground-name> playground started with ID <run-id>
   ```

2. **Wait for init tasks** to finish:

   ```sh
   labctl playground wait <run-id>
   ```

3. **Copy locally-edited files** onto a target machine, overwriting the
   versions baked into the rootfs image, so you can test uncommitted
   changes without rebuilding/publishing that image:

   ```sh
   labctl cp path/to/local/Dockerfile <run-id>:./app/Dockerfile -m dev-machine
   labctl cp path/to/local/compose.yaml <run-id>:./app/compose.yaml -m dev-machine
   ```

   Use `-m <machine-name>` to target a machine (see the tabs in the
   playground manifest, e.g. `dev-machine`, `server-1`). Avoid `~` in
   the remote path — your local shell expands it before `labctl` sees it.

4. **Run commands** with `labctl ssh <run-id> --machine <name> -- <cmd>`.
   Gotchas:
   - `uc deploy` resolves `compose.yaml` (and `build: .` inside it)
     relative to the current directory; there's no `--chdir`, so `cd`
     first or pass `-f app/compose.yaml`.
   - Quoting through `labctl ssh -- ...` is unreliable for anything with
     nested quotes/pipes. Write a small script, `labctl cp` it over, then
     run it instead of inlining complex commands.
   - `uc`'s tree/spinner UI only renders with a real terminal; plain
     `labctl ssh` runs fall back to an uglier plain-output mode. To
     capture the real rendering, force a sized pty:
     ```sh
     labctl ssh <run-id> --machine <name> -- \
       script -qec "stty cols 140 rows 50; uc deploy --yes" /tmp/out.log
     ```
     then replay the captured escape sequences with a terminal emulator
     library (e.g. Python's `pyte`) rather than reading raw ANSI bytes.

5. **Verify actual behavior** — `uc ls`, `uc inspect <service>`,
   `uc logs <service>`, and a `curl` against the app (with the right
   `Host` header) — not just that commands exited 0.

6. **Clean up**:

   ```sh
   labctl playground destroy <run-id>
   ```

   Playgrounds also auto-expire (`labctl playground list` shows the
   countdown), but destroying explicitly avoids leftover test sessions.
