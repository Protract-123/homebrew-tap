cask "oculante" do
  version "0.9.6"
  sha256 "8ddf2bf85bd804d6648ea82ded24d7f40e1040e00d78e0863f4ef9c1a9de810a"

  url "https://github.com/woelper/oculante/releases/download/#{version}/oculante_mac.zip"
  name "oculante"
  desc "Fast and simple image viewer"
  homepage "https://github.com/woelper/oculante"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos
  depends_on arch: :arm64

  app "oculante.app"

  zap trash: [
    "~/Library/Preferences/com.github.woelper.oculante.plist",
    "~/Library/Saved Application State/com.github.woelper.oculante.savedState",
  ]
end
