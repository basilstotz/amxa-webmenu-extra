ORG=$(cat /etc/puavo/domain|cut -d. -f1)

export PAUVO_ORG=$ORG

if test -n "$PUAVO_SESSION_PATH" -a -e "$PUAVO_SESSION_PATH"; then
  TYPE=$(jq .user.user_type $PUAVO_SESSION_PATH|sed 's/"//g')
else
  TYPE="guest"
fi
export PUAVO_USERTYPE=$TYPE

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
   GROUPS=$(groups)
   for F in $FIRST; do
      if echo $GROUPS|grep -q $F; then
         export M_FIRST=1
      fi
   done
fi

for L in $LIST; do
  export $L=1
done


