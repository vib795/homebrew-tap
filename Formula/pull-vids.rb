class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.3.5"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.5/pull-vids-darwin-arm64.tar.gz"
      sha256 "14b728407944c42819281115b778856166225ac5452fce09b89e0b67ae107a84"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.5/pull-vids-darwin-amd64.tar.gz"
      sha256 "ba4d2574eecbadeec5b8158ffb9a244c028c9b6f67363c88f31c8872df3f16d5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.5/pull-vids-linux-arm64.tar.gz"
      sha256 "0f941d02bff93c564dc6c55d7fc2d3548cbda8e0e52a302aaee24d74bf143fca"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.5/pull-vids-linux-amd64.tar.gz"
      sha256 "1dc220d2fa3f53b9cc6d588b6365c45f72d688ecde128e30b169a1c74a4a1e57"
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
