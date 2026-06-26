# Contributor Guidelines

:honeybee: Please read this document before beginning any implementation. We use a
set of guidelines that should be followed. :honeybee:

Repository-wide conventions (language, public-repo rules, release automation,
test naming) live in [AGENTS.md](AGENTS.md) — read it first; this document
focuses on the contribution workflow.

## DOs and DON'Ts

- **DO** give priority to the current style of the project or file you're changing
  even if it diverges from the general guidelines
- **DO** include tests when adding new features. When fixing bugs, start with a
  test that highlights how the current behavior is broken
- **DO** keep discussions focused. When a new or related topic comes up it's often
  better to open a new issue than to side-track the discussion
- **DO NOT** make PRs for style-only changes
- **DO NOT** surprise us with big pull requests. Instead, open an issue and start a
  discussion so we can agree on a direction before you invest a large amount of time
- **DO NOT** add public API/configuration changes without opening an issue and
  discussing with us first

## Workflow

We follow a **trunk-based / GitHub Flow** model:

1. Branch off `main` (the default branch) into a short-lived branch.
2. Open a pull request back into `main` when the work is ready for review.
3. The PR is merged via **squash merge** after review and a green CI run.

There are no long-lived `develop`, `release`, or `hotfix` branches.

### Branching

Use a short, descriptive branch name prefixed with the change type, e.g.:

- `feat/<short-description>`
- `fix/<short-description>`
- `chore/<short-description>`
- `docs/<short-description>`

## Commits & Pull Requests

Versioning and the changelog are automated by
[release-please](https://github.com/googleapis/release-please) from
[Conventional Commits](https://www.conventionalcommits.org/). Commit messages are
validated in CI by [commitlint](https://commitlint.js.org/), and the same format
applies to the PR title. See
[AGENTS.md](AGENTS.md#commit-message-format) for the exact format and the
version-bump rules.

Because **only squash merges are allowed, the PR title becomes the commit message
that drives the release**, so it MUST follow Conventional Commits:

- ✅ `feat: validate config.url as an RFC 3986 path`
- ✅ `fix: prepend service path only when present`
- ❌ `Fix #1234` / `Improves coverage by 10%`

Additional guidelines:

- **DO NOT** submit "work in progress" PRs. Open a PR only when it is ready for
  review and subsequent merging.
- **DO** tag any users that should know about and/or review the change.
- **DO** submit all code changes via pull requests rather than direct commits. PRs
  are reviewed and merged by maintainers after a peer review including at least one
  maintainer.
- **DO** ensure CI is green. The entire PR must pass all tests before it is merged.
- **DO NOT** mix independent, unrelated changes in one PR. Separate unrelated fixes
  into separate PRs.
- **DO** address PR feedback in additional commits rather than amending existing
  ones — it makes review easier. Everything is squashed on merge anyway.

## Testing

We use [Kong Pongo](https://github.com/Kong/kong-pongo) to run our tests. Every
test file lives in the `spec/` folder, ends with `_spec.lua`, and follows the
naming convention described in [AGENTS.md](AGENTS.md#test-file-naming-convention)
(`01-unit_*`, `02-integration_*`, `03-functional_*`).

### Running the tests

```bash
make test     # pongo run -- -t unit
pongo run     # full suite, as in CI
```

### Test coverage

```bash
pongo run -- --coverage
```

We'd like to keep coverage at a minimum of 60%, with 90% as the desirable target.

## Lint

Linting is done with [luacheck](https://github.com/lunarmodules/luacheck), run
through Pongo:

```bash
make lint     # pongo lint
```

## Adding External Library Dependencies

- Add new dependencies ONLY IF STRICTLY NECESSARY. Adding dependencies is easy, but
  it increases the build time and the maintenance surface of the plugin.

## Guiding Principles

- We allow anyone to participate in our projects. Tasks can be carried out by anyone
  who demonstrates the capability to complete them.
- Always be respectful of one another. Assume the best in others and act with empathy
  at all times.
- Collaborate closely with the people maintaining the project. Getting ideas out in
  the open before a pull request reduces redundancy and keeps everyone connected to
  the decision-making process.
- Don't be a jerk.
