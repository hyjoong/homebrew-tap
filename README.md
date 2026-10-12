# hyjoong/homebrew-tap

Homebrew casks for apps by [hyjoong](https://github.com/hyjoong).

```sh
brew install --cask hyjoong/tap/usagebar
```

| Cask | App |
| --- | --- |
| `usagebar` | [UsageBar](https://github.com/hyjoong/UsageBar): Claude Code and Codex subscription limits in the menu bar, with work receipts. |

Updating: bump `version` and `sha256` in `Casks/usagebar.rb` to the values of the new release ZIP (see `SHA256SUMS.txt` in the UsageBar release output).

Run the architecture regression tests on macOS with Homebrew installed:

```sh
brew ruby tests/usagebar_arch_test.rb
```

The tests exercise Homebrew's cask loader and installer architecture check for native Apple Silicon, Rosetta Homebrew on Apple Silicon, and Intel hardware. They do not download or install the app.
