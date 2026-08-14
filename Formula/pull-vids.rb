class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.3.3"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.3/pull-vids-darwin-arm64.tar.gz"
      sha256 "d30c5d125a41be1ec6cd9bcb1f8c2bd6047e445b89594a3c1e2e0b328daae03a"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.3/pull-vids-darwin-amd64.tar.gz"
      sha256 "2eafa4b45e9251027c47541bc0947b1f70cbd8ab5e324be46df418a6323c5836"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.3/pull-vids-linux-arm64.tar.gz"
      sha256 "f91f0bd7d0064102a2dbf76babee673eb88cb249c2161de7d40334c38f4f0dde"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.3/pull-vids-linux-amd64.tar.gz"
      sha256 "ea6338787d82e07bb557b7613803a259c540fb436c21fdcb8417079d574410d5"
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
