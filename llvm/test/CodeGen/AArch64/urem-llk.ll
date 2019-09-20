; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s

define i32 @fold_urem_positve_odd(i32 %x) {
  %1 = urem i32 %x, 95
  ret i32 %1
}


define i32 @fold_urem_positve_even(i32 %x) {
  %1 = urem i32 %x, 1060
  ret i32 %1
}


; Don't fold if we can combine urem with udiv.
define i32 @combine_urem_udiv(i32 %x) {
  %1 = urem i32 %x, 95
  %2 = udiv i32 %x, 95
  %3 = add i32 %1, %2
  ret i32 %3
}

; Don't fold for divisors that are a power of two.
define i32 @dont_fold_urem_power_of_two(i32 %x) {
  %1 = urem i32 %x, 64
  ret i32 %1
}

; Don't fold if the divisor is one.
define i32 @dont_fold_urem_one(i32 %x) {
  %1 = urem i32 %x, 1
  ret i32 %1
}

; Don't fold if the divisor is 2^32.
define i32 @dont_fold_urem_i32_umax(i32 %x) {
  %1 = urem i32 %x, 4294967296
  ret i32 %1
}

; Don't fold i64 urem
define i64 @dont_fold_urem_i64(i64 %x) {
  %1 = urem i64 %x, 98
  ret i64 %1
}