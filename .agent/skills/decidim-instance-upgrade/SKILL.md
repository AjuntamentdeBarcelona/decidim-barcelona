---
name: decidim-instance-upgrade
description: "Step-by-step procedure for upgrading decidim in a decidim instance, covering release notes of every intermediate version, Gemfile, third-party and local modules, overrides checksums, initializers, runtime/CI versions, dependency updates, verification and the pull request. Use whenever the user asks to bump, update or upgrade decidim, or when preparing a branch for a new decidim release."
---

# Upgrading decidim

## 1. Research (no edits yet)

1. Read the release notes and the `CHANGELOG.md` of **every version** after the current one up to the target, in order, not only the target. For example, upgrading from 0.28.2 to 0.28.5 means reading 0.28.3, 0.28.4 and 0.28.5, and upgrading from 0.28.x to 0.29.2 means reading 0.29.0, 0.29.1 and 0.29.2.

   Sources: `https://github.com/decidim/decidim/releases/tag/vX.Y.Z` and `https://github.com/decidim/decidim/blob/vX.Y.Z/CHANGELOG.md`. Collect every "Upgrade notes" item (commands, rake tasks, migrations, config changes, removed features) into one ordered list; it drives step 3.

2. Note required Ruby, Node and bundler versions for the target (decidim's `.ruby-version`, `.node-version`, `Gemfile.lock` `BUNDLED WITH`). Treat them as a minimum: if the instance is already on a newer compatible version, keep it and never downgrade.
3. For every third-party decidim module in the `Gemfile`, check whether a release or branch compatible with the target exists. If not, find an upgrade branch or PR and flag it.
4. Collect every override in `spec/lib/overrides_spec.rb` whose comment links an upstream PR or issue and classify it:
   - Backports of a decidim PR: check whether the PR is included in the target release. If it is, the override can be deleted.
   - Reverts of a decidim PR: they are deliberate and stay. Only re-check that they still apply.
   - Waiting on a third-party module fix: check whether the module version chosen in the previous step includes it.

## 2. Gemfile and local modules

1. `Gemfile`: set `DECIDIM_VERSION` to the released version (e.g. `"0.32.2"`). Point third-party modules to their compatible release or branch.
2. Local modules (gems loaded with `path:` from this repo), if any: bump the decidim dependency ranges in their gemspecs when the minor version changes (e.g. `~> 0.32.0`).

## 3. Apply the upgrade notes

Run the items collected in step 1.1, version by version, in order (bundle/npm install, migrations, rake tasks, config changes...).

## 4. Overrides

Follow the `decidim-overrides` skill. In short:

1. `bundle exec rspec spec/lib/overrides_spec.rb`: every failure is a gem file that changed upstream.
2. For each one, diff the gem file between the old and new tag, port the relevant upstream change into the app copy or concern, then update the MD5.
3. Delete overrides that are no longer needed (backport landed, bug fixed upstream): the concern or view copy, its wiring in `config/initializers/decidim_overrides.rb`, its spec, and its checksum entry.
4. Also handle overridden files that were **renamed or removed** upstream (the spec fails with a missing file).
5. Grep `app/` for methods and constants removed upstream that our views or concerns still call.

## 5. Configuration

1. Boot the app (`bin/rails runner 'puts :ok'`) and fix initializer errors. Audit all initializers at once instead of fixing one error per boot. When a setting is reported as removed, date the removal against the `release/*-stable` branches instead of trusting the error message: it may have been a silent no-op for several versions.
2. Compare `config/initializers/decidim.rb`, `config/environments/production.rb`, `config/storage.yml` and `config/application.rb` with the decidim app generator templates for the target version and port relevant changes.
3. New or renamed ENV vars: list them for the report.

## 6. Runtime versions (when Ruby or Node change)

Keep these in sync:

- `.ruby-version`, `.node-version`
- `Dockerfile`, if present (base image, Node version, bundler version, system packages)
- `RUBY_VERSION` / `NODE_VERSION` and `runs-on` in all `.github/workflows/*.yml`
- `engines` in `package.json` (Node and npm)

## 7. Dependency updates

1. If Dependabot is enabled on the GitHub repository (it can be enabled in the repository settings without a `.github/dependabot.yml`), review its open alerts and PRs.
2. Update every gem and npm package that can be updated **changing only `Gemfile.lock` and `package-lock.json`**: `bundle update --conservative <gems>`, `npm update <packages>`. Do not touch `Gemfile` or `package.json` for this.
3. Some dependencies are constrained by decidim and cannot be updated until decidim does. Leave them and list them for the report.
4. Write down every dependency updated (from/to version) and the open issues this PR fixes, for the PR description (step 10).

## 8. Verification

1. `bundle exec rspec spec/lib/overrides_spec.rb` green.
2. Run the same spec commands as the CI test workflows (read `.github/workflows/` to see which). `bundle exec rspec` alone only covers the root `spec/`; local modules usually have their own run (e.g. `bundle exec rspec <module-dir>`).
3. Run the same linters as the CI lint workflow (read `.github/workflows/` to see which).
4. Assets compile (`bin/shakapacker`).
5. Smoke test in the browser on the most customized areas (the ones with overrides) and on every third-party module.

## 9. Report

Report to the user:

- Versions: decidim from/to, Ruby/Node/bundler if changed, third-party modules.
- Gems still pointing to a git branch instead of a released version (e.g. a module without a release compatible with the target yet), so they can be moved to a release later.
- Overrides updated, removed (with the upstream PR that made them unnecessary) and added.
- Config and ENV changes.
- Dependencies that could not be updated because decidim constrains them.
- What was not verified.

## 10. Pull request

Propose a title and description, and keep both simple.

- Title: `Bump decidim from <current> to <target>`.
- Description: use the repository PR template if there is one (`.github/PULL_REQUEST_TEMPLATE.md` or `.github/PULL_REQUEST_TEMPLATE/`), dropping the sections that do not apply. Short bullets, grouped only when there are several kinds of changes:
  - The decidim bump and anything notable it brought (e.g. a source change, a replaced library).
  - Overrides removed because upstream now ships them (with the upstream PR) and new overrides (with why and when to remove them). Checksum-only updates do not need detail.
  - Dependency updates (from/to version).
  - One-time tasks added by us, with one line on what they do.
- Related issues: one line per open issue this PR fixes, using the template's keyword if it has one (e.g. `Fixes #ID`), otherwise `Closes #ID`.
- One-time actions, if any: commands to run before deployment (e.g. install a new Ruby version or system packages) and after deployment (upgrade rake tasks, `data:migrate`), in order.
