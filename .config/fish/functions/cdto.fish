function cdto --wraps=cd --description 'cd to the directory containing a file'
  cd (dirname $argv); 
end

