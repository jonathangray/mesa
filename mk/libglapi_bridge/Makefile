#	$OpenBSD$

LIB=	glapi_bridge

NOPROFILE=

SRCS=	libgl_public.c

.include "../Makefile.inc"

CPPFLAGS+=	-I${MESA_SRC}/src/mapi \
		-I${MESA_SRC}/generated/src/mapi/glapi/gen

install:

obj: _xenocara_obj

.include <bsd.lib.mk>
.include <bsd.xorg.mk>

.PATH: ${MESA_SRC}/src/mapi/glapi
