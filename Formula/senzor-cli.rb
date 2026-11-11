class SenzorCli < Formula
  desc "MQTT sensor simulator: run Senzor projects headless, in a terminal, Docker or CI"
  homepage "https://senzor.kankaj.cz"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.0/senzor-cli-aarch64-apple-darwin.tar.xz"
      sha256 "0c9775b7a89ae6f3969b04097916238620b25567938fb95e8c1a043ebd15133e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.0/senzor-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a7d264ba0840eeb97929a5e2c4d4ea61312934978d35907f83d8a09bbf070f3a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.0/senzor-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d7050258684e163f7fc74b4105337485abfbc2b4ca1bda674aa4b13d3553933b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.0/senzor-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3058e9119c689ff07ad90a1aa49147ffe72ae72dd3e68c89b053212f10a747f9"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "senzor-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "senzor-cli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "senzor-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "senzor-cli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
