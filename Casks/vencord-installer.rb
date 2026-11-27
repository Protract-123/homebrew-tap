cask "vencord-installer" do
  version "1.5.2"
  sha256 "ab6766ebb1b3610b5cbeed8374a232624b5dee8231a9b131ca107517879bfdbb"

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
