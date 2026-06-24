cask "darktable" do
  arch arm: "arm64", intel: "x86_64"

  version "5.6.0"
  sha256 arm:   "49aec447e891ab481e436b4c0231fc3c8d0001aad220762ae8e765d3bda5d102",
         intel: "24c83655af0d81c2f8cb78b97531a03bb6a650349b7fd49c1679080db675cbcb"

  url "https://github.com/darktable-org/darktable/releases/download/release-#{version}/darktable-#{version}-#{arch}.dmg",
      verified: "github.com/darktable-org/darktable/"
  name "darktable"
  desc "Photography workflow application and raw developer"
  homepage "https://www.darktable.org/"

  livecheck do
    url "https://github.com/darktable-org/darktable"
    strategy :github_latest
    regex(/release[._-](\d+(?:\.\d+)+)/i)
  end

  depends_on :macos

  app "darktable.app"

  postflight do
    system "/usr/bin/xattr", "-drs", "com.apple.quarantine", "#{appdir}/darktable.app"
    system "/usr/bin/codesign", "--force", "--deep", "-s", "-", "#{appdir}/darktable.app"
  end

  zap trash: [
    "~/.cache/darktable",
    "~/.config/darktable",
    "~/.local/share/darktable",
    "~/Library/Saved Application State/org.darktable.savedState",
  ]
end
