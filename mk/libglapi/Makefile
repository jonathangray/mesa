#	$OpenBSD: Makefile,v 1.8 2025/06/06 09:04:09 jsg Exp $

LIB=	glapi

SRCS=	core.c

.include "../Makefile.inc"

CFLAGS+=	${C_VIS_ARGS}
CPPFLAGS+=	-I${MESA_SRC}/src/mapi/shared-glapi \
		-I${MESA_SRC}/src/mapi \
		-I${MESA_SRC}/generated/src/mapi/shared-glapi \
		-DMAPI_MODE_SHARED_GLAPI

LDADD+=	-Wl,--as-needed -Wl,--allow-shlib-undefined -Wl,--start-group \
	${.CURDIR}/../libmesa_util/${__objdir}/libmesa_util.a \
	${.CURDIR}/../libmesa_util_c11/${__objdir}/libmesa_util_c11.a \
	-Wl,--gc-sections -lpthread -lm -Wl,--end-group

NOPROFILE=

obj: _xenocara_obj

.include <bsd.lib.mk>
.include <bsd.xorg.mk>

.PATH: ${MESA_SRC}/src/mapi/shared-glapi
