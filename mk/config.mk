.include <bsd.xconf.mk>
.include <bsd.own.mk>

CFLAGS+= \
	-std=c99 \
	-Wall \
	-Winvalid-pch \
	-Werror=empty-body \
	-Werror=implicit-function-declaration \
	-Werror=incompatible-pointer-types \
	-Werror=int-conversion \
	-Werror=missing-prototypes \
	-Werror=return-type \
	-Wno-missing-field-initializers \
	-Wno-typedef-redefinition \
	-fno-math-errno \
	-fno-trapping-math \
	-fno-common \
	-Werror=format \
	-Wformat-security \
	-Qunused-arguments

CXXFLAGS+= \
	-std=c++14 \
	-Wall \
	-Winvalid-pch \
	-Werror=empty-body \
	-Werror=format \
	-Werror=return-type \
	-Wno-missing-field-initializers \
	-Wno-non-virtual-dtor \
	-fno-math-errno \
	-fno-trapping-math \
	-Wformat-security \
	-Qunused-arguments

.if ${COMPILER_VERSION:L} != "clang"
CC=	clang
CXX=	clang++
.endif

NO_OVERRIDE_INIT_ARGS= -Wno-override-init -Wno-initializer-overrides
C_VIS_ARGS= -fvisibility=hidden
CXX_VIS_ARGS= -fvisibility=hidden

C_SSE2_ARGS= -msse2 -mstackrealign

.if ${MACHINE_ARCH} == "i386"
SSE41_ARGS= -msse4.1 -mstackrealign
.elif ${MACHINE_ARCH} == "amd64"
SSE41_ARGS= -msse4.1
.endif

CPPFLAGS+= \
	-DENABLE_SHADER_CACHE \
	-DENABLE_ST_OMX_BELLAGIO=0 \
	-DENABLE_ST_OMX_TIZONIA=0 \
	-DETIME=ETIMEDOUT \
	-DGLX_DIRECT_RENDERING \
	-DGLX_INDIRECT_RENDERING \
	-DGLX_USE_DRM \
	-DHAVE_ARC4RANDOM_BUF \
	-DHAVE_DIRENT_D_TYPE \
	-DHAVE_DLADDR \
	-DHAVE_DLFCN_H \
	-DHAVE_DL_ITERATE_PHDR \
	-DHAVE_DRM_PLATFORM \
	-DHAVE_ENDIAN_H \
	-DHAVE_FLOCK \
	-DHAVE_FUNC_ATTRIBUTE_ALIAS \
	-DHAVE_FUNC_ATTRIBUTE_CONST \
	-DHAVE_FUNC_ATTRIBUTE_FLATTEN \
	-DHAVE_FUNC_ATTRIBUTE_FORMAT \
	-DHAVE_FUNC_ATTRIBUTE_MALLOC \
	-DHAVE_FUNC_ATTRIBUTE_NORETURN \
	-DHAVE_FUNC_ATTRIBUTE_PACKED \
	-DHAVE_FUNC_ATTRIBUTE_PURE \
	-DHAVE_FUNC_ATTRIBUTE_RETURNS_NONNULL \
	-DHAVE_FUNC_ATTRIBUTE_UNUSED \
	-DHAVE_FUNC_ATTRIBUTE_VISIBILITY \
	-DHAVE_FUNC_ATTRIBUTE_WARN_UNUSED_RESULT \
	-DHAVE_FUNC_ATTRIBUTE_WEAK \
	-DHAVE_LIBDRM \
	-DHAVE_MKOSTEMP \
	-DHAVE_POSIX_MEMALIGN \
	-DHAVE_PTHREAD \
	-DHAVE_PTHREAD_NP_H \
	-DHAVE_STRTOF \
	-DHAVE_STRTOK_R \
	-DHAVE_SYS_SHM_H \
	-DHAVE_SYS_SYSCTL_H \
	-DHAVE_TIMESPEC_GET \
	-DHAVE_X11_PLATFORM \
	-DHAVE_ZLIB \
	-DHAVE___BUILTIN_BSWAP32 \
	-DHAVE___BUILTIN_BSWAP64 \
	-DHAVE___BUILTIN_CLZ \
	-DHAVE___BUILTIN_CLZLL \
	-DHAVE___BUILTIN_CTZ \
	-DHAVE___BUILTIN_EXPECT \
	-DHAVE___BUILTIN_FFS \
	-DHAVE___BUILTIN_FFSLL \
	-DHAVE___BUILTIN_POPCOUNT \
	-DHAVE___BUILTIN_POPCOUNTLL \
	-DHAVE___BUILTIN_UNREACHABLE \
	-DNDEBUG \
	-DUSE_GCC_ATOMIC_BUILTINS \
	-DPACKAGE_BUGREPORT=\"bugs@openbsd.org\" \
	-D_FILE_OFFSET_BITS=64 \
	-D_ISOC11_SOURCE \
	-D__STDC_CONSTANT_MACROS \
	-D__STDC_FORMAT_MACROS \
	-D__STDC_LIMIT_MACROS

