function wisdom --wraps='fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)' --description 'alias wisdom fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)'
  fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $argv
        
end
