; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i5 @XorZextXor(i3 %a) {
; CHECK-LABEL: @XorZextXor(
; CHECK-NEXT:    [[CAST:%.*]] = zext i3 [[A:%.*]] to i5
; CHECK-NEXT:    [[OP2:%.*]] = xor i5 [[CAST]], 15
; CHECK-NEXT:    ret i5 [[OP2]]
;
  %op1 = xor i3 %a, 3
  %cast = zext i3 %op1 to i5
  %op2 = xor i5 %cast, 12
  ret i5 %op2
}

define <2 x i32> @XorZextXorVec(<2 x i1> %a) {
; CHECK-LABEL: @XorZextXorVec(
; CHECK-NEXT:    [[CAST:%.*]] = zext <2 x i1> [[A:%.*]] to <2 x i32>
; CHECK-NEXT:    [[OP2:%.*]] = xor <2 x i32> [[CAST]], <i32 2, i32 1>
; CHECK-NEXT:    ret <2 x i32> [[OP2]]
;
  %op1 = xor <2 x i1> %a, <i1 true, i1 false>
  %cast = zext <2 x i1> %op1 to <2 x i32>
  %op2 = xor <2 x i32> %cast, <i32 3, i32 1>
  ret <2 x i32> %op2
}

define i5 @OrZextOr(i3 %a) {
; CHECK-LABEL: @OrZextOr(
; CHECK-NEXT:    [[CAST:%.*]] = zext i3 [[A:%.*]] to i5
; CHECK-NEXT:    [[OP2:%.*]] = or i5 [[CAST]], 11
; CHECK-NEXT:    ret i5 [[OP2]]
;
  %op1 = or i3 %a, 3
  %cast = zext i3 %op1 to i5
  %op2 = or i5 %cast, 8
  ret i5 %op2
}

define <2 x i32> @OrZextOrVec(<2 x i2> %a) {
; CHECK-LABEL: @OrZextOrVec(
; CHECK-NEXT:    [[CAST:%.*]] = zext <2 x i2> [[A:%.*]] to <2 x i32>
; CHECK-NEXT:    [[OP2:%.*]] = or <2 x i32> [[CAST]], <i32 3, i32 5>
; CHECK-NEXT:    ret <2 x i32> [[OP2]]
;
  %op1 = or <2 x i2> %a, <i2 2, i2 0>
  %cast = zext <2 x i2> %op1 to <2 x i32>
  %op2 = or <2 x i32> %cast, <i32 1, i32 5>
  ret <2 x i32> %op2
}

; Unlike the rest, this case is handled by SimplifyDemandedBits / ShrinkDemandedConstant.

define i5 @AndZextAnd(i3 %a) {
; CHECK-LABEL: @AndZextAnd(
; CHECK-NEXT:    [[TMP1:%.*]] = and i3 [[A:%.*]], 2
; CHECK-NEXT:    [[OP2:%.*]] = zext nneg i3 [[TMP1]] to i5
; CHECK-NEXT:    ret i5 [[OP2]]
;
  %op1 = and i3 %a, 3
  %cast = zext i3 %op1 to i5
  %op2 = and i5 %cast, 14
  ret i5 %op2
}

define <2 x i32> @AndZextAndVec(<2 x i8> %a) {
; CHECK-LABEL: @AndZextAndVec(
; CHECK-NEXT:    [[TMP1:%.*]] = and <2 x i8> [[A:%.*]], <i8 5, i8 0>
; CHECK-NEXT:    [[OP2:%.*]] = zext nneg <2 x i8> [[TMP1]] to <2 x i32>
; CHECK-NEXT:    ret <2 x i32> [[OP2]]
;
  %op1 = and <2 x i8> %a, <i8 7, i8 0>
  %cast = zext <2 x i8> %op1 to <2 x i32>
  %op2 = and <2 x i32> %cast, <i32 261, i32 1>
  ret <2 x i32> %op2
}

