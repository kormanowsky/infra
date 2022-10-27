function main() {
  echo ""
  echo "Installing packages"
  npm install
  echo "Running linter"
  npm run lint
  echo "Running TS check"
  npm run ts
}

main
