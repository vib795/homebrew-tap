class Epub2pdf < Formula
  desc "Fast CLI tool to convert EPUB files to PDF"
  homepage "https://github.com/vib795/epub2pdf"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/vib795/epub2pdf/releases/download/v1.0.0/epub2pdf_1.0.0_darwin_amd64.tar.gz"
      sha256 "75daeb7d8ab7f78c024cde6337ff65df580eccf004bda66691cd9425a335a041"
    end
    on_arm do
      url "https://github.com/vib795/epub2pdf/releases/download/v1.0.0/epub2pdf_1.0.0_darwin_arm64.tar.gz"
      sha256 "903daa1dff612a22bcd1f5a885d2f3473121f428c5ae63c49d4bb6f8886989ea"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/vib795/epub2pdf/releases/download/v1.0.0/epub2pdf_1.0.0_linux_amd64.tar.gz"
      sha256 "093e259eea63d99b64ddc48e80c3b5e0ef2d90a1b99401e6060a8193cff1a752"
    end
    on_arm do
      url "https://github.com/vib795/epub2pdf/releases/download/v1.0.0/epub2pdf_1.0.0_linux_arm64.tar.gz"
      sha256 "d81f1838ffc401df2b406b46d64e2d6def657ecbb7f37b7ddbc7a63ce09e6736"
    end
  end

  def install
    bin.install "epub2pdf"
  end

  def caveats
    <<~EOS
      epub2pdf requires Chrome or Chromium for PDF rendering.

      If you don't have Chrome installed, you can install Chromium:
        brew install --cask chromium
    EOS
  end

  test do
    system "#{bin}/epub2pdf", "version"
  end
end
