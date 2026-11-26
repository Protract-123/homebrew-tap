cask "vencord-installer" do
  version "1.5.1"
  sha256 "7aac831a66da74cba40e209278d32d77058e447e87ebb00813d0cd6d3c91a71e"

  url "https://github.com/Vencord/Installer/releases/download/v#{version}/VencordInstaller.dmg"
  name "VencordInstaller"
  desc "Installer for Vencord, a Discord client mod"
  homepage "https://github.com/Vencord/Installer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "VencordInstaller.app"

  zap trash: [
    "~/Library/Preferences/dev.vendicated.vencordinstaller.plist",
    "~/Library/Saved Application State/dev.vendicated.vencordinstaller.savedState",
  ]
end
