#This File is a hoby file for clean your linux system
#Version1.0 abviable 

echo Linux Clean System V1.0
#This version only was tested on Ubuuntu 24.0

echo "------------------------"


#MENU

while true; do
  echo
  echo "1) Clear Bash history"
  echo "2) Clear APT chache"
  echo "3) Clean System Logs"
  echo "4) Clean Tumbail Cache"
  echo "5) Clean Trash "
  echo "6) FUll"
  read -p  "Enter your choice.... " choice

  case $choice in
    1)
      echo "Clening Bash Hisotory"
      history -c
      history -w
      ;;
    2)
      echo "Cloning APT cache"
      sudo apt clean
      ;;

    esac

  done
#echo "Clening Hisotory Box" && history -c
