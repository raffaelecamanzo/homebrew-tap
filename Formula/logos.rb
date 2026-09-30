class Logos < Formula
  desc "Logos — structural code intelligence for AI-assisted development"
  homepage "https://github.com/raffaelecamanzo/logos"
  version "1.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.7.0/logos-aarch64-apple-darwin.tar.xz"
      sha256 "2f2e97a530070af905600958dea60696889f6fb6001c9caec862ca4b1f265d6f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.7.0/logos-x86_64-apple-darwin.tar.xz"
      sha256 "a734708eb764d75ae9fb8d117896db937d15a5ecedaf42b1ec4ce51fa2e2a67f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.7.0/logos-aarch64-unknown-linux-musl.tar.xz"
      sha256 "521f8eca32f983929498fde8f33a807d6e998a387452f1b0511449b101da1034"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.7.0/logos-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c61b503c8f65e696845c9eab6b48d62e2432ed6ae604c3aa620f78113ada5022"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "logos"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "logos"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "logos"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "logos"
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
