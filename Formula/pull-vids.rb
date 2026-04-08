class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-darwin-arm64.tar.gz"
      sha256 "32cb66612909f448faa267da1bf394fdc558be8a529ebe5637a3a0b8548ff2cb"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-darwin-amd64.tar.gz"
      sha256 "88e6e0fc86dcf0f0ffa8f4e12d5f0ea2dba07caeb6fd4da2095232b1e2129e11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-linux-arm64.tar.gz"
      sha256 "befdef514f694b4359c4901dee76d43a55f3aaaf5bbf58bd27d4f8313e58c830"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-linux-amd64.tar.gz"
      sha256 "ee42d90d3effbbaff246993f7514f70d0e6d601d5f7bd70f588a24decea7bb1b"
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
