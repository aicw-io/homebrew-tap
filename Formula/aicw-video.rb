class AicwVideo < Formula
  desc "Local-first video toolkit. CLI + MCP server + web hub for AI-planned shorts"
  homepage "https://github.com/aicw-io/aicw-video"
  url "https://registry.npmjs.org/aicw-video/-/aicw-video-1.0.0.tgz"
  sha256 "6f6d6109d93b6bafefa8f4cda82953418add04f51f3ca3680ac64b3190a22d3d"
  version "1.0.0"
  license "AGPL-3.0-only"

  head "https://github.com/aicw-io/aicw-video.git", branch: "main"

  depends_on "ffmpeg"
  depends_on "node"
  depends_on "whisper-cpp"
  # piper-tts is intentionally not a dependency — voice-over is experimental
  # and off by default.

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/aicw-video doctor 2>&1")
    assert_match(/aicw-video|ffmpeg|whisper/i, output)
  end
end
