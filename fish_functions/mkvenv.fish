function mkvenv
  echo "Creating venv in $PWD..."
  python3 -m venv --upgrade-deps venv
end
