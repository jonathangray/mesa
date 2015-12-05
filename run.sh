#!/bin/sh
export AUTOMAKE_VERSION=1.12
export AUTOCONF_VERSION=2.69
export ACLOCAL="aclocal -I /usr/X11R6/share/aclocal"
export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig
export X11BASE=/usr/X11R6
if [[ $(uname -p) == "i386" ]]; then
	export USER_CFLAGS="-march=i586"
	export USER_CXXFLAGS="-march=i586"
fi
export CC=/usr/bin/cc
export CXX=/usr/bin/c++
./autogen.sh \
--with-gallium-drivers=r300,r600,swrast \
--with-dri-drivers=i915,i965,r200,radeon,swrast \
--disable-silent-rules \
--disable-llvm \
--disable-glx-tls \
--enable-gles1 --enable-gles2 \
--enable-shared-glapi \
--enable-osmesa \
--enable-debug \
--enable-gbm \
--enable-texture-float \
--with-egl-platforms="x11,drm" \
--prefix=${X11BASE} \
--with-dri-driverdir=${X11BASE}/lib/modules/dri \
--with-dri-searchpath=${X11BASE}/lib/modules/dri
