#organisation
ORG=$(cat /etc/puavo/domain|cut -d. -f1)
export PUAVO_ORG=$ORG

#usertype
if test -n "$PUAVO_SESSION_PATH" -a -e "$PUAVO_SESSION_PATH"; then
  TYPE=$(jq .user.user_type $PUAVO_SESSION_PATH|sed 's/"//g')
else
  TYPE="guest"
fi
export PUAVO_USERTYPE=$TYPE

#school
SCHOOL=$(ls  -l /home/|grep $USER$|xargs|cut -d\  -f4)
export PUAVO_SCHOOL=$SCHOOL

#class
GROUPS=$(groups)
if test "$TYPE" = "student"; then
  for G in $GOUPS; do
    if echo $G|grep -q "20"; then
      CLASS=$G
  done
else
  CLASS=$TYPE
fi
if ! test "$CLASS" = "$TYPE"  then
  export PUAVO_CLASS=$CLASS
fi

#like this (maybe)
#wget -O $HOME/.config/webmenu/menu.json  \ 
#     http://hadar.amxa.ch/$ORG/$SCHOOL/menu.php?user=$USER&type=$TYPE&class=$CLASS
#wget -O $HOME/.config/webmenu/tab.d/aa-tab.json \
#     http://hadar.amxa.ch/$ORG/$SCHOOL/tab.php?user=$USER&type=$TYPE&class=$CLASS

#will probably change soon
case $ORG in
  anwil)
      LIST="M_PROP M_GAMES"
      FIRST=""
      ;;
  basel)
      LIST="M_PROP M_WEBMENU_EDITOR M_GAMES"
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
  *)
      ;;
esac


if test "$TYPE" = "student"; then
   for F in $FIRST; do
      if echo $GROUPS|grep -q $F; then
         export M_FIRST=1
      fi
   done
fi

for L in $LIST; do
  export $L=1
done


