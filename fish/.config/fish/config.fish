# export HOMEBREW_PREFIX="/opt/homebrew";
# export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
# export HOMEBREW_REPOSITORY="/opt/homebrew";

set PATH /opt/homebrew/bin $PATH
set PATH /Users/Tom.Thornton/.cargo/bin $PATH
set PATH /Users/Tom.Thornton/go/bin $PATH
set PATH /Users/Tom.Thornton/bin $PATH
set PATH /Users/Tom.Thornton/Library/Python/3.9/bin $PATH
set PATH /Users/Tom.Thornton/src/rubocop-next/exe/ $PATH
set PATH /Users/Tom.Thornton/.rbenv/bin $PATH
set PATH /Users/Tom.Thornton/go/bin $PATH
set PATH /Users/Tom.Thornton/bin/pgFormatter-5.5 $PATH

set RIPGREP_CONFIG_PATH /Users/Tom.Thornton/.ripgreprc

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
alias cw="cd /Users/Tom.Thornton/src/cwordweb"
alias p="cd /Users/Tom.Thornton/programs"
alias vim="nvim"
alias k8s="ssh -A jump -t ssh usw1464"
alias devbox="ssh -A thornton@dev274.meraki.com"

# Tmux-attached versions (used by WezTerm startup)
# Attaches to most recent session if one exists, otherwise creates new
alias k8s-tmux="ssh -A jump -t ssh -t usw1464 'tmux attach || tmux new-session'"
alias devbox-tmux="ssh -A -t thornton@dev274.meraki.com 'tmux attach || tmux new-session'"

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

set -gx DOTNET_ROOT /Users/Tom.Thornton/.dotnet
set -gx PATH /Users/Tom.Thornton/.dotnet /Users/Tom.Thornton/.dotnet:/Users/Tom.Thornton/.local/bin:/opt/homebrew/opt/fzf/bin:/Users/Tom.Thornton/bin/pgFormatter-5.5:/Users/Tom.Thornton/go/bin:/Users/Tom.Thornton/.rbenv/bin:/Users/Tom.Thornton/src/rubocop-next/exe/:/Users/Tom.Thornton/Library/Python/3.9/bin:/Users/Tom.Thornton/bin:/Users/Tom.Thornton/go/bin:/Users/Tom.Thornton/.cargo/bin:/opt/homebrew/bin:/Users/Tom.Thornton/.rbenv/shims:/opt/homebrew/bin:/usr/local/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/usr/local/share/dotnet:~/.dotnet/tools:/usr/local/go/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Users/Tom.Thornton/bin/pgFormatter-5.5:/Users/Tom.Thornton/go/bin:/Users/Tom.Thornton/.rbenv/bin:/Users/Tom.Thornton/src/rubocop-next/exe/:/Users/Tom.Thornton/Library/Python/3.9/bin:/Users/Tom.Thornton/bin:/Users/Tom.Thornton/.cargo/bin:/opt/homebrew/bin
fish_add_path $HOME/.local/bin

# Postgres.app - must be last to ensure it's first in PATH
set PATH /Applications/Postgres.app/Contents/Versions/15/bin $PATH
