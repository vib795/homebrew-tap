class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.4.0"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.0/pull-vids-darwin-arm64.tar.gz"
      sha256 "2ee8d49b692b0cf8a80a257804e71f800481b865cc2059206035dbfe8d20b51f"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.0/pull-vids-darwin-amd64.tar.gz"
      sha256 "b434d0fdf7b5d1a188352ffdb3ca05ef80f277fb835c4fac66ea10a2bd0ddd25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.0/pull-vids-linux-arm64.tar.gz"
      sha256 "2c6698be45ea102cf5793f618e7dc3f8c92486c1b671ca46b7591fa8bafb6b5f"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.4.0/pull-vids-linux-amd64.tar.gz"
      sha256 "aa1954dc5dced83db5fa97c812ec3e4ccd4ebbe89ff3646c7fbde37cb36e7a88"
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
