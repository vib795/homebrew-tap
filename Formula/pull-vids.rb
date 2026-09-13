class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.5.1"

  # aria2 is deliberately not a dependency. pull-vids only uses it
  # when asked with --downloader aria2c, because the native
  # downloader measured faster on YouTube.
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.1/pull-vids-darwin-arm64.tar.gz"
      sha256 "01e2cea8aa0229e940571361083a42831a4398fe15c5129c27b121d527d7c886"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.1/pull-vids-darwin-amd64.tar.gz"
      sha256 "ade530cde5f5f2d286c9b03d119836b70ddc923b65e1ac0efbdd3c92fa22ec62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.1/pull-vids-linux-arm64.tar.gz"
      sha256 "d89933191e3c2612db89662941a166f42295f590148125c7a7ab2d633755d627"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.5.1/pull-vids-linux-amd64.tar.gz"
      sha256 "85bca506846679d6c3f817edd1a8f8eadc5178b53a800edde174230ab17c69ba"
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
