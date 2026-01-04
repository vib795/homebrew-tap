class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-darwin-arm64.tar.gz"
      sha256 "8627005f39d48ce09fc6d5bfe4ffed08e2ff255a6e9501c3a3d8ae5d104d64cc"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-darwin-amd64.tar.gz"
      sha256 "fa9ee3380fb2c45f177026afe1e8dbfd18f0c163d2713a85a8c644d7ec4b494d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-linux-arm64.tar.gz"
      sha256 "a25abf2d80bd2bb30bdaa4af1a7027191af90478e0a1c20d49d6c7268aa20228"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-linux-amd64.tar.gz"
      sha256 "65472428d552cf8414b221484f49763df6dc11a06dc846a0775c57aa365dab1f"
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
