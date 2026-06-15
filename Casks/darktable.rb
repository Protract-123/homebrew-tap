cask "darktable" do
  arch arm: "arm64", intel: "x86_64"

  version "5.4.1"
  sha256 arm:   "23ce74a4d7cbab30dc5e55043f97480b2a4eb1d96d602d529c9f9a428b99d041",
         intel: "d615f7e78af9fb23d7c8017a5d35be50ea13f1ccf89491ef4b927e23eff0f43a"

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

  on_arm do
    depends_on macos: ":sonoma"
  end
  on_intel do
    depends_on macos: ":sequoia"
  end

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