.if ${XENOCARA_BUILD_DRI3:L} == "yes"
CPPFLAGS+= \
	-DHAVE_DRI3 \
	-DHAVE_DRI3_MODIFIERS
.endif

.if ${LINKER_VERSION} == "lld"
CPPFLAGS+= \
	-DHAVE_LD_BUILD_ID
WITH_LD_DYNAMIC_LIST=yes
BUILD_ID_SHA1= -Wl,--build-id=sha1
.else
WITH_LD_DYNAMIC_LIST=no
BUILD_ID_SHA1=
.endif

# __uint128_t only on LP64 archs
.if ${MACHINE_ARCH} != "arm" && ${MACHINE_ARCH} != "i386" && \
    ${MACHINE_ARCH} != "powerpc"
CPPFLAGS+=	-DHAVE_UINT128
.endif

.if ${MACHINE_ARCH} == "powerpc"
CPPFLAGS+=	-DMISSING_64BIT_ATOMICS
.endif

.if ${MACHINE_ARCH} == "i386"
CPPFLAGS+=	-DUSE_X86_ASM -DUSE_MMX_ASM -DUSE_3DNOW_ASM -DUSE_SSE_ASM \
		-DUSE_SSE41
.elif ${MACHINE_ARCH} == "amd64"
CPPFLAGS+=	-DUSE_X86_64_ASM -DUSE_SSE41
.elif ${MACHINE_ARCH} == "arm"
CPPFLAGS+=	-DUSE_ARM_ASM
.elif ${MACHINE_ARCH} == "aarch64"
CPPFLAGS+=	-DUSE_AARCH64_ASM
.elif ${MACHINE_ARCH} == "sparc64"
CPPFLAGS+=	-DUSE_SPARC_ASM
.endif

WITH_DRI_R100=no
WITH_DRI_R200=no
WITH_DRI_I915=no
WITH_DRI_I965=no
WITH_GALLIUM_R300=no
WITH_GALLIUM_R600=no
WITH_GALLIUM_RADEONSI=no
WITH_GALLIUM_IRIS=no
WITH_AMD_VK=no
WITH_INTEL_VK=no
WITH_SSE41=no

WITH_DRI=yes
WITH_GALLIUM_DRISW_KMS=yes
WITH_GALLIUM_SOFTPIPE=yes

WITH_LLVM=yes
LLVM_V!=	llvm-config --version
CPPFLAGS+=	-DLLVM_AVAILABLE \
		-DMESA_LLVM_VERSION_STRING=\"${LLVM_V}\"

.if ${MACHINE_ARCH} == "amd64" || ${MACHINE_ARCH} == "i386"
WITH_SSE41=yes
.endif

.if ${MACHINE} == amd64 || ${MACHINE} == arm64 || ${MACHINE} == i386 || \
    ${MACHINE} == loongson || ${MACHINE} == macppc || \
    ${MACHINE} == powerpc64 || ${MACHINE} == sparc64
WITH_DRI_R100=yes
WITH_DRI_R200=yes
WITH_GALLIUM_R300=yes
WITH_GALLIUM_R600=yes
.endif

.if ${MACHINE} == "amd64" || ${MACHINE} == arm64 || ${MACHINE} == "i386" || \
    ${MACHINE} == "powerpc64"
WITH_GALLIUM_RADEONSI=yes
WITH_AMD_VK=yes
.endif

.if ${MACHINE} == "amd64" || ${MACHINE} == "i386"
WITH_DRI_I915=yes
WITH_DRI_I965=yes
WITH_GALLIUM_IRIS=yes
WITH_INTEL_VK=yes
.endif
