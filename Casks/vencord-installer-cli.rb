cask "vencord-installer-cli" do
  version "1.5.1"
  sha256 "323f42a5b8da4b14580149d8f2e61bcef5d13583abf8451b57fb2dbf4d97afe0"

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
