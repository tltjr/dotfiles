. "$HOME/.cargo/env"

# Cursor's sandbox sets BUNDLE_PATH to a temp cache dir, which breaks
# bundler for gems installed outside the sandbox (i.e. via a normal terminal).
if [[ "$BUNDLE_PATH" == */cursor-sandbox-cache/* ]]; then
  unset BUNDLE_PATH
fi
