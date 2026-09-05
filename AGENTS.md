# Guidelines for AI Agents Writing Tutorials

This document provides concise guidelines for AI agents creating tutorials for the uncloud-labs repository. Based on principles from [Refactoring English: Rules for Software Tutorials](https://refactoringenglish.com/chapters/rules-for-software-tutorials/).

## About This Repository

This repository (`uncloud-labs`) contains playground and tutorial configurations for [iximiuz Labs](https://labs.iximiuz.com/) that showcase [Uncloud](https://uncloud.run) functionality.

### What is iximiuz Labs?

[iximiuz Labs](https://labs.iximiuz.com/) is an interactive learning platform that provides hands-on playground environments for exploring cloud-native technologies, containers, Kubernetes, and related tools. Users can spin up pre-configured environments directly in their browser to practice and learn without local setup.

### Repository Purpose

This repository serves two main purposes:

1. **Rootfs Images**: Builds and publishes Docker images that serve as root filesystem images for iximiuz Labs playgrounds:
   - `rootfs-images/uncloud-devmachine`: Development environment with Docker and Uncloud CLI
   - `rootfs-images/uncloud-server`: Server environment with Docker and Uncloud server components

2. **Tutorial Content**: Houses tutorial configurations and content that guide users through various Uncloud features and use cases within the interactive Labs environment.

### Target Audience

Tutorials in this repository are designed for users learning about:

- [Uncloud](https://uncloud.run): A platform for running cloud infrastructure
- Container orchestration and management
- Cloud-native development workflows
- Docker and containerization concepts

When creating tutorials, assume users are accessing them through iximiuz Labs playgrounds where the environment is pre-configured with the necessary tools and images from this repository.

## Core Principles

### 1. Write for Beginners

- Avoid expert-level terminology when explaining beginner concepts
- Don't use jargon, abbreviations, or terms meaningless to newcomers
- Experienced readers can skip familiar content; beginners cannot read expert guides

### 2. Promise a Clear Outcome in the Title

- Make titles specific and actionable
- ❌ Bad: "A Complete Guide to Becoming a Python CSV Ninja"
- ✅ Good: "How to Read a CSV File in Python"

### 3. Explain the Goal in the Introduction

- Answer immediately: "Should I care?" and "Is this the right tutorial for me?"
- Explain what problem the technology solves
- Show who should use it and what they'll learn

### 4. Show the End Result Early

- Include a working demo or screenshot of the final product
- Reduces ambiguity about the goal
- Helps readers confirm this is the right tutorial

## Code Snippets

### 5. Make Code Copy/Pasteable

- Chain commands with `&&` and use backslashes for multi-line
- Use non-interactive flags (e.g., `--yes` for apt)
- Only include shell prompt characters (`$`, `>`) in code blocks when demonstrating command output
- Exclude line numbers from copyable text
- Use `sh` language for code snippets, not `bash`

```sh
# Good: Copy/pasteable
sudo apt update && \
  sudo apt install --yes software-properties-common && \
  sudo apt install --yes python3.9
```

### 6. Use Long Command-Line Flags

- Always use verbose flags for clarity
- ❌ Bad: `grep -i -o -m 2 -r '<span>' ./`
- ✅ Good: `grep --ignore-case --only-matching --max-count=2 --recursive '<span>' ./`

### 7. Separate User-Defined Values

- Use environment variables in shell examples
- Use named constants in source code
- Make it obvious which values users must replace

```sh
# Good: Clear separation
API_TOKEN='pk-example-key'  # Replace with your API key
START_DATE='2024-01-01'     # Replace with desired start date

curl --header "X-Example-Token: $API_TOKEN" \
  "http://api.example.com"
```

### 8. Use Unambiguous Example Values

- Choose values that look like real-world data
- ❌ Bad: `username = User('user')`, `message = string('string')`
- ✅ Good: `username = User('mike1234')`, `message = string('Hello, world!')`
- Avoid values that could be mistaken for keywords

## Tutorial Structure

### 9. Spare the Reader from Mindless Tasks

- Don't force tedious interactive steps when a script would work
- ❌ Bad: "Run `sudo nano /etc/hostname`, erase the content, type..."
- ✅ Good: `echo 'awesomecopter' | sudo tee /etc/hostname`

### 10. Keep Code in a Working State

- Never reference undefined functions or variables
- Show working examples as early as possible
- Use stub implementations if needed
- Give readers confidence they're on the right track

### 11. Teach One Thing

- Focus on a single concept
- Don't mix unrelated technologies
- If you must combine technologies, defer to the end

### 12. Don't Try to Look Pretty

- Keep demo UIs simple and style-agnostic
- Avoid unnecessary CSS or styling frameworks
- Readers care about learning, not beautiful toy apps

### 13. Minimize Dependencies

- Every dependency reduces completion chances
- Don't use 400 MB libraries to parse simple date strings
- Pin dependencies to specific versions
- ❌ Bad: "Install a stable version of Node.js"
- ✅ Good: "Install Node.js 22.x. I tested on v22.12.0 (LTS)"

## Documentation Quality

### 14. Specify Filenames Clearly

- Always provide full file paths
- Show exactly which line to edit
- ❌ Bad: "Add this to your config file"
- ✅ Good: "Add to `frontend/webpack.config.js` under `module.exports`"

### 15. Use Consistent, Descriptive Headings

- Write clear headings that communicate content
- Check consistency in: casing, point of view, verb tense
- Create logical hierarchy
- Help readers skim and assess difficulty

### 16. Demonstrate That It Works

- Show how to use the installed tool
- Include expected output or screenshots
- Don't end with "Congratulations, you're done!" without verification

### 17. Link to Complete Examples

- Provide a repository with all code
- Ideally with CI/CD demonstrating it builds
- Bonus: Use git branches to show state at each tutorial step

## Quick Reference Checklist

Before publishing a tutorial, verify:

- [ ] Title promises a clear, specific outcome
- [ ] Introduction explains the problem and target audience
- [ ] End result shown early (screenshot/demo)
- [ ] All code snippets are copy/pasteable
- [ ] Command-line flags use long versions
- [ ] User-defined values clearly separated
- [ ] Example values look like real data
- [ ] Code stays in working state throughout
- [ ] Focuses on one concept
- [ ] Dependencies minimized and pinned
- [ ] Filenames specified with full paths
- [ ] Headings are consistent and descriptive
- [ ] Solution demonstrated to work
- [ ] Complete example linked

---

_Based on [Refactoring English: Rules for Software Tutorials](https://refactoringenglish.com/chapters/rules-for-software-tutorials/) by Michael Lynch_

## Miscellaneous

- `tagz` in YAML frontmatter is NOT a typo, do NOT try to fix it.

## Other Skills and Rules

Check `vendor/iximiuz-labs/content-samples/claude/CLAUDE.md` for additional instructions.

Additional skills are located in `vendor/iximiuz-labs/content-samples/claude/skills/`

## Troubleshooting

If you need to validate a tutorial/playground change end-to-end (e.g. `labctl` usage, `uc deploy` quirks, capturing real CLI output), see
`docs/testing-playgrounds-with-labctl.md`. Only read it when you're actually troubleshooting this kind of issue — skip it otherwise.
