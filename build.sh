#!/bin/bash
# Nettoyage, version 3.

#  Attention :
#  -----------
#  Ce script utilise quelques fonctionnalités qui seront expliquées 
#+ bien après.
#  Lorsque vous aurez lu toute la première moitié de ce livre, plus
#+ rien ne vous paraîtra mystérieux.
REP_SOURCES="`pwd`/sources"
REP_BUILD="`pwd`/build"
UID_ROOT=0     # Seuls les utilisateurs avec un $UID valant 0 ont les droits de root.
LIGNES=50      # Nombre de lignes sauvegardées par défaut.
E_XCD=66       # On ne peut pas changer de répertoire ?

rm -rf $REP_BUILD
	e
if [ -n "$1" ]
# Teste la présence d'un argument (non vide) sur la ligne de commande.
then
  lignes=$1
else  
  lignes=$LIGNES # Par défaut, s'il n'est pas spécifié sur la ligne de commande.
fi  

cd $REP_BUILD

if [ `pwd` != "$REP_BUILD" ]  # ou   if [ "$PWD" != "$REP_BUILD" ]

then
  echo "creation du rep build"
  mkDir $REP_BUILD
  cd $REP_BUILD
fi

c -av --exclude='/node_modules/' $REP_SOURCES/ .

# bien plus efficace:
#
# cd /var/log || {
#   echo "Impossible d'aller dans le répertoire." >&2
#   exit $E_XCD;
# }

echo "build crée"

exit 0