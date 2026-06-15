cask "vencord-installer" do
  version "1.4.0"
  sha256 "b7b4d38643223df94f3af937ad05cd25c68d0b1aa5b6da52b71aee4593da8817"

  url "https://github.com/Vencord/Installer/releases/download/v#{version}/VencordInstaller.MacOS.zip"
  name "VencordInstaller"
  desc "Installer for Vencord, a Discord client mod"
  homepage "https://github.com/Vencord/Installer"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "VencordInstaller.app"

  postflight do
    system "/usr/bin/xattr", "-drs", "com.apple.quarantine", "#{appdir}/VencordInstaller.app"
    system "/usr/bin/codesign", "--force", "--deep", "-s", "-", "#{appdir}/VencordInstaller.app"
  end

  zap trash: [
    "~/Library/Preferences/dev.vendicated.vencordinstaller.plist",
    "~/Library/Saved Application State/dev.vendicated.vencordinstaller.savedState",
  ]
end
