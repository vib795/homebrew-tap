class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"

  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-darwin-arm64.tar.gz"
      sha256 "ba22f15ff8e6546c8f684ca57791fcfa75bb1204f266bfd2eb67071da46b6b7a"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-darwin-amd64.tar.gz"
      sha256 "43e62ee8f05b42932b5ddc24de5b9c695f2831ba5498eacc7f072cfe249042c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-linux-arm64.tar.gz"
      sha256 "05ef54564d8afa6e562b29c664949dffa75227c300afcb2488c8e3d285e13895"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.2.3/pull-vids-linux-amd64.tar.gz"
      sha256 "becc97d9108de04b6e31d28906e04ecfa969f37416da279d8b3096aba7bfbeba"
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
