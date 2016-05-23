ORG=$(cat /etc/puavo/domain|cut -d. -f1)

case $ORG in
  anwil)
      LIST="PROP M_GAMES"
      ;;
  basel)
      LIST="PROP M_WEBMENU_EDITOR M_GAMES"
      ;;
  ksnuwi)
      LIST="PROP M_GAMES"
      ;;
  laeufelfingen)
      LIST="PROP M_GAMES"
      ;;
  *)
      ;;
esac

for L in $LIST; do
  export $L=1
done


