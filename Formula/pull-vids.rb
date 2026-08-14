class PullVids < Formula
  desc "Universal video downloader CLI supporting 1000+ websites"
  homepage "https://github.com/vib795/pull-vids"
  license "MIT"
  # Declare the version explicitly. Without this Homebrew infers it
  # from the download URL, and "pull-vids-darwin-arm64.tar.gz" yields
  # "64" — identical for every release, so `brew upgrade` sees no new
  # version and never replaces the installed binary.
  version "0.3.4"

  # aria2 powers the parallel-connection downloader. Google's CDN
  # throttles each TCP connection independently, so without it
  # pull-vids falls back to the native downloader and only
  # parallelises formats that are already fragmented.
  depends_on "aria2"
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  on_macos do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.4/pull-vids-darwin-arm64.tar.gz"
      sha256 "1222ef47788b874161fcd48cdc990f9efb0db4f160f6ea22c5bca119900e4306"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.4/pull-vids-darwin-amd64.tar.gz"
      sha256 "83194a8a8ab73038ddd38bfb94060f68e67da3dd313da554cb0805616ea34084"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.4/pull-vids-linux-arm64.tar.gz"
      sha256 "5e2df819aeea06806f28229af6cfcfbf95a7b3bef8d43b2724bb5356a51deeba"
    end
    on_intel do
      url "https://github.com/vib795/pull-vids/releases/download/v0.3.4/pull-vids-linux-amd64.tar.gz"
      sha256 "20d9ea85dc9b1cb8cc87fe7e12988449b06a1a1a34e3a48ee0389ec621e67e13"
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
