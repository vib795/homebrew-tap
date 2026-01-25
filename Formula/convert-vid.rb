# typed: false
# frozen_string_literal: true

class ConvertVid < Formula
  desc "A fast CLI tool for converting video files between different formats"
  homepage "https://github.com/vib795/convert-video-formats"
  license "MIT"
  version "1.0.7"  # This will be auto-updated by GoReleaser

  on_macos do
    on_intel do
      url "https://github.com/vib795/convert-video-formats/releases/download/v#{version}/convert-vid_#{version}_darwin_amd64.tar.gz"
      sha256 "CHECKSUM_HERE"  # Auto-updated by GoReleaser
    end
    on_arm do
      url "https://github.com/vib795/convert-video-formats/releases/download/v#{version}/convert-vid_#{version}_darwin_arm64.tar.gz"
      sha256 "CHECKSUM_HERE"  # Auto-updated by GoReleaser
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vib795/convert-video-formats/releases/download/v#{version}/convert-vid_#{version}_linux_amd64.tar.gz"
      sha256 "CHECKSUM_HERE"  # Auto-updated by GoReleaser
    end
    on_arm do
      url "https://github.com/vib795/convert-video-formats/releases/download/v#{version}/convert-vid_#{version}_linux_arm64.tar.gz"
      sha256 "CHECKSUM_HERE"  # Auto-updated by GoReleaser
    end
  end

  depends_on "ffmpeg"

  def install
    bin.install "convert-vid"
  end

  # ADD THIS SECTION - GoReleaser doesn't add it automatically
  def caveats
    <<~EOS
      convert-vid requires ffmpeg with AV1 decoder support.

      If you encounter "exit status 69" errors when converting videos,
      your ffmpeg may need to be reinstalled:
        brew reinstall ffmpeg

      This ensures libdav1d (AV1 decoder) is properly installed.
    EOS
  end

  test do
    system "#{bin}/convert-vid", "version"
  end
end
