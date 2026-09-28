class Logos < Formula
  desc "Logos — structural code intelligence for AI-assisted development"
  homepage "https://github.com/raffaelecamanzo/logos"
  version "1.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.5.0/logos-aarch64-apple-darwin.tar.xz"
      sha256 "80ddb8cfddef2c12b1c104616ee11619c64d28e74c293d12fdde87837bc8b6ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.5.0/logos-x86_64-apple-darwin.tar.xz"
      sha256 "55b53a12ea30c580ad984c70e6c3210c99f25a45176d18999bc996779d122a3e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.5.0/logos-aarch64-unknown-linux-musl.tar.xz"
      sha256 "496a66b60c449213dec1f6ffd5b1c850ecc022c95412c606579caf79096c40f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.5.0/logos-x86_64-unknown-linux-musl.tar.xz"
      sha256 "7a5a9dd3d6f09bc02454a7822edba08a7856e9d9e67745ee61b52d1a5a1dd170"
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
