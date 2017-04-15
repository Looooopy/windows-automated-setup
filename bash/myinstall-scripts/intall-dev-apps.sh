. ./output-helper.sh
. ../../.usersettings

# Don't forget to create a new ".usersettings" file containing
#export WINUSER=
#export WINPWD=
#export GIT_NAME=
#export GIT_EMAIL=
#export GIT_MERGE_TOOL=


installpath=/usr/local/bin
installpath2=/usr/bin


install() {
  sudo apt-get ---yes --force-yes install $1
}

remove() {
  sudo apt-get ---yes --force-yes remove $1
}


#read -s -p "Enter Password for sudo: " sudoPW
#echo $sudoPW | sudo usermod -aG sudo $user
sudo usermod -aG sudo $(whoami)

sudo apt-get update

info "Install compression softwaree"
install 'zip unzip bsdtar'

info "Install git and tools for git"
install git

info "Add/Update symbolic links:"
myconfig=$(pwd)/../myconfig
echo $myconfig
cp $myconfig/.gitconfig $myconfig/.gitconfig-linux
sudo ln -sfv "$myconfig/.gitconfig-linux" ~/.gitconfig

info "Update git with config"
git config --global color.ui true
git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global merge.tool $GIT_MERGE_TOOL
git config --global core.autocrlf true
git config --global core.editor atom --wait


if $( type ngrok | grep -c "$installpath/ngrok" | grep -q "0" ) ; then
  info "Install ngrok"
  ngroktmp=/tmp/ngrok.zip
  curl -L https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o $ngroktmp
  sudo bsdtar -xf $ngroktmp -C $installpath
  rm $ngroktmp
else
  warn ">>>> Already Installed: ngrok"
fi

if $( type jq | grep -c "$installpath2/jq" | grep -q "0" ) ; then
  info "Install JQ"
  install jq
else
  warn ">>>> Already Installed: jq"
fi

if $( type docker | grep -c "$installpath2/docker" | grep -q "0" ) ; then
  info "Install docker"
  install docker.io
else
  warn ">>>> Already Installed: docker"
fi

if $( cat ~/.bashrc | grep -c 'export DOCKER_HOST="tcp://127.0.0.1:2375"' | grep -q "0" ) ; then
  info "Setup docker client to connect to the windows docker"
  echo 'export DOCKER_HOST="tcp://127.0.0.1:2375"' | tee -a ~/.bashrc > /dev/null
  rebootbash=1
else
  warn ">>>> Already Setup docker client to connect to the windows docker"
fi

if $( type docker-compose | grep -c "$installpath/docker-compose" | grep -q "0" ) ; then
  info "Install docker-compose"
  dcversion="1.12.0"
  dcompose=/tmp/docker-compose
  curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m`  -o $dcompose
  sudo mv $dcompose $installpath/docker-compose
  sudo chmod +x $installpath/docker-compose
  #rm $dcompose
else
  warn ">>>> Already Installed: docker-compose"
fi

if $( type lpass | grep -c "$installpath2/lpass" | grep -q "0" ) ; then
  info "install lpass-cli"
  install 'openssl libcurl4-openssl-dev libxml2 libssl-dev libxml2-dev pinentry-curses xclip'
  install build-essential
  install 'pkg-config libsqlite3-dev cmake'
  cd /tmp
  git clone -b 'v1.1.2' --single-branch https://github.com/lastpass/lastpass-cli.git  ./lastpass
  cd lastpass
  cmake . && make
  sudo make install
else
  warn ">>>> Already Installed: lpass-cli"
fi

if [ "$rebootbash" == "1" ] ; then
  error "Please RESTART your bash"
fi
