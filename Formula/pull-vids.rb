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
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.1/pull-vids-darwin-arm64.tar.gz"
      sha256 "a8eb36af7daeb1428f2ce3c67693064e20e2e7e3496a29dbfcee46fb5d27a2fc"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.1/pull-vids-darwin-amd64.tar.gz"
      sha256 "cac1cc6703a5315c0f0cec1ab84cadf2ce789dc747e5f9f28f4c1db1788943fb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.1/pull-vids-linux-arm64.tar.gz"
      sha256 "20262ebc18a4c74cd2c3099fc258621b597958b5867ea2e890e322271d0f4ade"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.1/pull-vids-linux-amd64.tar.gz"
      sha256 "23e9574f5f6b8c9e1f6d42d0c8c5b0fa5e5cdd4ad8ea873ce07c1c7c68445b12"
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
