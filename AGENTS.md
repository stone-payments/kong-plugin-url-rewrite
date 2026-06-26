# Repository Guidelines

Conventions for anyone — humans or AI agents — contributing to this repository.
For the broader contribution workflow, see [CONTRIBUTING.md](CONTRIBUTING.md).

## Language

This is a **public repository**. All commits, code comments, PR titles, and PR
descriptions MUST be written in **English**.

## Public repository — do not leak internal information

Because the repository is public, never expose anything internal in commits,
code comments, or PR titles/descriptions, including (but not limited to):

- Jira task keys or links
- Internal initiatives, roadmaps, or project codenames
- Internal URLs, hostnames, dashboards, or service names
- Employee names tied to internal context, or any other confidential data

Describe changes purely in terms of the public plugin's behavior.

## Releases & commit messages

Releases are automated by [release-please](https://github.com/googleapis/release-please),
which derives the next version and the changelog from
[Conventional Commits](https://www.conventionalcommits.org/).

**Only squash merges are allowed.** On a squash merge the **PR title becomes the
commit message**, so the PR title is what drives the version bump. Get it right:

| PR title prefix              | Version bump | Example                                         |
| ---------------------------- | ------------ | ----------------------------------------------- |
| `fix: ...`                   | patch        | `fix: prepends service path only when present`   |
| `feat: ...`                  | minor        | `feat: validates config.url as an RFC 3986 path` |
| `feat!: ...` / `fix!: ...`   | major        | `feat!: requires config.url to start with a /`   |
| `BREAKING CHANGE:` in body   | major        | breaking change footer in the squash body        |
| `chore:`, `docs:`, `test:` … | no release   | `docs: documents placeholder syntax`             |

When a change is backwards-incompatible (e.g. a config field becomes stricter),
mark it as breaking (`!` or a `BREAKING CHANGE:` footer) so release-please bumps
the major version.

### Commit message format

Commit messages MUST follow [Conventional Commits](https://www.conventionalcommits.org/).
This is enforced in CI by [commitlint](https://commitlint.js.org/) on every commit
of a pull request, and the same rules apply to the PR title (the squash commit
message).

```
<type>[optional scope][!]: <description>

[optional body]

[optional footer(s)]
```

- **type** — one of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`,
  `build`, `ci`, `chore`, `revert`.
- **description** — start with a **present-tense, third-person-singular verb** so
  the subject reads as the answer to "what does this do?" (e.g. "adds", "fixes",
  "validates" — not "add"/"added"). Keep it lower-case with no trailing period;
  the squashed PR title is what lands in the changelog.
- **breaking change** — append `!` after the type/scope **or** add a
  `BREAKING CHANGE: <explanation>` footer.

Examples:

```
feat: validates config.url as an RFC 3986 path
fix(handler): prepends the service path only when present
docs: documents the query_string configuration field
feat!: requires config.url to start with a forward slash
```

## Testing

Tests run with [Kong Pongo](https://github.com/Kong/kong-pongo):

```bash
make test          # pongo run -- -t unit
pongo run          # full suite, as in CI
```

### Test file naming convention

Every test file lives in `spec/` and ends with `_spec.lua`. The numeric prefix
marks its category:

- `01-unit_*_spec.lua` — unit tests (isolated functions/modules)
- `02-integration_*_spec.lua` — integration tests
- `03-functional_*_spec.lua` — functional / end-to-end tests

Add new tests when introducing features, and start bug fixes with a test that
reproduces the broken behavior.
