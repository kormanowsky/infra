directory="$(dirname "$0")"

function main(){
  echo "Updaing apt-get lists"
  sudo apt-get update -y
  echo "Installing snapd, docker"
  sudo apt-get install -y snapd docker
  echo "Installing jo via snap"
  sudo snap install jo
  echo "Installing yandex_tracker_client via pip"
  pip install yandex_tracker_client
  echo "Updating release ticket"
  . "$directory/update_ticket.sh"
  echo "Building app"
  npm install
  npm run build
  echo "Building image"
  docker build -t ${{ github.ref_name }} "$(dirname "$directory")"
  echo "Adding comment about Docker image"
  . "$directory/docker_comment.sh"
}

main
