#	$OpenBSD: Makefile,v 1.1 2020/08/26 06:02:39 jsg Exp $

GFX=	110
LIB=	isl_gfx${GFX}

NOPROFILE=

SRCS=	isl_emit_depth_stencil.c \
	isl_surface_state.c

.include "../Makefile.inc"

CFLAGS+=	${C_VIS_ARGS} ${NO_OVERRIDE_INIT_ARGS}
CPPFLAGS+=	-I${MESA_SRC}/src/intel \
		-I${MESA_SRC}/src/gallium/include \
		-I${MESA_SRC}/generated/src/intel \
		-DGFX_VERx10=${GFX}

install:

obj: _xenocara_obj

.include <bsd.lib.mk>
.include <bsd.xorg.mk>

.PATH: ${MESA_SRC}/src/intel/isl
