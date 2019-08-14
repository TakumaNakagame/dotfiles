# 補完機能
autoload -U compinit
compinit

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export XDG_DATA_DIRS="$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
export PATH="$HOME/.linuxbrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH='/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin':"$PATH"
export PATH="$PATH:~/terraform/"

# kubeconfig file
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/config
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/sob-config
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/shirayuki-config
export KUBECONFIG=$KUBECONFIG:$HOME/.kube/shirayuki-is1b-config

# Alias
alias k="kubectl"
alias kx="kubectx"
alias kns="kubens"
alias review='docker run --rm -v $(pwd):/work -v $(pwd)/.texmf-var:/root/.texmf-var vvakame/review:latest /bin/sh -c "cd /work && review-pdfmaker config.yml"'
alias docui='docker run --rm -itv /var/run/docker.sock:/var/run/docker.sock skanehira/docui'
alias sz="echo 'reload ~/.zshrc' && source ~/.zshrc"
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff'
fi

# Source
source <(kubectl completion zsh)
source <(stern --completion=zsh)
source <(helm completion zsh)

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%b)%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%b|%a)%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
}
add-zsh-hook precmd _update_vcs_info_msg


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# zsh-kubectl-prompt読み込み
source /home/linuxbrew/.linuxbrew/Cellar/zsh-kubectl-prompt/v1.3.0/etc/zsh-kubectl-prompt/kubectl.zsh

# プロンプトの設定
PENGUIN=$'\U1F427'

zstyle ':zsh-kubectl-prompt:' separator ' | '
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} ${vcs_info_msg_0_} %~
%{${fg[green]}%}(・Θ・)%{$reset_color%} "
RPROMPT="%{${fg[green]}%}$ZSH_KUBECTL_PROMPT%{${reset_color}%}"
PROMPT2="%{${fg[green]}%}🐈%{${reset_color}%} "


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi



########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:

# terminal char encording
case $TERM in
    linux) LANG=C ;;
    *)     LANG=ja_JP.UTF-8;;
esac

umask 002

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/takuma/google-cloud-sdk/path.zsh.inc' ]; then . '/home/takuma/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/takuma/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/takuma/google-cloud-sdk/completion.zsh.inc'; fi

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
