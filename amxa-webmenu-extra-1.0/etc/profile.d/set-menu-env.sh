#devicetype
DEVICETYPE=$(jq .type /etc/puavo/device.json|sed 's/"//g')
export PUAVO_DEVICETYPE="$DEVICETYPE"

#organisation
ORG=$(cat /etc/puavo/domain|cut -d. -f1)
export PUAVO_ORG="$ORG"

#usertype
if test -n "$PUAVO_SESSION_PATH" -a -e "$PUAVO_SESSION_PATH"; then
  TYPE=$(jq .user.user_type $PUAVO_SESSION_PATH|sed 's/"//g')
else
  USERTYPE="guest"
fi
export PUAVO_USERTYPE=$USERTYPE

#school
SCHOOL=$(ls -l /home| grep $(ls /home|head -n1)|xargs|cut -d\  -f4)
export PUAVO_SCHOOL="$SCHOOL"

#class
GROUPS=$(groups)
if test "$USERTYPE" = "student"; then
  for G in $GOUPS; do
    if echo $G|grep -q "20"; then
      CLASS="$G"
    fi
  done
else
  CLASS=$USERTYPE
fi
if ! test "$CLASS" = "$USERTYPE";  then
  export PUAVO_CLASS="$CLASS"
fi

export PUAVO_GROUPS=$(echo $GROUPS|sed 's/ /:/g')


if test -e /etc/webmenu/menu_$CLASS.json; then
    cp /etc/webmenu/menu_$CLASS.json $HOME/.config/webmenu/menu.json
fi

if test -e $HOME/.config/webmenu/menu.json; then
  export M_CUSTOM=1
fi

if test -e /etc/webmenu/tabd_$CLASS.json; then
    cp /etc/webmenu/tabd_$CLASS.json $HOME/.config/webmenu/tab.d/aaa-menu.json
fi


#like this (maybe)
#wget -O $HOME/.config/webmenu/menu.json  \ 
#     http://hadar.amxa.ch/$ORG/$SCHOOL/menu.php?user=$USER&type=$TYPE&class=$CLASS
#wget -O $HOME/.config/webmenu/tab.d/aa-tab.json \
#     http://hadar.amxa.ch/$ORG/$SCHOOL/tab.php?user=$USER&type=$TYPE&class=$CLASS

#will probably change soon

if test -e /etc/webmenu/env.sh; then
   . /etc/webmenu/menuenv.sh
else
  case $ORG in
    anwil)
      LIST="M_PROP M_GAMES M_LESEWERKSTATT"
      FIRST=""
      ;;
    basel)
      LIST="M_PROP M_WEBMENU_EDITOR M_GAMES M_LESEWERKSTATT"
      FIRST="2014A 2014B 2015A 2015B"
      ;;
    ksnuwi)
      LIST="M_PROP M_GAMES"
      FIRST=""
      ;;
    laeufelfingen)
      LIST="M_PROP M_GAMES"
      FIRST=""
      ;;
    larippe)
      LIST="M_GAMES"
      FIRST=""
      ;;
    *)
      LIST="M_GAMES"
      FIRST=""
      ;;
  esac

  if test "$USERTYPE" = "student"; then
    for F in $FIRST; do
      if echo $GROUPS|grep -q $F; then
         export M_FIRST=1
      fi
    done
  fi

  for L in $LIST; do
    export $L=1
  done

fi

