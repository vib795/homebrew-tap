class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.2/pull-vids-darwin-arm64.tar.gz"
      sha256 "b6e3b9c12cdf3792748a2c7268475643a0205c84abf0676acfdf91878680d5b1"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.2/pull-vids-darwin-amd64.tar.gz"
      sha256 "61a55ae337ed31158846f8dee1702359df7e2bb71e056e1f70d0fcb8c943e5b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.2/pull-vids-linux-arm64.tar.gz"
      sha256 "56da289463c51be916b86f16837c2ba24a8146a9bb3299066a485098c4348ee9"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.2/pull-vids-linux-amd64.tar.gz"
      sha256 "568877bb324e7107e8205e996beb8d8bcbb3311b7ae53bda94e3fce04ecbdc04"
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
