class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-darwin-arm64.tar.gz"
      sha256 "fbf09f32e6d6ebf1b2c5f60abb52e3cbf827f467c3d8cca7cc9549fba77a2db0"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-darwin-amd64.tar.gz"
      sha256 "1bba37233daa1da122f46dde23a99b9b5c5453c6a47d6b43db4cb44d4c90ab47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-linux-arm64.tar.gz"
      sha256 "ac6e51492942845f6c7923070581bb2c52ab0b71f5d67089d6f08f10c6191f7b"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.1/pull-vids-linux-amd64.tar.gz"
      sha256 "95fe5061cd78f1a9ca161470352fdfa41401b6e40d9471a079b349e76f977442"
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
