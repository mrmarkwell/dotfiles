# Bash aliases and environment variables.

# Update path with local executables.
if [ -d "$HOME/.local/bin" ] ; then
  PATH="$PATH:$HOME/.local/bin"
fi

# ENV Variables
export R_LIBS="~/r_libs"
export GIT_EDITOR="vim"
export IBAPI="~/dev/tws_python_api/IBJts/source/pythonclient/ibapi/"
export PPE="~/dev/pukala_private_equity/"

# Aliases

#power commands

# Example Usage - find and replace in cpp files
#       Make sure you're replacing only stuff you want to replace
#   $ grepc -r SearchTerm
#       Replace stuff
#   $ findc | xargs sed -i 's/SearchTerm/ReplaceTerm/g'
#       Or
#   $ sedc -i 's/SearchTerm/ReplaceTerm/g'
alias findc="find . -name '*.cc' -o -name '*.cpp' -o -name '*.c' -o -name '*.h'"
alias grepc="findc | xargs grep --color"
alias sedc="findc | xargs sed"

#navigation aliases
alias cdib="cd $IBAPI"
alias cdp="cd $PPE"

#shell aliases


pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
#  echo -n "DIRSTACK: "
#  dirs
}

pushd_builtin()
{
  builtin pushd > /dev/null
#  echo -n "DIRSTACK: "
#  dirs
}

popd()
{
  builtin popd > /dev/null
#  echo -n "DIRSTACK: "
#  dirs
}

# Make cd work for file paths in addition to dir paths.
# Use pushd to make 'back' possible.
fcd() {
  [ -f "$1" ] && { pushd "$(dirname "$1")"; } || { pushd "$1"; };
}
alias cd="fcd";
alias back="popd"
alias flip="pushd_builtin" # jump back and forth between 2 locations

#git aliases

# Diff HEAD in meld
alias gitdiff="git difftool --dir-diff --tool=meld HEAD~ HEAD"

#git aliases
alias gitbranchcleanup="git branch --merged | egrep -v \"(^\*|master|dev)\" | xargs git branch -d"

alias showaliases="cat ~/.bash_aliases ~/.shortcuts | grep '^alias'"

alias sb='source ~/.bash_aliases'
alias eb='vim ~/.bash_aliases'

alias aliashelp='less ~/.bash_aliases'
alias tmuxhelp='less ~/.tmux.conf'
alias nvimhelp='less ~/.nvimhelp'

eval `dircolors -b ~/.dir_colors/dircolors`

# Adds an alias to the .shortcuts file and then sources it.
# Usage:
#    addalias alias_name "The alias"
#
addalias() {
  echo "Adding new alias!"
  echo "    alias $1='$2'"
  echo ""
  echo "alias $1='$2'" >> ~/.shortcuts
  source ~/.shortcuts > /dev/null
}

source ~/.shortcuts > /dev/null

# shell options
shopt -s direxpand # expand environment variable directories

PS1_PROMPT() {
  local e=$?
  PROMPT_ECODE=
  (( e )) && PROMPT_ECODE="$e|"
  return $e
}

PROMPT_COMMAND=PS1_PROMPT
PS1='$PROMPT_ECODE'"$PS1"

alias vim='nvim'
