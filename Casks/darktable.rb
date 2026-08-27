cask "darktable" do
  arch arm: "ab09e11d548a7028f7bacc2bc4549a272c4e8d385be0e38ecc9e7943914abe61", intel: "x86_64"

  version "5.6.1"
  sha256 arm:   "155c25a48e06023eeeda3640f6f4fc7848bc1ad8e7384ba1d7b63098986fbeda",
         intel: "ab09e11d548a7028f7bacc2bc4549a272c4e8d385be0e38ecc9e7943914abe61"

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
