cask "vencord-installer-cli" do
  version "1.5.2"
  sha256 "1239473d17605025c56e78c0828e4b1b73d8d62af6e1b3fb3672fac5de72ca3b"

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
