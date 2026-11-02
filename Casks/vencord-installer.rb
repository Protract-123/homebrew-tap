cask "vencord-installer" do
  version "1.4.2"
  sha256 "2d127ef1f5cab27d31a71880b237db0356c34b33ffe977827d95b8c6e5cb80d1"

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

  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-drs", "com.apple.quarantine", "{{appdir}}/VencordInstaller.app"],
        writable_paths: "VencordInstaller.app",
        writable_base:  :appdir
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "-s", "-", "{{appdir}}/VencordInstaller.app"],
        writable_paths: "VencordInstaller.app",
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Preferences/dev.vendicated.vencordinstaller.plist",
    "~/Library/Saved Application State/dev.vendicated.vencordinstaller.savedState",
  ]
end
