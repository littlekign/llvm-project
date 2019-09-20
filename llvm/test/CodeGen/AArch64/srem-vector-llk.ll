; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

define <4 x i16> @fold_srem_vec(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 95, i16 -124, i16 98, i16 -1003>
  ret <4 x i16> %1
}

define <4 x i16> @fold_srem_vec(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  ret <4 x i16> %1
}


; Don't fold if we can combine srem with sdiv.
define <4 x i16> @combine_srem_sdiv(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %2 = sdiv <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %3 = add <4 x i16> %1, %2
  ret <4 x i16> %3
}

; Don't fold for divisors that are a power of two.
define <4 x i16> @dont_fold_srem_power_of_two(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 64, i16 32, i16 8, i16 95>
  ret <4 x i16> %1
}

; Don't fold if the divisor is one.
define <4 x i16> @dont_fold_srem_power_of_two(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 1, i16 654, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold if the divisor is 2^15.
define <4 x i16> @dont_fold_srem_i16_smax(<4 x i16> %x) {
  %1 = srem <4 x i16> %x, <i16 1, i16 32768, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold i64 srem.
define <4 x i64> @dont_fold_srem_i64(<4 x i64> %x) {
  %1 = srem <4 x i64> %x, <i64 1, i64 654, i64 23, i64 5423>
  ret <4 x i64> %1
}