class AicwVideo < Formula
  desc "Local-first video toolkit. CLI + MCP server + web hub for AI-planned shorts"
  homepage "https://github.com/aicw-io/aicw-video"
  license "AGPL-3.0-or-later"

  # Until v1.0.0 ships, install from the main branch with `brew install --HEAD`.
  # When tagging v1.0.0, replace the `head` line with `url` + `sha256` + `version`,
  # and (optionally) keep a `head` block so users can still track main.
  #
  # Stable form, once v1.0.0 is on npm:
  #   url "https://registry.npmjs.org/aicw-video/-/aicw-video-1.0.0.tgz"
  #   sha256 "REPLACE_WITH_TARBALL_SHA256"
  #   version "1.0.0"
  head "https://github.com/aicw-io/aicw-video.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "node"
  depends_on "whisper-cpp"
  depends_on "yt-dlp"
  # piper-tts is intentionally not a dependency — voice-over is experimental
  # and off by default.

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # `aicw-video doctor` returns a non-zero exit when any optional check
    # fails (e.g. missing whisper model in a fresh sandbox). We just verify
    # the binary launches and prints something recognisable.
    output = shell_output("#{bin}/aicw-video doctor 2>&1", 1)
    assert_match(/aicw-video|ffmpeg|whisper/i, output)
  end
end
