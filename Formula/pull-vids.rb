class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.2/pull-vids-darwin-arm64.tar.gz"
      sha256 "8d5f9163c35c0dd58fb8634ee06e4327a025348ce599be333a46931b510b25e0"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.2/pull-vids-darwin-amd64.tar.gz"
      sha256 "202689d2705fbfac2eede3d18145e5baf15bd0b7a34f05cc2bfac59ffb713a7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.2/pull-vids-linux-arm64.tar.gz"
      sha256 "a85ea8580f6def1aa526511852dcbfe40c13d5964808d466eef60d56def77c8d"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.2/pull-vids-linux-amd64.tar.gz"
      sha256 "e9f0e64bf7b11afcfe55332e9595f9a68fb1c399517750af3af0d918c1b76d81"
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
