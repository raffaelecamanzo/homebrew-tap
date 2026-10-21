class Logos < Formula
  desc "Logos — structural code intelligence for AI-assisted development"
  homepage "https://github.com/raffaelecamanzo/logos"
  version "1.20.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.20.5/logos-aarch64-apple-darwin.tar.xz"
      sha256 "ea28fb3dbb3953857334ddf51431699ad6f7595cbe2de241fb449c7c0c42cbec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.20.5/logos-x86_64-apple-darwin.tar.xz"
      sha256 "62597e31e4f4a8b02b3d669dfff960f4ea4d6b0a050a0109a414c39741dd5092"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.20.5/logos-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a01fecd726b82479d3d2599622bf6ea3b600e3949e89db1b65cbc230cb14a093"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.20.5/logos-x86_64-unknown-linux-musl.tar.xz"
      sha256 "6424321b9c2262be4f0c74a3da27aec510eeb5a997243963b85cb88e2f2f994b"
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
