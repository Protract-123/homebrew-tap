cask "darktable" do
  version "5.6.2"
  sha256 "6ff88e58a2a59cb07b0a1502fea7205e68cd783380a33a3ce7bda68ec29def0c"

  url "https://github.com/darktable-org/darktable/releases/download/release-#{version}/darktable-#{version}-arm64.dmg"
  name "darktable"
  desc "Photography workflow application and raw developer"
  homepage "https://www.darktable.org/"

  livecheck do
    url "https://github.com/darktable-org/darktable"
    strategy :github_latest
    regex(/release[._-](\d+(?:\.\d+)+)/i)
  end

  depends_on :macos
  depends_on arch: :arm64

  app "darktable.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-drs", "com.apple.quarantine", "{{appdir}}/darktable.app"],
        writable_paths: "darktable.app",
        writable_base:  :appdir
    run "/usr/bin/codesign",
        args:           ["--force", "--deep", "-s", "-", "{{appdir}}/darktable.app"],
        writable_paths: "darktable.app",
        writable_base:  :appdir
  end

  zap trash: [
    "~/.cache/darktable",
    "~/.config/darktable",
    "~/.local/share/darktable",
    "~/Library/Saved Application State/org.darktable.savedState",
  ]
end
