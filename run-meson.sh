#!/bin/sh
export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig
export X11BASE=/usr/X11R6
while read solib sover ; do
	export LIB${solib}_VERSION=$sover
done <<EOF
EGL 1.2
gbm 0.6
glapi 0.4
GL 17.2
GLESv1_CM 2.0
GLESv2 2.0
OSMesa 12.1
XvMCr600 1.0
EOF
rm -rf build
mkdir -p build
meson \
	-D gallium-drivers=swrast,r300,r600,radeonsi,i915,crocus,iris \
	-D vulkan-drivers=intel,intel_hasvk,amd \
	-D gallium-xa=disabled \
	-D platforms=x11 \
	-D dri3=enabled \
	-D gles1=enabled \
	-D gles2=enabled \
	-D gbm=enabled \
	-D osmesa=true \
	-D shared-glapi=enabled \
	-D zstd=disabled \
	-D execmem=false \
	-D cpp_rtti=false \
	-D b_ndebug=true \
	-D prefix=${X11BASE} \
	-D dri-drivers-path=${X11BASE}/lib/modules/dri \
	-D dri-search-path=${X11BASE}/lib/modules/dri \
	build
ninja -vC build
