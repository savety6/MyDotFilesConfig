# Shared helpers for bootstrap.d scripts (sourced, not run).

# Run privileged commands with sudo unless we already are root
# (minimal images/containers often have no sudo installed).
if [ "$(id -u)" -eq 0 ]; then SUDO=""; else SUDO="sudo"; fi

# System-level steps (apt packages, docker, neovim, lazygit) can be
# handed to a config-management tool instead: Ansible sets
# YADM_SKIP_SYSTEM=1 and installs pinned versions itself.
skip_system() {
  if [ "${YADM_SKIP_SYSTEM:-0}" = "1" ]; then
    echo "[$1] YADM_SKIP_SYSTEM=1, skipping (managed elsewhere)"
    exit 0
  fi
}

# Map `uname -m` to the arch names release assets use.
arch() {
  case "$(uname -m)" in
    x86_64|amd64) echo x86_64 ;;
    aarch64|arm64) echo arm64 ;;
    *) echo "unsupported arch: $(uname -m)" >&2; exit 1 ;;
  esac
}
