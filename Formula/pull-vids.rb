class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.4.1"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.1/pull-vids-darwin-arm64.tar.gz"
      sha256 "e09c020b8372203a9e088baca97fae69b2f07b0aec471100cbfed78bf05c3c5f"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.1/pull-vids-darwin-amd64.tar.gz"
      sha256 "0c8183b78d8bd2c25ea5dc451d7d043346d855625eabfa7c5b40a15cc5819308"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.1/pull-vids-linux-arm64.tar.gz"
      sha256 "2d04844dc3d7e0c94b188ca32ff39bf7629ad1a9234f7fff4618e4bfa7b51f18"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.1/pull-vids-linux-amd64.tar.gz"
      sha256 "3470cbc8312546b93828769799af20fc4aecacbc2078bdfba6e6933b900935e1"
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
