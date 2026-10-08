class Logos < Formula
  desc "Logos — structural code intelligence for AI-assisted development"
  homepage "https://github.com/raffaelecamanzo/logos"
  version "1.15.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.15.2/logos-aarch64-apple-darwin.tar.xz"
      sha256 "6bcb87acf7dd3a7e398e336bd5193690c8cd01cae89b62ebe98aa6cb07995288"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.15.2/logos-x86_64-apple-darwin.tar.xz"
      sha256 "577d2b677757cb919c9be9e95c42937601973d8985b746ac516aff39541d1195"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.15.2/logos-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b0e07dbf634a0db4b902d8928ed0bca1dc4fae355b543c143dbcd44fe7d55627"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.15.2/logos-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9166e0dd61003dc7a2d881e586b094de1a7346dee0c30f5a019474654fd23ca9"
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
