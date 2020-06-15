#!/bin/sh
export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig
export X11BASE=/usr/X11R6
while read solib sover ; do
	export LIB${solib}_VERSION=$sover
done <<EOF
EGL 1.1
gbm 0.4
glapi 0.2
GL 17.1
GLESv1_CM 2.0
GLESv2 2.0
OSMesa 11.0
EOF
rm -rf build
mkdir -p build
meson \
	-D gallium-drivers=r300,r600,swrast,radeonsi \
	-D dri-drivers=i915,i965,r100,r200 \
	-D vulkan-drivers=intel,amd \
	-D platforms=x11,drm \
	-D dri3=true \
	-D gles1=true \
	-D gles2=true \
	-D gbm=true \
	-D shared-glapi=true \
	-D prefix=${X11BASE} \
	-D dri-drivers-path=${X11BASE}/lib/modules/dri \
	-D dri-search-path=${X11BASE}/lib/modules/dri \
	build
ninja -vC build
