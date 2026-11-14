# Colormap
function colormap() {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

function killp() {
  local port=$1
  local pids=$(lsof -ti:$port)

  if [ -z "$pids" ]; then
    echo "nothing there"
  else
    echo "$pids" | xargs kill -9 2>/dev/null
    echo "process killed"
  fi
}

function pscripts () {
  local f="${1:-package.json}"
  if command -v jq >/dev/null 2>&1; then
    jq -r '.scripts // {} | to_entries | sort_by(.key)[] | "\(.key)\t\(.value)"' "$f"
  else
    node -e "const s=require('./${f}').scripts||{}; for (const k of Object.keys(s).sort()) console.log(k+'\t'+s[k])"
  fi
}
