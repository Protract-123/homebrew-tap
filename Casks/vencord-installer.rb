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
