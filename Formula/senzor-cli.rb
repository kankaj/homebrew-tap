class SenzorCli < Formula
  desc "MQTT sensor simulator: run Senzor projects headless, in a terminal, Docker or CI"
  homepage "https://senzor.kankaj.cz"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.1/senzor-cli-aarch64-apple-darwin.tar.xz"
      sha256 "7e98d46129522f032055be590be8afc87cae3ecd9d2b90870630fb8f68b6c443"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.1/senzor-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5e705181bcdf714924dcbf5ac1effd14b3a8f4824ba1b3f0d26db8d74189d3af"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.1/senzor-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ebfc92ca667230b0cc5f62a704004b037ee2cb475c5e0d7eff17c22d9609763c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kankaj/Senzor/releases/download/v1.0.1/senzor-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b30abd5951b1b9cd4cf48ef2d82ae2d9444787da85dd864e5b8e2a3b0dbc44a7"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
