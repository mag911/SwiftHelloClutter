#!/bin/bash
#
ver=1.0
Mod=`grep name: Package.swift | head -n1 | cut -d'"' -f2`
Module=${Mod}-$ver
mod=`echo "${Mod}" | tr '[:upper:]' '[:lower:]'`+
module="${mod}-${ver}"
EXECUTABLE_NAME=${Mod}
PRODUCT_NAME=${Mod}
FULL_PRODUCT_NAME=${Mod}.app
PRODUCT_BUNDLE_IDENTIFIER=${ID}.${Mod}
MACOSX_DEPLOYMENT_TARGET=10.11
RESOURCES_DIR=`pwd`/Resources
BUILD_DIR=`pwd`/.build
BUILD_BIN=${BUILD_DIR}/debug
BUILT_PRODUCTS_DIR=${BUILD_DIR}/app
export PATH="${BUILD_DIR}/gir2swift/.build/release:${BUILD_DIR}/gir2swift/.build/debug:${PATH}"
GOBJECT_LIBDIR=`pkg-config --libs-only-L gobject-introspection-1.0 2>/dev/null | tr ' ' '\n' | grep gobject-introspection | tail -n1 | cut -c3-`
LINKFLAGS=`pkg-config --libs clutter-$ver pangocairo pangoft2 pango gobject-2.0 gio-unix-2.0 glib-2.0 | sed -e 's/  */ /g' -e 's/ *$//' | tr ' ' '\n' | tr '	' '\n' | sed -e 's/^/-Xlinker /' -e 's/-Wl,//' | tr '\n' ' ' | sed -e 's/-pthread/-lpthread/g' | sed -e 's/^/-Xlinker /' -e 's/-Wl,//g' -e 's/ -pthread/ -lpthread/g' -e 's/-Xcc[ 	]*-Xlinker/-Xlinker/g' -e 's/-Xlinker[ 	]*-Xcc/-Xcc/g' -e 's/-Xlinker[ 	]*--export-dynamic//g' -e 's/-Xlinker[ 	]*-Xlinker/-Xlinker/g' -e 's/-Xcc[ 	]*$//' -e 's/-Xlinker[ 	]*$//'`" -Xlinker -L/usr/local/lib"
CCFLAGS=`pkg-config --cflags clutter-$ver pangocairo pangoft2 pango gobject-2.0 gio-unix-2.0 glib-2.0 | sed -e 's/  */ /g' -e 's/ *$//' | tr ' ' '\n' | tr '	' '\n' | sed 's/^/-Xcc /' | tr '\n' ' ' | sed -e 's/^/-Xlinker /' -e 's/-Wl,//g' -e 's/ -pthread/ /g' -e 's/-Xcc[ 	]*-Xlinker/-Xlinker/g' -e 's/-Xlinker[ 	]*-Xcc/-Xcc/g' -e 's/-Xlinker[ 	]*--export-dynamic//g' -e 's/-Xlinker[ 	]*-Xlinker/-Xlinker/g' -e 's/-Xcc[ 	]*$//' -e 's/-Xlinker[ 	]*$//' -e 's/-Xcc[ 	]*$//'`
TAC="tail -r"
if which tac >/dev/null ; then
   TAC=tac
   else if which gtac >/dev/null ; then
	TAC=gtac
   fi
fi
