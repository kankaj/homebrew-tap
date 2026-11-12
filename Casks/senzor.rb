# Written by Senzor's release workflow (dev/homebrew-cask.sh in kankaj/Senzor): do not edit.
cask "senzor" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "66921ef7c65a435ed287e2997f3c4fce3ac900b6836f57718d5465512f004f92",
         intel: "d997b6c0086575e5f8d7186f021e3abe11eb96e1787f40c8b2dd54e3a00d3562"

  url "https://github.com/kankaj/Senzor/releases/download/v#{version}/Senzor-#{arch}-apple-darwin.zip"
  name "Senzor"
  desc "MQTT sensor simulator"
  homepage "https://senzor.kankaj.cz/"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Senzor.app"

  zap trash: [
    "~/Library/Application Support/cz.kankaj.Senzor",
    "~/Library/Saved Application State/cz.kankaj.Senzor.savedState",
  ]

  caveats <<~CAVEATS
    Senzor is not signed by Apple, so macOS blocks it the first time you open it.
    Open it once from Applications, then choose System Settings > Privacy & Security >
    Open Anyway (or, on older macOS, right-click Senzor.app and choose Open).
  CAVEATS
end
