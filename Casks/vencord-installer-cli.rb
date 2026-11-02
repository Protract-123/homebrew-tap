cask "vencord-installer-cli" do
  version "1.4.2"
  sha256 "f4c77a9dddd4a12deaae270b3dadfda25969dfcfa141cc2354cafe6344044b75"

  url "https://github.com/Vencord/Installer/releases/download/v#{version}/VencordInstallerCli-darwin"
  name "VencordInstallerCli"
  desc "Command-line installer for Vencord, a Discord client mod"
  homepage "https://github.com/Vencord/Installer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  binary "VencordInstallerCli-darwin", target: "vencord-installer"

  postflight_steps do
    set_permissions "VencordInstallerCli-darwin", "0755"
    run "/usr/bin/xattr",
        args:         ["-d", "com.apple.quarantine", "{{staged_path}}/VencordInstallerCli-darwin"],
        must_succeed: false
    run "/usr/bin/codesign",
        args: ["--force", "-s", "-", "{{staged_path}}/VencordInstallerCli-darwin"]
  end
end
