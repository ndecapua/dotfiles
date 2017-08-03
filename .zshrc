# home env
unset PATH
TERM=xterm-256color
PATH="${HOME}/src/cfengine/bin:${HOME}/bin:/bin:/usr/bin:/usr/local/bin:/net/sysadm/bin:/usr/local/pkg/bin:/var/cfengine3/bin:/usr/local/sbin:/usr/local/go/bin"
EDITOR=/usr/bin/vim
export PATH EDITOR CFROOT TERM

# system env
if [[ ! -n ${HOSTNAME} ]]; then
    HOSTNAME=`hostname -f`
    export HOSTNAME
fi

# oh-my-zsh
export ZSH=${HOME}/.oh-my-zsh
CASE_SENSITIVE="true"
ZSH_THEME="ndecapua"
DISABLE_AUTO_TITLE="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(vi-mode pip python colored-man-pages golang colorize vundle docker fabric fancy-ctrl-z gitfast tmux) 

source $ZSH/oh-my-zsh.sh
unsetopt auto_name_dirs

# oh-my-zsh jira plugin
JIRA_URL=https://owl.cbsi.com/jira
JIRA_NAME=ndecapua
export JIRA_URL JIRA_NAME

# loadenv_ppr setup
export CFROOT=${HOME}/src/cfengine
if [[ -f ${CFROOT}/bin/loadenv_ppr ]]; then
    source ${CFROOT}/bin/loadenv_ppr
fi

# session title
export SSH_FROM=$(getent hosts $(echo $SSH_CLIENT | cut -d" " -f1) | cut -d" " -f5)
echo -ne "\ek${HOSTNAME%.*.*}\e\\"

function onexit {
    echo -ne "\ek${SSH_FROM%.*.*}\e\\"
}
trap onexit EXIT

# virtualenvwrapper
WORKON_HOME=~/env
PROJECT_HOME=~/src
VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME VIRTUAL_ENV_DISABLE_PROMPT VIRTUALENVWRAPPER_VIRTUALENV_ARGS PROJECT_HOME
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
