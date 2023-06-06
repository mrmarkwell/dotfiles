function addalias --description 'quickly create aliases'
  echo "Adding new alias!"
  echo "    abbr -a $argv[1] $argv[2..]"
  echo ""
  echo "abbr -a $argv[1] $argv[2..]" >> ~/.config/fish/shortcuts.fish
  source ~/.config/fish/shortcuts.fish > /dev/null
end

