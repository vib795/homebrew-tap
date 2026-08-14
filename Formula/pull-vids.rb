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
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.0/pull-vids-darwin-arm64.tar.gz"
      sha256 "c33b62396036a2e5626200f9f0fd1acc2dcf79ad5da12f401e284af3bd6d4aff"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.0/pull-vids-darwin-amd64.tar.gz"
      sha256 "4d12bc6090c147b6d9883fe4d1096e766ddf3f2941742758773ad464ea9b887e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.0/pull-vids-linux-arm64.tar.gz"
      sha256 "031a1390a68eea53b54c0547fe0c8b28c3daa59424f41094404262ee18457854"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.0/pull-vids-linux-amd64.tar.gz"
      sha256 "16330b7c452c50efefeb853fe5a17a052425090995c670a67f4e7281dac0dfac"
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
