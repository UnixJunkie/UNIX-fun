# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# huge history
export HISTFILESIZE=10000
export HISTSIZE=10000
# don't put duplicate lines in the history.
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

alias ..='cd ..'
alias ayssh='ssh -AY'
alias bgemacs='nohup emacs &'
alias c='svn commit'
alias countfiles='\ls -1 | wc -l'
alias cp='cp -i'
alias d='sdiff'
alias enswitch='export LANG=en_US.UTF-8'
alias frswitch='export LANG=fr_FR.UTF-8'
alias jpswitch='export LANG=ja_JP.UTF-8'
alias gcom='git commit'
alias gpull='git pull'
alias gpush='git push'
alias gstat='git status'
alias htop='nice htop'
alias i='svn info'
alias grep='grep --color'
alias igrep='grep -i'
alias l='ls -lrt'
alias la='ls -la'
alias ll='ls -l'
alias mv='mv -i'
alias md='mkdir'
alias m='make'
alias nwemacs='emacs -nw -bg black -fg white'
alias ocamlbuild='ocamlbuild -classic-display'
alias ooo='ooffice'
alias po='popd'
alias pu='pushd'
alias r='revert'
alias remake='make clean && make'
alias resource='source ~/.bashrc'
alias restart_agent='eval `ssh-agent -s`'
alias revert='svn revert'
alias rm='rm -i'
alias s='status'
alias sdiff='svn diff --diff-cmd tkdiff'
alias ssh-add='ssh-add -t 36000'
alias status='svn status | egrep -v "^\?"'
alias u='update'
alias update='svn update'
alias yssh='ssh -Y'

# edit within a server emacs
function em () {
    emacsclient --no-wait $*
}

function colordiff () {
    svn diff $* | grep -v '^@@.*@@$' | vim -R -
}

function a () {
    svn add    $*
    svn commit $*
}

function gdiff() {
    bash -c "export GIT_EXTERNAL_DIFF=bin/tkdiff_git_wrapper.sh ; git diff $*"
}

# print a reluctant PDF
function print_pdf() {
    pdf_in=$1
    ps_out=`echo $pdf_in | sed "s/\.pdf$/\.ps/g"`
    pdftops $pdf_in $ps_out
    konqueror $ps_out 2>&1 >> /dev/null &
}

# print line number n from file
# doesn't print anything if n is out of range
# n must be in [1; `wc -l file`]
# usage: getline n file
function getline () {
    awk -v LN=$1 '(NR==LN){print $0}' $2
}

export EDITOR="emacs -nw -bg black -fg white "
export PAGER=less

# svn side-by-side diff
function sbsdiff () {
    svn --diff-cmd "diff" \
--extensions "--suppress-common-lines -y --width=160" diff
}

# find here
function fh () {
    find . -name $*
}

## prevent bug provoqued by colorgcc setting CXX to colorgcc
# export CC=gcc
# export CXX=g++

# Python config
export PYTHONSTARTUP=~/.pystartup

# Inferno / Plan 9
#export PATH=$PATH:/usr/inferno/Linux/386/bin

function ccigrep () {
    grep -i $1 $(find . -name *.cc)
}

function cigrep () {
    grep -i $1 $(find . -name *.c)
}

function hhigrep () {
    grep -i $1 $(find . -name *.hh)
}

function higrep () {
    grep -i $1 $(find . -name *.h)
}

# output the number of residues in a given PDB file (dangerous)
function rescount () {
    grep -E "^ATOM " $1 | awk '{print $6}' | sort -n | uniq | wc -l
}

# output the number of ATOMs a given PDB file (dangerous)
function atomscount () {
    grep -cE "^ATOM " $1
}

# output first and last residue numbers in the given PDB file (dangerous)
function resrange () {
    FIRST=`grep -E "^ATOM " $1 | awk '{print $6}' | head -1`
    LAST=`grep -E "^ATOM " $1 | awk '{print $6}' | tail -1`
    echo $FIRST:$LAST
}

function dot2png () {
    output=`echo $1 | sed 's/\.dot$/\.png/g'`
    dot -T png $1 -o $output
}

function eps2png () {
    output=`echo $1 | sed 's/\.eps$/\.png/g'`
    convert -density 600 -units PixelsPerInch $1 $output
}

function whatprovides () {
    rpmquery --whatprovides $1
}

function kdesvn () {
    nohup kdesvn . &
}

# mpich2 daemon startup in userland
function mpdstart () {
    mpd --daemon --ncpus=4 --pid=/tmp/mpd_$USER.pid
}

function mpdstop () {
    mpdallexit
}

# cancel all jobs in the qsub queue (running or waiting)
function qcancel () {
    qstat | awk '{system ("qdel "$1)}'
}

# more informative than the default which
function which2() {
    ls -l `which $1`
}

