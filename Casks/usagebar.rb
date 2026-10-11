cask "usagebar" do
  version "0.8.2,19"
  sha256 "fb3340eb7f0cadf595ccd0e85a85930a6e490594e701a1257dfdfe836f7e8954"

  url "https://github.com/hyjoong/UsageBar/releases/download/v#{version.csv.first}/UsageBar-#{version.csv.first}-#{version.csv.second}.zip"
  name "UsageBar"
  desc "Claude Code and Codex subscription limits in the menu bar, with work receipts"
  homepage "https://github.com/hyjoong/UsageBar"

  livecheck do
    url :url
    strategy :github_latest
    regex(/UsageBar[._-]v?(\d+(?:\.\d+)+)[._-](\d+)\.zip/i)
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "UsageBar.app"

  zap trash: [
    "~/Library/Application Support/UsageBar",
    "~/Library/Caches/dev.hyjoong.usagebar",
    "~/Library/HTTPStorages/dev.hyjoong.usagebar",
    "~/Library/Preferences/dev.hyjoong.usagebar.plist",
    "~/Library/Preferences/UsageBar.Preferences.plist",
  ]
end
