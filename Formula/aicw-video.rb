class AicwVideo < Formula
  desc "Local-first video toolkit. CLI + MCP server + web hub for AI-planned shorts"
  homepage "https://github.com/aicw-io/aicw-video"
  url "https://registry.npmjs.org/aicw-video/-/aicw-video-1.0.1.tgz"
  sha256 "9592602bd8cfe88d0475aacd74e3d8e582cef3259eeb94ee4ffad1e716feefd9"
  version "1.0.4"
  license "AGPL-3.0-only"

  head "https://github.com/aicw-io/aicw-video.git", branch: "main"

  depends_on "ffmpeg-full"
  depends_on "node"
  depends_on "whisper-cpp"
  # piper-tts is intentionally not a dependency — voice-over is experimental
  # and off by default.

  def install
    system "npm", "install", *std_npm_args(prefix: libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      AICW Video is installed as a CLI:
        aicw-video

      Claude Code one-liner:
        claude mcp add aicw-video -- aicw-video mcp

      Other setup snippets:
        aicw-video setup-claude-code
        aicw-video setup-claude-desktop

      Codex CLI users can add this to ~/.codex/config.toml:
        [mcp_servers.aicw-video]
        command = "aicw-video"
        args = ["mcp"]

      ChatGPT Developer Mode currently imports remote MCP servers over SSE or
      streaming HTTP, not local stdio commands, so use Codex CLI for OpenAI
      local-MCP workflows until AICW Video has an HTTP MCP mode.
    EOS
  end

  test do
    output = shell_output("#{bin}/aicw-video doctor 2>&1")
    assert_match(/aicw-video|ffmpeg|whisper/i, output)
  end
end
