class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.5.2"

  # aria2 is deliberately not a dependency. pull-vids only uses it
  # when asked with --downloader aria2c, because the native
  # downloader measured faster on YouTube.
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.2/pull-vids-darwin-arm64.tar.gz"
      sha256 "24ece3e76dcb1d219851b639cc88b47f69802486fda0bba31d45571a782757e2"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.2/pull-vids-darwin-amd64.tar.gz"
      sha256 "2c98759305eb81b88b171e62e77f54f7a787726075a0f4a2ce370785d0383b12"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.2/pull-vids-linux-arm64.tar.gz"
      sha256 "62f7b0ab719e8129ed230379ddccf9705c2e39add4d4b59abca60bea7f16969b"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.2/pull-vids-linux-amd64.tar.gz"
      sha256 "82576a92967a48e16b6dd1620f81bda8085776c911f15d662825dd97b6dce8ea"
    end
  end

  def install
    binary_name = if OS.mac?
      Hardware::CPU.arm? ? "pull-vids-darwin-arm64" : "pull-vids-darwin-amd64"
    else
      Hardware::CPU.arm? ? "pull-vids-linux-arm64" : "pull-vids-linux-amd64"
    end

    bin.install binary_name => "pull-vids"
  end

  test do
    version_output = shell_output("#{bin}/pull-vids --version")
    assert_match "pull-vids", version_output

    help_output = shell_output("#{bin}/pull-vids --help 2>&1")
    assert_match "Universal Video Downloader", help_output
    assert_match "Supports 1000+ sites", help_output
  end
end
