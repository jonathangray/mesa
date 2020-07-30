#	$OpenBSD: Makefile,v 1.7 2022/09/02 05:46:40 jsg Exp $

LIB=	mesa_util_c11

NOPROFILE=

SRCS=	time.c \
	threads_posix.c

.include "../Makefile.inc"

CFLAGS+=	${C_VIS_ARGS}
CPPFLAGS+=	-I${MESA_SRC}/src/util

install:

obj: _xenocara_obj

.include <bsd.lib.mk>
.include <bsd.xorg.mk>

.PATH: ${MESA_SRC}/src/c11/impl
