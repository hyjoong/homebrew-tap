cask "usagebar" do
  version "0.8.15,33"
  sha256 "e9338a67161045a4098599c3ffabae602d1f2f28eb051f25fdfdf150dc53d39e"

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
  # Rosetta reports Intel even though the Mac can run the arm64 app.
  depends_on arch: :arm64 unless Hardware::CPU.in_rosetta2?
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
