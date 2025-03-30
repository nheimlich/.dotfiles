### PATHS ###
fpath=(${fpath} "/Users/nheimlich/.zfunctions")
export PATH="${KREW_ROOT:-${HOME}/.krew}/bin:${PATH}"
export DOCKER_HOST='unix:///var/folders/_d/9hg093s16cj8c3np1xh6s7gw0000gn/T/podman/podman-machine-default-api.sock'

### ENVIRONMENT VARIABLES ###
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export COMPOSE_DOCKER_CLI_BUILD=0
export DOCKER_DEFAULT_PLATFORM=linux/arm64
export DOCKER_BUILDKIT=1
export NVM_DIR="${HOME}/.nvm"
export do="\-o=yaml --dry-run=client"

### ALIASES ###
alias serve="browser-sync start --server --files ."
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias curltime="curl -w \"@${HOME}/.curl-format.txt\" -o /dev/null -s "
alias k=kubectl
alias krc='kubectl config current-context'
alias klc='kubectl config get-contexts -o name | sed "s/^/  /;\|^  $(krc)$|s/ /*/"'
alias kcc='kubectl config use-context "$(klc | fzf -e | sed "s/^..//")"'
alias krn='kubectl config get-contexts --no-headers "$(krc)" | awk "{print \$5}" | sed "s/^$/default/"'
alias kln='kubectl get -o name ns | sed "s|^.*/|  |;\|^  $(krn)$|s/ /*/"'
alias kcn='kubectl config set-context --current --namespace "$(kln | fzf -e | sed "s/^..//")"'
alias hrc='find /etc/hosts-custom -inum $(ls -i /etc/hosts | awk '\''{print $1}'\'') -exec ls -i {} \;'
alias hlc='ls -1 /etc/hosts-custom/'
alias hcc='sudo rm -f /etc/hosts && sudo ln /etc/hosts-custom/$(ls -hF /etc/hosts-custom/ | grep -v "/$" | fzf -e) /etc/hosts'
alias hec='sudo vi /etc/hosts-custom/$(ls /etc/hosts-custom/ | fzf -e)'

### HISTORY SETTINGS ###
setopt EXTENDED_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T]"
export HISTFILE=${ZDOTDIR:-${HOME}}/.zsh_hist
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=${HISTSIZE}

### FUNCTIONS ###
function git {
  case "${1}" in
    commit)
      shift
      command git commit --signoff "$@"
      ;;
    *)
      command git "$@"
      ;;
  esac
}

function kubectlgetall {
  echo "usage: kubectlgetall namespace"
  if [[ $# -eq 0 ]]; then return; fi
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events" | sort | uniq); do
    echo "Resource: ${i}" && kubectl get "${i}" -n "${1}" --ignore-not-found=true
  done
}

function xmanpage { open x-man-page://"${1}"; }

function kcleanup {
  kubectl delete pods --field-selector=status.phase=Failed -A
  kubectl delete pods --field-selector=status.phase=Succeeded -A
}

function kcomp {
  echo "krc: get current context"
  echo "klc: list all contexts"
  echo "kcc: change contexts"
  echo "krn: get current namespace"
  echo "kln: list namespaces"
  echo "kcn: change namespace"
}

function hcomp {
  echo "hrc: get current hosts context"
  echo "hlc: list all hosts contexts"
  echo "hcc: change contexts"
  echo "hec: edit host file"
  echo "hreload: reload dns"
}

### AUTOJUMP ###
[[ -f /opt/homebrew/etc/profile.d/autojump.sh ]] && . /opt/homebrew/etc/profile.d/autojump.sh

### PROMPT SETTINGS ###
autoload -Uz promptinit; promptinit
prompt typewritten
export TYPEWRITTEN_PROMPT_LAYOUT="singleline"
export TYPEWRITTEN_SYMBOL="❯"
export TYPEWRITTEN_ARROW_SYMBOL="->"
export TYPEWRITTEN_RELATIVE_PATH="adaptive"
export TYPEWRITTEN_CURSOR="block"
export TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=display_kube_context

function display_kube_context {
  tw_kube_context="$(kubectl config current-context 2> /dev/null)"
  if [[ ${tw_kube_context} != "" ]]; then
    echo "($(basename "${tw_kube_context}"))"
  fi
}

### KUBECTL COMPLETION ###
autoload -Uz compinit; compinit
source <(kubectl completion zsh)
source <(talosctl completion zsh)

### NVM ###
[[ -s "${NVM_DIR}/nvm.sh" ]] && \. "${NVM_DIR}/nvm.sh"
[[ -s "${NVM_DIR}/bash_completion" ]] && \. "${NVM_DIR}/bash_completion"
