if [[ ! -o interactive ]]; then
    return
fi

compctl -K _de de

_de() {
  local word words completions
  read -cA words
  word="${words[2]}"

  if [ "${#words}" -eq 2 ]; then
    completions="$(de commands)"
  else
    completions="$(de completions "${word}")"
  fi

  reply=("${(ps:\n:)completions}")
}