# add line editing to the ocaml interpreter
alias ocaml='rlwrap -c -r ocaml'
alias ocamldebug='rlwrap -c -r ocamldebug'

# shell colors
SH_COLOR_TXTBLK='\e[0;30m' # Black - Regular
SH_COLOR_TXTRED='\e[0;31m' # Red
SH_COLOR_TXTGRN='\e[0;32m' # Green
SH_COLOR_TXTYLW='\e[0;33m' # Yellow
SH_COLOR_TXTBLU='\e[0;34m' # Blue
SH_COLOR_TXTPUR='\e[0;35m' # Purple
SH_COLOR_TXTCYN='\e[0;36m' # Cyan
SH_COLOR_TXTWHT='\e[0;37m' # White
SH_COLOR_BLDBLK='\e[1;30m' # Black - Bold
SH_COLOR_BLDRED='\e[1;31m' # Red
SH_COLOR_BLDGRN='\e[1;32m' # Green
SH_COLOR_BLDYLW='\e[1;33m' # Yellow
SH_COLOR_BLDBLU='\e[1;34m' # Blue
SH_COLOR_BLDPUR='\e[1;35m' # Purple
SH_COLOR_BLDCYN='\e[1;36m' # Cyan
SH_COLOR_BLDWHT='\e[1;37m' # White
SH_COLOR_UNDBLK='\e[4;30m' # Black - Underline
SH_COLOR_UNDRED='\e[4;31m' # Red
SH_COLOR_UNDGRN='\e[4;32m' # Green
SH_COLOR_UNDYLW='\e[4;33m' # Yellow
SH_COLOR_UNDBLU='\e[4;34m' # Blue
SH_COLOR_UNDPUR='\e[4;35m' # Purple
SH_COLOR_UNDCYN='\e[4;36m' # Cyan
SH_COLOR_UNDWHT='\e[4;37m' # White
SH_COLOR_BAKBLK='\e[40m'   # Black - Background
SH_COLOR_BAKRED='\e[41m'   # Red
SH_COLOR_BAKGRN='\e[42m'   # Green
SH_COLOR_BAKYLW='\e[43m'   # Yellow
SH_COLOR_BAKBLU='\e[44m'   # Blue
SH_COLOR_BAKPUR='\e[45m'   # Purple
SH_COLOR_BAKCYN='\e[46m'   # Cyan
SH_COLOR_BAKWHT='\e[47m'   # White
SH_COLOR_TXTRST='\e[0m'    # Text Reset

export PS1="\[$SH_COLOR_TXTGRN\]\u\[$SH_COLOR_BLDRED\]@\[$SH_COLOR_TXTGRN\]\h\[$SH_COLOR_BLDRED\]:\[$SH_COLOR_TXTGRN\]\W\[$SH_COLOR_BLDRED\]# \[$SH_COLOR_TXTRST\]"

alias libs_here='export LD_LIBRARY_PATH=`pwd`/lib:$LD_LIBRARY_PATH'

if [ -f ~/.Xresources ]; then
    xrdb ~/.Xresources
fi

MPI4PY=~/usr/mpi4py-1.2.1/lib64/python
if [ -d $MPI4PY ]; then
    export PYTHONPATH=$PYTHONPATH:$MPI4PY
fi

# colorize OCaml compiler output
# TODO: should show all the lines but color only the matched ones
function ocolor() {
    make $1 2>&1 | egrep -C 10000 --color \
"^File |^Warning |^Error: | line | characters "
}

# remove current directory and descendants from svn control
function svn_forget () {
    find . -name .svn -exec rm -rf {} \;
}

MY_BIN=~/bin
if [ -d $MY_BIN ]; then
    export PATH=$PATH:$MY_BIN
fi

function ccp4_setup() {
    source /usr/local/src/ccp4-6.2.0/setup-scripts/sh/ccp4.setup
    source /usr/local/src/ccp4-6.2.0/setup-scripts/sh/ccp4-others.setup
}

# to use locally installed phenix
function phenix_setup() {
    PHENIX_ENV=/usr/local/phenix-dev-756/phenix_env.sh
    if [ -f $PHENIX_ENV ]; then
        source $PHENIX_ENV
    fi
}

function godi_setup() {
    umask 022
    GODI_SETUP=/usr/local/godi/setup.sh
    if [ -f $GODI_SETUP ]; then
        source $GODI_SETUP
    fi
}

function ocamlbrew_setup() {
    source ~/ocamlbrew/ocaml-3.12.1/etc/ocamlbrew.bashrc
}

# running CCP4's sc tool
function ccp4_sc() {
    sc XYZIN $1 <<EOF
MOLECULE 1
CHAIN A
MOLECULE 2
CHAIN B
END
EOF
}
