set -o vi
alias ls='ls -F --color'
alias nvim='nvim-qt -qwindowgeometry 800x600'


# ============================================================================
# MSYS/Bash
# ============================================================================

# Add important directories to path if using msys2
if [ "$MSYSTEM" = "MSYS" ]; then
    GITWIN="/c/Program Files/Git/mingw64/bin"
    HOMEBIN=$HOME/bin
    SYSPYTHON=/c/Python36/Scripts:/c/Python36
    VIM="/c/Program Files (x86)/vim/vim80"
    CHOCO=/c/ProgramData/chocolatey/bin
    MIKTEX="/c/Program Files/MiKTeX 2.9/miktex/bin/x64"
    YARN="/c/Program Files (x86)/Yarn/bin"
    USERYARN=/c/Users/deocampo/AppData/Local/Yarn/bin
    NODEJS="/c/Program Files/nodejs"
    MSBUILD="/c/Program Files (x86)/MSBuild/14.0/Bin"
    LOCALNPM="/c/Users/deocampo/AppData/Roaming/npm"
    export PATH=$GITWIN:$PATH
    export PATH=$PATH:$HOMEBIN:$SYSPYTHON:$VIM:$CHOCO:$MIKTEX:$YARN
    export PATH=$PATH:$USERYARN:$NODEJS:$MSBUILD:$LOCALNPM
    export MSYS_TYPE=$MSYSTEM

    # This is needed for virtualenvwrapper to work
    export MSYSTEM=MINGW64
fi


export MSYS_HOME=$PROGRAMFILES/Git
BASH_HOME=$HOME

# Setup EDITOR env var
export EDITOR=$(which vim)

# ============================================================================
# XDG directories
# ============================================================================
# Setup XDG directories
export XDG_CONFIG_HOME=$USERPROFILE/AppData/Local
export XDG_DATA_HOME=$HOME/.local/share

# ============================================================================
# Go
# ============================================================================
export GOPATH=$HOME/go

# ============================================================================
# Java
# ============================================================================

export JAVA_HOME="/c/Program Files/ojdkbuild/java-1.8.0-openjdk-1.8.0.131-1"
export PATH=$PATH:$JAVA_HOME/bin

# Sonarlint-cli
export PATH=$PATH:$HOME/opt/sonarlint-cli-2.1.0.566/bin

# ============================================================================
# PostgreSQL
# ============================================================================

export PG_HOME="/c/Program Files/PostgreSQL/9.6"
export PATH=$PATH:$PG_HOME/bin

# ============================================================================
# CMake
# ============================================================================
export CMAKE_PATH=/c/Program\ Files/CMake/bin/
export PATH=$PATH:$CMAKE_PATH

# ============================================================================
# Neovim
# ============================================================================
# export neovim location
export PATH=$PATH:$HOME/opt/neovim/bin

# ============================================================================
# Visual Studio setup
# ============================================================================

# # export VS17 bin, lib, and includes
# VS17_HOME="/c/Program Files (x86)/Microsoft Visual Studio/2017/Community"
# SDK_HOME="/c/Program Files (x86)/Windows Kits"
# UCRT_VER="10.0.10240.0"
# # UCRT_VER="10.0.14393.0"
# # MSVC_VER="14.10.24728"
# MSVC_VER="14.10.25017"
# PLATFORM="64"

# # # Either have this path export or the one below
# # # export PATH="$SDK_HOME/8.1/bin/x$PLATFORM":$PATH

# # Either have this path export or the one above
# export PATH="$VS17_HOME/VC/Tools/MSVC/$MSVC_VER/bin/HostX$PLATFORM/x$PLATFORM":"$SDK_HOME/8.1/bin/x$PLATFORM":$PATH

# export INCLUDE="$SDK_HOME/10/Include/$UCRT_VER/ucrt":"$VS17_HOME/VC/Tools/MSVC/$MSVC_VER/include":"$SDK_HOME/8.1/Include/shared":"$SDK_HOME/8.1/Include/um"
# export LIB="$SDK_HOME/8.1/Lib/winv6.3/um/x$PLATFORM":"$VS17_HOME/VC/Tools/MSVC/$MSVC_VER/lib/x$PLATFORM":"$SDK_HOME/10/Lib/$UCRT_VER/ucrt/x$PLATFORM"

# ============================================================================
# SonarQube-MSBuild
# ============================================================================


SONAR_DIR=$HOME/opt/sonarqube-msbuild
export PATH=$PATH:$SONAR_DIR


# ============================================================================
# Rust setup
# ============================================================================

# Exports for Rust
export RUSTUP_HOME=$HOME/AppData/Local/rustup
export CARGO_HOME=$HOME/AppData/Local/cargo
export PATH=$PATH:$CARGO_HOME/bin
export RUST_SRC_PATH=$($CARGO_HOME/bin/rustc --print sysroot)/lib/rustlib/src/rust/src
export CARGO_INCREMENTAL=0
source $BASH_HOME/.config/bash/bash_completion.d/rustup-completion.bash

# ============================================================================
# Ctags setup
# ============================================================================

# Ctags
# export PATH=$PATH:$HOME/universal-ctags

# ============================================================================
# Kdiff3
# ============================================================================

if [ -z "$(type -P 'kdiff3')" ]; then
    export PATH=$PATH:/c/Program\ Files/KDiff3
fi

# ============================================================================
# Python setup
# ============================================================================

# export python location
export PYTHON_DIR=/c/python36
VENV_WRAPPER_BIN=$PYTHON_DIR/Scripts/virtualenvwrapper.sh

# Virtualenv
export WORKON_HOME=$BASH_HOME/python/venv

# export conda location
# export CONDA_HOME=$LOCALAPPDATA/Continuum/MiniConda3
# export PATH=$PATH:$HOME/python/miniconda3/Scripts

# Set utf8 encoding for python3.5+
/c/windows/system32/chcp.com 65001 > /dev/null

# Set utf-8 for python2.7
export PYTHONIOENCODING=UTF-8

# Set quote style
export QUOTING_STYLE=literal

if [ -f $VENV_WRAPPER_BIN ]; then
    source $VENV_WRAPPER_BIN
fi

# ============================================================================
# Git flow
# ============================================================================

source $BASH_HOME/.config/bash/bash_completion.d/git-flow-completion.bash

# ============================================================================
# SSH
# ============================================================================
# Setup SSH

# ssh-pageant
# eval $(/usr/bin/ssh-pageant -r -a "/tmp/.ssh-pageant-$USERNAME")

SSH_ENV="$HOME/.ssh/environment"
GIT_SSH="/usr/bin/ssh.exe"

function start_agent
{
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cygwin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	start_agent;
    }
else
    start_agent;
fi

# ============================================================================
# Python Virtualenv
# ============================================================================
# System venv
# . $BASH_HOME/python/venv/devel-3.5.2/Scripts/activate
workon devel-3.6.4

# Conda venv
# . activate devel-3.6.0
# . activate devel
