; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature
; RUN: opt -inline -preserve-alignment-assumptions-during-inlining -S < %s | FileCheck %s
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Test behavior of inserted alignment assumptions with byref. There is
; no implied copy to a higher alignment, so an alignment assume call
; should be inserted.
define void @byref_callee(float* align(128) byref(float) nocapture %a, float* %b) #0 {
; CHECK-LABEL: define {{[^@]+}}@byref_callee
; CHECK-SAME: (float* nocapture byref(float) align 128 [[A:%.*]], float* [[B:%.*]]) #0
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOAD:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[B_IDX:%.*]] = getelementptr inbounds float, float* [[B]], i64 8
; CHECK-NEXT:    [[ADD:%.*]] = fadd float [[LOAD]], 2.000000e+00
; CHECK-NEXT:    store float [[ADD]], float* [[B_IDX]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %load = load float, float* %a, align 4
  %b.idx = getelementptr inbounds float, float* %b, i64 8
  %add = fadd float %load, 2.0
  store float %add, float* %b.idx, align 4
  ret void
}

define void @byref_caller(float* nocapture align 64 %a, float* %b) #0 {
; CHECK-LABEL: define {{[^@]+}}@byref_caller
; CHECK-SAME: (float* nocapture align 64 [[A:%.*]], float* [[B:%.*]]) #0
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[PTRINT:%.*]] = ptrtoint float* [[A]] to i64
; CHECK-NEXT:    [[MASKEDPTR:%.*]] = and i64 [[PTRINT]], 127
; CHECK-NEXT:    [[MASKCOND:%.*]] = icmp eq i64 [[MASKEDPTR]], 0
; CHECK-NEXT:    call void @llvm.assume(i1 [[MASKCOND]])
; CHECK-NEXT:    [[LOAD_I:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[B_IDX_I:%.*]] = getelementptr inbounds float, float* [[B]], i64 8
; CHECK-NEXT:    [[ADD_I:%.*]] = fadd float [[LOAD_I]], 2.000000e+00
; CHECK-NEXT:    store float [[ADD_I]], float* [[B_IDX_I]], align 4
; CHECK-NEXT:    [[CALLER_LOAD:%.*]] = load float, float* [[B]], align 4
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, float* [[A]], i64 7
; CHECK-NEXT:    store float [[CALLER_LOAD]], float* [[ARRAYIDX]], align 4
; CHECK-NEXT:    ret void
;
entry:
  call void @byref_callee(float* align(128) byref(float) %a, float* %b)
  %caller.load = load float, float* %b, align 4
  %arrayidx = getelementptr inbounds float, float* %a, i64 7
  store float %caller.load, float* %arrayidx, align 4
  ret void
}

attributes #0 = { nounwind uwtable }
