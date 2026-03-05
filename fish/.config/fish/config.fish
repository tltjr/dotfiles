# export HOMEBREW_PREFIX="/opt/homebrew";
# export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
# export HOMEBREW_REPOSITORY="/opt/homebrew";

set PATH /opt/homebrew/bin $PATH
set PATH /Users/thosbeans/.cargo/bin $PATH
set PATH /Users/thosbeans/go/bin $PATH
set PATH /Users/thosbeans/bin $PATH
set PATH /Users/thosbeans/Library/Python/3.9/bin $PATH
set PATH /Users/thosbeans/src/rubocop-next/exe/ $PATH
set PATH /Users/thosbeans/.rbenv/bin $PATH
set PATH /Users/thosbeans/go/bin $PATH
set PATH /Users/thosbeans/bin/pgFormatter-5.5 $PATH

set RIPGREP_CONFIG_PATH /Users/thosbeans/.ripgreprc

set CSSM_API_URL "https://commerce-test.cisco.com/api/v2/ts3/ccs/software/licensing/v1/"

# Load secrets from local file (not tracked in git)
if test -f ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

# set -gx LDFLAGS "-L/opt/homebrew/opt/libffi/lib"
# set -gx CPPFLAGS "-I/opt/homebrew/opt/libffi/include"
# set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/libffi/lib/pkgconfig"

set -g theme_title_use_abbreviated_path no
set -g fish_prompt_pwd_dir_length 0

alias .="cd .."
alias ..="cd ../.."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias l="ls -alt"
alias cwpsql="psql -U postgres -W -h 138.68.15.91 -d cword"
alias cw="cd /Users/thosbeans/src/cwordweb"
alias p="cd /Users/thosbeans/programs"
alias vim="nvim"
# SSH aliases - use TERM=xterm-256color because remote hosts don't have xterm-kitty terminfo
alias k8s="TERM=xterm-256color ssh -A jump -t \"ssh -t usw1464 'tmux attach || tmux new-session'\""
alias devbox="TERM=xterm-256color ssh -A -t thornton@dev274.meraki.com 'tmux attach || tmux new-session'"

# Tmux-attached versions (used by Kitty startup)
# Attaches to most recent session if one exists, otherwise creates new
# Note: Inner quotes ensure || is interpreted on final host, not jump
alias k8s-tmux="TERM=xterm-256color ssh -A jump -t \"ssh -t usw1464 'tmux attach || tmux new-session'\""
alias devbox-tmux="TERM=xterm-256color ssh -A -t thornton@dev274.meraki.com 'tmux attach || tmux new-session'"

# Initialize rbenv
if command -v rbenv >/dev/null 2>&1
    rbenv init - | source
end

fish_vi_key_bindings

function rs
  bundle exec rspec --exclude-pattern "spec/performance/*.rb"
end

function :ip --description "Show ip info"
  set wan (curl -s http://ipecho.net/plain)
  set lan (ipconfig getifaddr en0)
  set domain (cat /etc/resolv.conf | grep domain | awk '{print $2}')
  set gateway (netstat -rn | grep default | awk '{print $2}')

  printf '%sLAN IP: %s%s%s\n' (set_color red) (set_color cyan) $lan (set_color normal)
  printf '%sWAN IP: %s%s%s\n' (set_color red) (set_color green) $wan (set_color normal)
  printf '%sDOMAIN : %s%s%s\n' (set_color red) (set_color green) $domain (set_color normal)
  printf '%sGATEWAY : %s%s%s\n' (set_color red) (set_color green) $gateway (set_color normal)
end

set -g hydro_color_git FCECC9
set -g hydro_color_pwd C6D4FF

set -gx DOTNET_ROOT /opt/homebrew/opt/dotnet@8
set PATH /opt/homebrew/opt/dotnet@8/bin $PATH

# Postgres.app - must be last to ensure it's first in PATH
set PATH /Applications/Postgres.app/Contents/Versions/15/bin $PATH
