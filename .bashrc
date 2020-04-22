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
alias branch='git branch'
alias b='branch'
alias bgemacs='nohup emacs &'
alias bigrep='grep -A10 -B10 '
alias c='git commit'
alias countfiles='\ls -1 | wc -l'
alias cp='cp -i'
alias d='gdiff'
alias em='emacsclient --no-wait'
alias enswitch='export LANG=en_US.UTF-8'
alias frswitch='export LANG=fr_FR.UTF-8'
alias jpswitch='export LANG=ja_JP.UTF-8'
alias gc='git commit'
alias gd='git diff'
alias get_mol='lbvs_consent_mol_get'
alias gpull='git pull'
alias gpush='git push'
alias gstat='git status'
alias htop='nice htop -d 30'
alias i='svn info'
alias inject='eject -T'
alias agrep='agrep --color'
alias grep='grep --color'
alias igrep='grep -i'
alias jchempaint='java -jar ~/usr/jchempaint/jchempaint-3.3-1210.jar'
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
alias R='R --no-save'
alias remake='make clean && make'
alias resource='source ~/.bashrc'
alias restart_agent='eval `ssh-agent -s`'
alias revert='svn revert'
alias rm='rm -i'
alias s='git status'
alias sdiff='svn diff --diff-cmd tkdiff'
alias ssh-add='ssh-add -t 32400'
alias status='svn status | egrep -v "^\?"'
alias top='nice top'
alias u='update'
alias update='svn update'
# alias xlock='xscreensaver -no-splash || xscreensaver-command -lock'
alias xlock='xflock4'
alias yssh='ssh -Y'

# edit within a server emacs
function em () {
    emacsclient --no-wait $*
}

function a () {
    svn add    $*
    svn commit $*
}

function gdiff() {
    for f in `git status | grep modified: | awk '{print $2}'` ; do
        bash -c "export GIT_EXTERNAL_DIFF=~/bin/tkdiff_git_wrapper.sh ; \
                 git diff $f"
    done
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

export EDITOR=emacs
export GIT_EDITOR="emacs -nw -q" # no graphical window, no init file

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
    convert -flatten -density 600 -units PixelsPerInch $1 $output
    echo $output
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

function gpu-watch () {
    watch nvidia-smi -a --display=utilization
}

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

MY_BIN=~/bin
if [ -d $MY_BIN ]; then
    export PATH=$MY_BIN:$PATH
fi
# installed ruby gems
MY_BIN=~/.gem/ruby/2.3.0/bin
if [ -d $MY_BIN ]; then
    export PATH=$MY_BIN:$PATH
fi
# python pip installed programs
PY_BIN=~/.local/bin
if [ -d $PY_BIN ]; then
    export PATH=$PATH:$PY_BIN
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

# OPAM configuration
eval `opam env --shell=bash`

function fix() {
    # dual screen setup @ Kyutech
    xrandr --output DP-6 --mode 3840x2160 --pos 0x0    --rotate normal \
           --output DP-4 --mode 3840x2160 --pos 3840x0 --rotate normal
    # also kill the boring dialog window
    kill -9 $(ps -edf | grep xfce4-display-settings | grep -v grep | \
                  cut -d' ' -f2)
}

# disable gnome's ssh wrapper
unset SSH_ASKPASS

# MayaChemTools setup
MAYA_BIN=$HOME/src/mayachemtools/bin
alias MACCSKeysFingerprints=$MAYA_BIN/MACCSKeysFingerprints.pl

function name2smi () {
    java -jar ~/src/opsin/target/opsin-3.0-SNAPSHOT-jar-with-dependencies.jar \
         -osmi $1 $2
}

function name2inchikey () {
    java -jar ~/src/opsin/target/opsin-3.0-SNAPSHOT-jar-with-dependencies.jar \
         -ostdinchikey $1 $2
}

# printer
export PRINTER=OKI_MC362_DECC6C_N715_

# # kill gnome-keyring
# ps -edf | grep /usr/bin/gnome-keyring-daemon | grep -v grep | \
# awk '{system("kill -9 "$2)}'

# # open babel
# export BABEL_DATADIR=/usr/share/openbabel/2.4.1

# to run OCaml programs in production
ulimit -s 1048576

# MOE setup
export MOE=/home/ccg/moe
alias moe=$MOE/bin/moe
alias moebatch=$MOE/bin/moebatch

# OpenEye products
export OE_LICENSE=~/doc/oe_license.txt

# return the p-value of a K-S test
function ks () {
    ~/src/autoco/bin/ks.sh $1 1 $2 1 2>&1 | grep ', p-value ' | cut -d' ' -f6
}

function svg2eps () {
    tmp_pdf_out=`echo $1 | sed 's/\.svg$/\_tmp.pdf/g'`
    pdf_out=`echo $1 | sed 's/\.svg$/\.pdf/g'`
    ps_out=`echo $1 | sed 's/\.svg$/\.ps/g'`
    eps_out=`echo $1 | sed 's/\.svg$/\.eps/g'`
    svg=$1
    rsvg-convert -f pdf $svg -o $tmp_pdf_out
    pdfcrop $tmp_pdf_out $pdf_out
    pdf2ps $pdf_out $ps_out
    ps2eps < $ps_out > $eps_out
}

function smi2eps () {
    smi=$1
    svg_out=`echo $1 | sed 's/\.smi$/\.svg/g'`
    obabel $smi -O $svg_out -xC -xd
    svg2eps $svg_out
}

# keyboard layout
# setxkbmap -option ctrl:swapcaps # Swap Left Control and Caps Lock
setxkbmap -option ctrl:nocaps   # Make Caps Lock a Control key

# cut a multi model PDB into separate files
function split_pdb() {
    i=1
    while read -a line; do
        echo "${line[@]}" >> model_${i}.pdb
        [[ ${line[0]} == TER ]] && ((i++))
    done < $1
}

# crop pdf file in place
function crop_pdf () {
    tmp=`mktemp XXXXXX.pdf`
    pdfcrop $1 $tmp && \mv $tmp $1
}

function conda_setup () {
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/berenger/usr/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/berenger/usr/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/berenger/usr/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/berenger/usr/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
}

function deepchem () {
    conda_setup
    conda activate deepchem
    # to stop using it: conda deactivate
}
