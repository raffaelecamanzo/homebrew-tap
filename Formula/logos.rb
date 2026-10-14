class Logos < Formula
  desc "Logos — structural code intelligence for AI-assisted development"
  homepage "https://github.com/raffaelecamanzo/logos"
  version "1.16.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.16.4/logos-aarch64-apple-darwin.tar.xz"
      sha256 "4ea9cb625a0e1931f9f700b6c68c9ff0f5170ab158235430a4b46a572ba2f49b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.16.4/logos-x86_64-apple-darwin.tar.xz"
      sha256 "3882af1719a2e595b2052307d3d4f633db8753d346d9f71b3f76e5149a39f7b8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.16.4/logos-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d9f0e16cb73c4ad165b9d58173e39c8c3f16625ff2c4caf6695910607fe388d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/raffaelecamanzo/logos/releases/download/v1.16.4/logos-x86_64-unknown-linux-musl.tar.xz"
      sha256 "88e1697901d6feeb337ba4f526bd058574d1d1af52af45ea81ab4cb64fc94a7c"
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
