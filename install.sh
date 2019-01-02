#!/usr/bin/env bash


{ # this ensures the entire script is downloaded #


git_repo_url='https://github.com/marcioapm/dotfiles.git'

__os() {
  printf %s "$(uname -s)"
}

__is_darwin() {
  [ "$(ebs_os)" == "Darwin" ]
}

__is_linux() {
  [ "$(ebs_os)" == "Linux" ]
}

__has() {
  type "$1" > /dev/null 2>&1
}

__script_path() {
  printf %s "$(cd "$(dirname "$0")"; pwd -P)"
}

__install_dir() {
  printf %s "${DOTFILES_DIR:-"$HOME/git/dotfiles"}"
}

__detect_profile() {
  if [ "${PROFILE-}" = '/dev/null' ]; then
    return
  fi

  if [ -n "${PROFILE}" ] && [ -f "${PROFILE}" ]; then
    echo "${PROFILE}"
    return
  fi

  local profile
  profile=''

  if [ -n "${BASH_VERSION-}" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      profile="$HOME/.bashrc"
    elif [ -f "$HOME/.bash_profile" ]; then
      profile="$HOME/.bash_profile"
    fi
  elif [ -n "${ZSH_VERSION-}" ]; then
    profile="$HOME/.zshrc"
  fi

  if [ -z "$profile" ]; then
    for eachprof in ".profile" ".bashrc" ".bash_profile" ".zshrc"
    do
      if [ -f "$HOME/$eachprof" ]; then
        profile="$eachprof"
        break
      fi
    done
  fi

  if [ ! -z "$profile" ]; then
    echo "$profile"
  fi
}

__ensure_profile() {
  local profile=$(__detect_profile)
  if [ ! -z "$profile" ]; then
    echo "=> shell profile detected at ${profile}"
  else
    echo "=> shell profile not detected"
    echo "=> creating a shell profile at ~/.bash_profile"
    touch ~/.bash_profile
  fi
}

__ensure_line() {
  if ! grep -Fqc "$1" "$2"; then
    printf "\n$1\n" >> "$2"
  fi
}

__ensure_line_regex() {
  if ! grep -qc "$3" "$2"; then
    printf "\n$1\n" >> "$2"
  fi
}

__change_profile() {
  local profile="$(__detect_profile)"
  local dir="$(__install_dir)"

  __ensure_line "export DOTFILES_DIR=$dir" "$profile" "export DOTFILES_DIR="
  __ensure_line "source \$HOME/.config/bash/profile" "$profile" "source \$HOME/.config/bash/profile"
}

__clone_dotfiles() {
  local dir="$(__install_dir)"
  if [ -d "$dir/.git" ]; then
    echo "=> git repository already exists - updating..."
    git --git-dir="$dir"/.git --work-tree="$dir" pull --rebase --recurse-submodules --autostash 1> /dev/null || {
      echo >&2 "=> failed to update git repository! check your permissions!"
      exit 1
    }
  else
    mkdir -p "$dir"
    git clone --recurse-submodules "$git_repo_url" "$dir" || {
      echo >&2 "=> failed to clone git repository! check your permissions!"
      exit 1
    }
  fi
}

__install_home() {
    local dir="$(__install_dir)"
    echo "=> installing home directory..."
    cp -Rvau $dir/home/. $HOME/
}

__install() {
  if ! __has git; then
    echo >&2 "=> you need git to install"
    exit 1
  fi

  echo "=> os: $(__os)"
  echo "=> install at $(__install_dir)"

  __clone_dotfiles
  __install_home
  __ensure_profile
  __change_profile

  echo "=> all done! re-open terminal and enjoy!"
}

__install
unset __install __clone_dotfiles __install_home __change_profile __ensure_line_regex __ensure_line  \
    __ensure_profile __detect_profile __install_dir __script_path __has __is_linux __is_darwin __os

} # this ensures the entire script is downloaded #
