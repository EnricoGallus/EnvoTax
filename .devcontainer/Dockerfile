ARG RUBY_VERSION=4.0.7
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

WORKDIR /workspace

# -----------------------------------------------
# uv / uvx - Python tooling for MCP servers
# -----------------------------------------------

COPY --from=ghcr.io/astral-sh/uv:0.13.1 /uv /uvx /usr/local/bin/

# -----------------------------------------------
# Rails MCP Server
# -----------------------------------------------

# Make mise-managed Ruby executables available to Codex
# even when it starts without an interactive shell.
ENV PATH="/home/vscode/.local/share/mise/shims:${PATH}"

# Ruby is managed by mise and installed for the vscode user.
# Use an interactive bash shell to initialize the Ruby environment.
RUN bash -ic 'gem install rails-mcp-server --no-document && mise reshim'