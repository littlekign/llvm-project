; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

define <4 x i16> @fold_urem_vec_1(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 95, i16 124, i16 98, i16 1003>
  ret <4 x i16> %1
}

define <4 x i16> @fold_urem_vec_2(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  ret <4 x i16> %1
}


; Don't fold if we can combine urem with udiv.
define <4 x i16> @combine_urem_udiv(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %2 = udiv <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %3 = add <4 x i16> %1, %2
  ret <4 x i16> %3
}


; Don't fold for divisors that are a power of two.
define <4 x i16> @dont_fold_urem_power_of_two(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 64, i16 32, i16 8, i16 95>
  ret <4 x i16> %1
}

; Don't fold if the divisor is one.
define <4 x i16> @dont_fold_srem_one(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 1, i16 654, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold if the divisor is 2^16.
define <4 x i16> @dont_fold_urem_i16_smax(<4 x i16> %x) {
  %1 = urem <4 x i16> %x, <i16 1, i16 65536, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold i64 urem.
define <4 x i64> @dont_fold_urem_i64(<4 x i64> %x) {
  %1 = urem <4 x i64> %x, <i64 1, i64 654, i64 23, i64 5423>
  ret <4 x i64> %1
}