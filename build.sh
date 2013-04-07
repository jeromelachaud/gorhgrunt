#!/bin/bash
# Nettoyage, version 3.

REP_BUILD="`pwd`/build"
rm -rf $REP_BUILD

cd $REP_BUILD

if [ `pwd` != "$REP_BUILD" ]  # ou   if [ "$PWD" != "$REP_BUILD" ]

then
  echo "creation du rep build"
  mkDir $REP_BUILD
  cd $REP_BUILD
fi


echo "build crée"

exit 0