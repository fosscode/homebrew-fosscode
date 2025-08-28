class Fosscode < Formula
  desc "Lightweight CLI application for code agent interactions with LLMs"
  homepage "https://github.com/fosscode/fosscode"
  version "0.0.34"

  # Use standalone binary on supported platforms, fallback to npm
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/fosscode/fosscode/releases/download/v#{version}/fosscode-linux-x64"
    sha256 "" # Will be updated with actual checksum
  elsif OS.mac? && Hardware::CPU.intel?
    url "https://github.com/fosscode/fosscode/releases/download/v#{version}/fosscode-macos-x64"
    sha256 "" # Will be updated with actual checksum
  elsif OS.mac? && Hardware::CPU.arm?
    url "https://github.com/fosscode/fosscode/releases/download/v#{version}/fosscode-macos-arm64"
    sha256 "" # Will be updated with actual checksum
  else
    # Fallback to npm for unsupported platforms or Windows
    url "https://registry.npmjs.org/fosscode/-/fosscode-#{version}.tgz"
    sha256 "f80a2482d0db1f212faff2f7f4233d4ec0362748"
    depends_on "node" => :recommended
  end

  license "MIT"

  def install
    if url.include?("registry.npmjs.org")
      # npm installation
      system "npm", "install", "-g", "--prefix=#{prefix}", "fosscode@#{version}"
    else
      # Binary installation
      bin.install url.split("/").last => "fosscode"
    end
  end

  test do
    assert_match "fosscode", shell_output("#{bin}/fosscode --help")
  end
end