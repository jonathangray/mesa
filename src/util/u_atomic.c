/*
 * Copyright © 2017 Gražvydas Ignotas
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

#if (defined(MISSING_32BIT_ATOMICS) || defined(MISSING_64BIT_ATOMICS)) && \
    defined(HAVE_PTHREAD)

#include <stdint.h>
#include <pthread.h>

#if defined(HAVE_FUNC_ATTRIBUTE_WEAK) && !defined(__CYGWIN__)
#define WEAK __attribute__((weak))
#else
#define WEAK
#endif

static pthread_mutex_t sync_mutex = PTHREAD_MUTEX_INITIALIZER;

#ifdef MISSING_32BIT_ATOMICS

WEAK uint8_t
__sync_add_and_fetch_1(uint8_t *ptr, uint8_t val)
{
   uint8_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr += val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint8_t
__sync_sub_and_fetch_1(uint8_t *ptr, uint8_t val)
{
   uint8_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr -= val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint8_t
__sync_val_compare_and_swap_1(uint8_t *ptr, uint8_t oldval, uint8_t newval)
{
   uint8_t r;

   pthread_mutex_lock(&sync_mutex);
   r = *ptr;
   if (*ptr == oldval)
      *ptr = newval;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint16_t
__sync_add_and_fetch_2(uint16_t *ptr, uint16_t val)
{
   uint16_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr += val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint16_t
__sync_sub_and_fetch_2(uint16_t *ptr, uint16_t val)
{
   uint16_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr -= val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint16_t
__sync_val_compare_and_swap_2(uint16_t *ptr, uint16_t oldval, uint16_t newval)
{
   uint16_t r;

   pthread_mutex_lock(&sync_mutex);
   r = *ptr;
   if (*ptr == oldval)
      *ptr = newval;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint32_t
__sync_add_and_fetch_4(uint32_t *ptr, uint32_t val)
{
   uint32_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr += val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint32_t
__sync_sub_and_fetch_4(uint32_t *ptr, uint32_t val)
{
   uint32_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr -= val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint32_t
__sync_val_compare_and_swap_4(uint32_t *ptr, uint32_t oldval, uint32_t newval)
{
   uint32_t r;

   pthread_mutex_lock(&sync_mutex);
   r = *ptr;
   if (*ptr == oldval)
      *ptr = newval;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}
#endif /* MISSING_32BIT_ATOMICS */

WEAK uint64_t
__sync_add_and_fetch_8(uint64_t *ptr, uint64_t val)
{
   uint64_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr += val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint64_t
__sync_sub_and_fetch_8(uint64_t *ptr, uint64_t val)
{
   uint64_t r;

   pthread_mutex_lock(&sync_mutex);
   *ptr -= val;
   r = *ptr;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

#ifdef USE_GCC_ATOMIC_BUILTINS
WEAK uint64_t
__sync_val_compare_and_swap_8(uint64_t *ptr, uint64_t oldval, uint64_t newval)
{
   uint64_t r;

   pthread_mutex_lock(&sync_mutex);
   r = *ptr;
   if (*ptr == oldval)
      *ptr = newval;
   pthread_mutex_unlock(&sync_mutex);

   return r;
}

WEAK uint64_t
__atomic_fetch_add_8(uint64_t *ptr, uint64_t val, int memorder)
{
   return __sync_add_and_fetch(ptr, val);
}

WEAK uint64_t
__atomic_fetch_sub_8(uint64_t *ptr, uint64_t val, int memorder)
{
   return __sync_sub_and_fetch(ptr, val);
}
#endif /* USE_GCC_ATOMIC_BUILTINS */

#endif
