# Log to console Info, Warn and Error
#----------------------------------------------
c_off="\e[0m"       # Text Reset
c_blue="\e[34m"
c_yellow="\e[33m"
c_red="\e[31m"
info() {
  echo -e "${c_blue}$1${c_off}"
}
warn() {
  echo -e "${c_yellow}$1${c_off}"
}
error() {
  echo -e "${c_red}$1${c_off}"
}
#----------------------------------------------
