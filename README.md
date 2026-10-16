# hyjoong/homebrew-tap

Homebrew casks for apps by [hyjoong](https://github.com/hyjoong).

```sh
brew install --cask hyjoong/tap/usagebar
```

| Cask | App |
| --- | --- |
| `usagebar` | [UsageBar](https://github.com/hyjoong/UsageBar): Claude Code and Codex subscription limits in the menu bar, with work receipts. |

Updating: the **Bump UsageBar cask** workflow checks the latest UsageBar release every hour. When its version, build or checksum differs from the cask, it downloads the ZIP, verifies the checksum, the app's versions, the Developer ID signature and the notarization ticket, runs the tests below, and commits the new `version` and `sha256`. It refuses a build that fails any check. To run it now, or to rehearse it without committing:

```sh
gh workflow run bump-usagebar.yml -R hyjoong/homebrew-tap
gh workflow run bump-usagebar.yml -R hyjoong/homebrew-tap -f verify_only=true
```

A manual bump still works; the workflow then finds the cask current and does nothing.

Run the architecture regression tests on macOS with Homebrew installed:

```sh
brew ruby tests/usagebar_arch_test.rb
```

The tests exercise Homebrew's cask loader and installer architecture check for native Apple Silicon, Rosetta Homebrew on Apple Silicon, and Intel hardware. They do not download or install the app.
