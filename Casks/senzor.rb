# Written by Senzor's release workflow (dev/homebrew-cask.sh in kankaj/Senzor): do not edit.
cask "senzor" do
  arch arm: "aarch64", intel: "x86_64"

  version "1.0.1"
  sha256 arm:   "1897e94ca868a772b844f689f6e20b23251be5c20ec28d5cd32d37b223fb5c9e",
         intel: "214f1c6f501ca62412ad050d7efacc2b72a5faa7ae60c6352cc5183f3290e793"

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
