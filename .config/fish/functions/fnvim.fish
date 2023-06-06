function fnvim --description 'fzf to nvim, with optional query'
  nvim $(fzf --query "$argv")
end

