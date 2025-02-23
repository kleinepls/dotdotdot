. "$HOME/.cargo/env"

export WINEPREFIX="$HOME/.wine"

export GOPATH="$HOME/.local/go"
export PNPM_HOME="$HOME/Library/pnpm"
export LSP="$HOME/.config/nvim/lua/plugins/lsp.lua"

export PATH="$PNPM_HOME:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"

# tauri
export JAVA_HOME=~/Downloads/android-studio/jbr
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"

# export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
# export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
