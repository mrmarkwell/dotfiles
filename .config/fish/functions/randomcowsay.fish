function randomcowsay --wraps='cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)' --description 'alias randomcowsay cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)'
  cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $argv
        
end
