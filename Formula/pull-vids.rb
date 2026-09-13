class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.5.0"

  # aria2 is deliberately not a dependency. pull-vids only uses it
  # when asked with --downloader aria2c, because the native
  # downloader measured faster on YouTube.
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.0/pull-vids-darwin-arm64.tar.gz"
      sha256 "cf69d784d841ae551bec83bbfd0a520070fa87167799cf3cb031d68530bbb6a9"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.0/pull-vids-darwin-amd64.tar.gz"
      sha256 "a89132fe7e57ca847d42dc8feaa0757bc763a70788cac4cfed70bfdf197f9a57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.0/pull-vids-linux-arm64.tar.gz"
      sha256 "cca7b36fb2328f34827ee2830160783b843d3a7eb2b949043d88e8451d4fefef"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.0/pull-vids-linux-amd64.tar.gz"
      sha256 "ab11e6ac4f10830b7699dc918fe7745b9f216052457784f29cf053dfdabf23bb"
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
