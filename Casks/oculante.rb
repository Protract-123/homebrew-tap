cask "oculante" do
  version "0.9.2"
  sha256 "c17742e6ebb28eb27f4696e43f5cb1446ac5636be83f051a2ddd60817500f698"

  url "https://github.com/woelper/oculante/releases/download/#{version}/oculante_mac_universal.zip"
  name "oculante"
  desc "Fast and simple image viewer"
  homepage "https://github.com/woelper/oculante"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "oculante.app"

  postflight do
    system "/usr/bin/xattr", "-drs", "com.apple.quarantine", "#{appdir}/oculante.app"
    system "/usr/bin/codesign", "--force", "--deep", "-s", "-", "#{appdir}/oculante.app"
  end

  zap trash: [
    "~/Library/Preferences/com.github.woelper.oculante.plist",
    "~/Library/Saved Application State/com.github.woelper.oculante.savedState",
  ]
end
