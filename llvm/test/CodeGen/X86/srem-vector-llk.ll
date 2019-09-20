; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+sse4.1 | FileCheck %s --check-prefix=CHECK --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx  | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX2

define <4 x i16> @fold_srem_vec_1(<4 x i16> %x) {
; SSE-LABEL: fold_srem_vec_1:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm1 = [95,124,98,1003]
; SSE-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; SSE-NEXT:    pmovsxwd %xmm0, %xmm3
; SSE-NEXT:    pmulld {{.*}}(%rip), %xmm3
; SSE-NEXT:    pshufd {{.*#+}} xmm4 = xmm3[1,1,3,3]
; SSE-NEXT:    pmuldq %xmm2, %xmm4
; SSE-NEXT:    pmuldq %xmm1, %xmm3
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm3[1,1,3,3]
; SSE-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1],xmm4[2,3],xmm1[4,5],xmm4[6,7]
; SSE-NEXT:    pshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; SSE-NEXT:    psraw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE-NEXT:    psubw %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: fold_srem_vec_1:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm1 = [95,124,98,1003]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpmovsxwd %xmm0, %xmm3
; AVX1-NEXT:    vpmulld {{.*}}(%rip), %xmm3, %xmm3
; AVX1-NEXT:    vpshufd {{.*#+}} xmm4 = xmm3[1,1,3,3]
; AVX1-NEXT:    vpmuldq %xmm2, %xmm4, %xmm2
; AVX1-NEXT:    vpmuldq %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX1-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: fold_srem_vec_1:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = [95,124,98,1003]
; AVX2-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpmovsxwd %xmm0, %xmm3
; AVX2-NEXT:    vpmulld {{.*}}(%rip), %xmm3, %xmm3
; AVX2-NEXT:    vpshufd {{.*#+}} xmm4 = xmm3[1,1,3,3]
; AVX2-NEXT:    vpmuldq %xmm2, %xmm4, %xmm2
; AVX2-NEXT:    vpmuldq %xmm1, %xmm3, %xmm1
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm1 = xmm1[0],xmm2[1],xmm1[2],xmm2[3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX2-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpsubw %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 95, i16 -124, i16 98, i16 -1003>
  ret <4 x i16> %1
}

define <4 x i16> @fold_srem_vec_2(<4 x i16> %x) {
; SSE-LABEL: fold_srem_vec_2:
; SSE:       # %bb.0:
; SSE-NEXT:    pmovsxwd %xmm0, %xmm1
; SSE-NEXT:    pmulld {{.*}}(%rip), %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; SSE-NEXT:    movdqa {{.*#+}} xmm3 = [95,95,95,95]
; SSE-NEXT:    pmuldq %xmm3, %xmm2
; SSE-NEXT:    pmuldq %xmm3, %xmm1
; SSE-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; SSE-NEXT:    pblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; SSE-NEXT:    pshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; SSE-NEXT:    psraw $15, %xmm0
; SSE-NEXT:    pand {{.*}}(%rip), %xmm0
; SSE-NEXT:    psubw %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX1-LABEL: fold_srem_vec_2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpmovsxwd %xmm0, %xmm1
; AVX1-NEXT:    vpmulld {{.*}}(%rip), %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm3 = [95,95,95,95]
; AVX1-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX1-NEXT:    vpmuldq %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX1-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0,1],xmm2[2,3],xmm1[4,5],xmm2[6,7]
; AVX1-NEXT:    vpshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX1-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX1-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpsubw %xmm0, %xmm1, %xmm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: fold_srem_vec_2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vpmovsxwd %xmm0, %xmm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [45210183,45210183,45210183,45210183]
; AVX2-NEXT:    vpmulld %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [95,95,95,95]
; AVX2-NEXT:    vpmuldq %xmm3, %xmm2, %xmm2
; AVX2-NEXT:    vpmuldq %xmm3, %xmm1, %xmm1
; AVX2-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[1,1,3,3]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm1 = xmm1[0],xmm2[1],xmm1[2],xmm2[3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm1 = xmm1[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX2-NEXT:    vpsraw $15, %xmm0, %xmm0
; AVX2-NEXT:    vpand {{.*}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpsubw %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  ret <4 x i16> %1
}


; Don't fold if we can combine srem with sdiv.
define <4 x i16> @combine_srem_sdiv(<4 x i16> %x) {
; SSE-LABEL: combine_srem_sdiv:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa {{.*#+}} xmm1 = [44151,44151,44151,44151,44151,44151,44151,44151]
; SSE-NEXT:    pmulhw %xmm0, %xmm1
; SSE-NEXT:    paddw %xmm0, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    psrlw $15, %xmm2
; SSE-NEXT:    psraw $6, %xmm1
; SSE-NEXT:    paddw %xmm2, %xmm1
; SSE-NEXT:    movdqa {{.*#+}} xmm2 = [95,95,95,95,95,95,95,95]
; SSE-NEXT:    pmullw %xmm1, %xmm2
; SSE-NEXT:    psubw %xmm2, %xmm0
; SSE-NEXT:    paddw %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: combine_srem_sdiv:
; AVX:       # %bb.0:
; AVX-NEXT:    vpmulhw {{.*}}(%rip), %xmm0, %xmm1
; AVX-NEXT:    vpaddw %xmm0, %xmm1, %xmm1
; AVX-NEXT:    vpsrlw $15, %xmm1, %xmm2
; AVX-NEXT:    vpsraw $6, %xmm1, %xmm1
; AVX-NEXT:    vpaddw %xmm2, %xmm1, %xmm1
; AVX-NEXT:    vpmullw {{.*}}(%rip), %xmm1, %xmm2
; AVX-NEXT:    vpsubw %xmm2, %xmm0, %xmm0
; AVX-NEXT:    vpaddw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %2 = sdiv <4 x i16> %x, <i16 95, i16 95, i16 95, i16 95>
  %3 = add <4 x i16> %1, %2
  ret <4 x i16> %3
}

; Don't fold for divisors that are a power of two.
define <4 x i16> @dont_fold_srem_power_of_two(<4 x i16> %x) {
; SSE-LABEL: dont_fold_srem_power_of_two:
; SSE:       # %bb.0:
; SSE-NEXT:    pextrw $1, %xmm0, %eax
; SSE-NEXT:    leal 31(%rax), %ecx
; SSE-NEXT:    testw %ax, %ax
; SSE-NEXT:    cmovnsl %eax, %ecx
; SSE-NEXT:    andl $-32, %ecx
; SSE-NEXT:    subl %ecx, %eax
; SSE-NEXT:    movd %xmm0, %ecx
; SSE-NEXT:    leal 63(%rcx), %edx
; SSE-NEXT:    testw %cx, %cx
; SSE-NEXT:    cmovnsl %ecx, %edx
; SSE-NEXT:    andl $-64, %edx
; SSE-NEXT:    subl %edx, %ecx
; SSE-NEXT:    movd %ecx, %xmm1
; SSE-NEXT:    pinsrw $1, %eax, %xmm1
; SSE-NEXT:    pextrw $2, %xmm0, %eax
; SSE-NEXT:    leal 7(%rax), %ecx
; SSE-NEXT:    testw %ax, %ax
; SSE-NEXT:    cmovnsl %eax, %ecx
; SSE-NEXT:    andl $-8, %ecx
; SSE-NEXT:    subl %ecx, %eax
; SSE-NEXT:    pinsrw $2, %eax, %xmm1
; SSE-NEXT:    pextrw $3, %xmm0, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $45210183, %eax, %ecx # imm = 0x2B1DA47
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $94, %eax
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    imulq $95, %rcx, %rcx
; SSE-NEXT:    shrq $32, %rcx
; SSE-NEXT:    subl %eax, %ecx
; SSE-NEXT:    pinsrw $3, %ecx, %xmm1
; SSE-NEXT:    movdqa %xmm1, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: dont_fold_srem_power_of_two:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $1, %xmm0, %eax
; AVX-NEXT:    leal 31(%rax), %ecx
; AVX-NEXT:    testw %ax, %ax
; AVX-NEXT:    cmovnsl %eax, %ecx
; AVX-NEXT:    andl $-32, %ecx
; AVX-NEXT:    subl %ecx, %eax
; AVX-NEXT:    vmovd %xmm0, %ecx
; AVX-NEXT:    leal 63(%rcx), %edx
; AVX-NEXT:    testw %cx, %cx
; AVX-NEXT:    cmovnsl %ecx, %edx
; AVX-NEXT:    andl $-64, %edx
; AVX-NEXT:    subl %edx, %ecx
; AVX-NEXT:    vmovd %ecx, %xmm1
; AVX-NEXT:    vpinsrw $1, %eax, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $2, %xmm0, %eax
; AVX-NEXT:    leal 7(%rax), %ecx
; AVX-NEXT:    testw %ax, %ax
; AVX-NEXT:    cmovnsl %eax, %ecx
; AVX-NEXT:    andl $-8, %ecx
; AVX-NEXT:    subl %ecx, %eax
; AVX-NEXT:    vpinsrw $2, %eax, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $3, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $45210183, %eax, %ecx # imm = 0x2B1DA47
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $94, %eax
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    imulq $95, %rcx, %rcx
; AVX-NEXT:    shrq $32, %rcx
; AVX-NEXT:    subl %eax, %ecx
; AVX-NEXT:    vpinsrw $3, %ecx, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 64, i16 32, i16 8, i16 95>
  ret <4 x i16> %1
}

; Don't fold if the divisor is one.
define <4 x i16> @dont_fold_srem_one(<4 x i16> %x) {
; SSE-LABEL: dont_fold_srem_one:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    pextrw $1, %xmm0, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $6567229, %eax, %ecx # imm = 0x64353D
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $653, %eax # imm = 0x28D
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    imulq $654, %rcx, %rcx # imm = 0x28E
; SSE-NEXT:    shrq $32, %rcx
; SSE-NEXT:    subl %eax, %ecx
; SSE-NEXT:    pxor %xmm0, %xmm0
; SSE-NEXT:    pinsrw $1, %ecx, %xmm0
; SSE-NEXT:    pextrw $2, %xmm1, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $186737709, %eax, %ecx # imm = 0xB21642D
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    leaq (%rcx,%rcx,2), %rdx
; SSE-NEXT:    shlq $3, %rdx
; SSE-NEXT:    subq %rcx, %rdx
; SSE-NEXT:    shrq $32, %rdx
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $22, %eax
; SSE-NEXT:    subl %eax, %edx
; SSE-NEXT:    pinsrw $2, %edx, %xmm0
; SSE-NEXT:    pextrw $3, %xmm1, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $791992, %eax, %ecx # imm = 0xC15B8
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $5422, %eax # imm = 0x152E
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    imulq $5423, %rcx, %rcx # imm = 0x152F
; SSE-NEXT:    shrq $32, %rcx
; SSE-NEXT:    subl %eax, %ecx
; SSE-NEXT:    pinsrw $3, %ecx, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: dont_fold_srem_one:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $1, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $6567229, %eax, %ecx # imm = 0x64353D
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $653, %eax # imm = 0x28D
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    imulq $654, %rcx, %rcx # imm = 0x28E
; AVX-NEXT:    shrq $32, %rcx
; AVX-NEXT:    subl %eax, %ecx
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpinsrw $1, %ecx, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $2, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $186737709, %eax, %ecx # imm = 0xB21642D
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    leaq (%rcx,%rcx,2), %rdx
; AVX-NEXT:    shlq $3, %rdx
; AVX-NEXT:    subq %rcx, %rdx
; AVX-NEXT:    shrq $32, %rdx
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $22, %eax
; AVX-NEXT:    subl %eax, %edx
; AVX-NEXT:    vpinsrw $2, %edx, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $3, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $791992, %eax, %ecx # imm = 0xC15B8
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $5422, %eax # imm = 0x152E
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    imulq $5423, %rcx, %rcx # imm = 0x152F
; AVX-NEXT:    shrq $32, %rcx
; AVX-NEXT:    subl %eax, %ecx
; AVX-NEXT:    vpinsrw $3, %ecx, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 1, i16 654, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold if the divisor is 2^15.
define <4 x i16> @dont_fold_urem_i16_smax(<4 x i16> %x) {
; SSE-LABEL: dont_fold_urem_i16_smax:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm0, %xmm1
; SSE-NEXT:    pextrw $1, %xmm0, %eax
; SSE-NEXT:    leal 32767(%rax), %ecx
; SSE-NEXT:    testw %ax, %ax
; SSE-NEXT:    cmovnsl %eax, %ecx
; SSE-NEXT:    andl $-32768, %ecx # imm = 0x8000
; SSE-NEXT:    addl %eax, %ecx
; SSE-NEXT:    pxor %xmm0, %xmm0
; SSE-NEXT:    pinsrw $1, %ecx, %xmm0
; SSE-NEXT:    pextrw $2, %xmm1, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $186737709, %eax, %ecx # imm = 0xB21642D
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    leaq (%rcx,%rcx,2), %rdx
; SSE-NEXT:    shlq $3, %rdx
; SSE-NEXT:    subq %rcx, %rdx
; SSE-NEXT:    shrq $32, %rdx
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $22, %eax
; SSE-NEXT:    subl %eax, %edx
; SSE-NEXT:    pinsrw $2, %edx, %xmm0
; SSE-NEXT:    pextrw $3, %xmm1, %eax
; SSE-NEXT:    cwtl
; SSE-NEXT:    imull $791992, %eax, %ecx # imm = 0xC15B8
; SSE-NEXT:    shrl $15, %eax
; SSE-NEXT:    andl $5422, %eax # imm = 0x152E
; SSE-NEXT:    movslq %ecx, %rcx
; SSE-NEXT:    imulq $5423, %rcx, %rcx # imm = 0x152F
; SSE-NEXT:    shrq $32, %rcx
; SSE-NEXT:    subl %eax, %ecx
; SSE-NEXT:    pinsrw $3, %ecx, %xmm0
; SSE-NEXT:    retq
;
; AVX-LABEL: dont_fold_urem_i16_smax:
; AVX:       # %bb.0:
; AVX-NEXT:    vpextrw $1, %xmm0, %eax
; AVX-NEXT:    leal 32767(%rax), %ecx
; AVX-NEXT:    testw %ax, %ax
; AVX-NEXT:    cmovnsl %eax, %ecx
; AVX-NEXT:    andl $-32768, %ecx # imm = 0x8000
; AVX-NEXT:    addl %eax, %ecx
; AVX-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX-NEXT:    vpinsrw $1, %ecx, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $2, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $186737709, %eax, %ecx # imm = 0xB21642D
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    leaq (%rcx,%rcx,2), %rdx
; AVX-NEXT:    shlq $3, %rdx
; AVX-NEXT:    subq %rcx, %rdx
; AVX-NEXT:    shrq $32, %rdx
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $22, %eax
; AVX-NEXT:    subl %eax, %edx
; AVX-NEXT:    vpinsrw $2, %edx, %xmm1, %xmm1
; AVX-NEXT:    vpextrw $3, %xmm0, %eax
; AVX-NEXT:    cwtl
; AVX-NEXT:    imull $791992, %eax, %ecx # imm = 0xC15B8
; AVX-NEXT:    shrl $15, %eax
; AVX-NEXT:    andl $5422, %eax # imm = 0x152E
; AVX-NEXT:    movslq %ecx, %rcx
; AVX-NEXT:    imulq $5423, %rcx, %rcx # imm = 0x152F
; AVX-NEXT:    shrq $32, %rcx
; AVX-NEXT:    subl %eax, %ecx
; AVX-NEXT:    vpinsrw $3, %ecx, %xmm1, %xmm0
; AVX-NEXT:    retq
  %1 = srem <4 x i16> %x, <i16 1, i16 32768, i16 23, i16 5423>
  ret <4 x i16> %1
}

; Don't fold i64 srem.
define <4 x i64> @dont_fold_srem_i64(<4 x i64> %x) {
; SSE-LABEL: dont_fold_srem_i64:
; SSE:       # %bb.0:
; SSE-NEXT:    movdqa %xmm1, %xmm2
; SSE-NEXT:    movq %xmm1, %rcx
; SSE-NEXT:    movabsq $-5614226457215950491, %rdx # imm = 0xB21642C8590B2165
; SSE-NEXT:    movq %rcx, %rax
; SSE-NEXT:    imulq %rdx
; SSE-NEXT:    addq %rcx, %rdx
; SSE-NEXT:    movq %rdx, %rax
; SSE-NEXT:    shrq $63, %rax
; SSE-NEXT:    sarq $4, %rdx
; SSE-NEXT:    addq %rax, %rdx
; SSE-NEXT:    leaq (%rdx,%rdx,2), %rax
; SSE-NEXT:    shlq $3, %rax
; SSE-NEXT:    subq %rax, %rdx
; SSE-NEXT:    addq %rcx, %rdx
; SSE-NEXT:    movq %rdx, %xmm1
; SSE-NEXT:    pextrq $1, %xmm2, %rcx
; SSE-NEXT:    movabsq $6966426675817289639, %rdx # imm = 0x60ADB826E5E517A7
; SSE-NEXT:    movq %rcx, %rax
; SSE-NEXT:    imulq %rdx
; SSE-NEXT:    movq %rdx, %rax
; SSE-NEXT:    shrq $63, %rax
; SSE-NEXT:    sarq $11, %rdx
; SSE-NEXT:    addq %rax, %rdx
; SSE-NEXT:    imulq $5423, %rdx, %rax # imm = 0x152F
; SSE-NEXT:    subq %rax, %rcx
; SSE-NEXT:    movq %rcx, %xmm2
; SSE-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm2[0]
; SSE-NEXT:    pextrq $1, %xmm0, %rcx
; SSE-NEXT:    movabsq $7220743857598845893, %rdx # imm = 0x64353C48064353C5
; SSE-NEXT:    movq %rcx, %rax
; SSE-NEXT:    imulq %rdx
; SSE-NEXT:    movq %rdx, %rax
; SSE-NEXT:    shrq $63, %rax
; SSE-NEXT:    sarq $8, %rdx
; SSE-NEXT:    addq %rax, %rdx
; SSE-NEXT:    imulq $654, %rdx, %rax # imm = 0x28E
; SSE-NEXT:    subq %rax, %rcx
; SSE-NEXT:    movq %rcx, %xmm0
; SSE-NEXT:    pslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; SSE-NEXT:    retq
;
; AVX1-LABEL: dont_fold_srem_i64:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovq %xmm1, %rcx
; AVX1-NEXT:    movabsq $-5614226457215950491, %rdx # imm = 0xB21642C8590B2165
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq $4, %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    leaq (%rdx,%rdx,2), %rax
; AVX1-NEXT:    shlq $3, %rax
; AVX1-NEXT:    subq %rax, %rdx
; AVX1-NEXT:    addq %rcx, %rdx
; AVX1-NEXT:    vmovq %rdx, %xmm2
; AVX1-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX1-NEXT:    movabsq $6966426675817289639, %rdx # imm = 0x60ADB826E5E517A7
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rdx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq $11, %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    imulq $5423, %rdx, %rax # imm = 0x152F
; AVX1-NEXT:    subq %rax, %rcx
; AVX1-NEXT:    vmovq %rcx, %xmm1
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX1-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX1-NEXT:    movabsq $7220743857598845893, %rdx # imm = 0x64353C48064353C5
; AVX1-NEXT:    movq %rcx, %rax
; AVX1-NEXT:    imulq %rdx
; AVX1-NEXT:    movq %rdx, %rax
; AVX1-NEXT:    shrq $63, %rax
; AVX1-NEXT:    sarq $8, %rdx
; AVX1-NEXT:    addq %rax, %rdx
; AVX1-NEXT:    imulq $654, %rdx, %rax # imm = 0x28E
; AVX1-NEXT:    subq %rax, %rcx
; AVX1-NEXT:    vmovq %rcx, %xmm0
; AVX1-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: dont_fold_srem_i64:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vmovq %xmm1, %rcx
; AVX2-NEXT:    movabsq $-5614226457215950491, %rdx # imm = 0xB21642C8590B2165
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq $4, %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    leaq (%rdx,%rdx,2), %rax
; AVX2-NEXT:    shlq $3, %rax
; AVX2-NEXT:    subq %rax, %rdx
; AVX2-NEXT:    addq %rcx, %rdx
; AVX2-NEXT:    vmovq %rdx, %xmm2
; AVX2-NEXT:    vpextrq $1, %xmm1, %rcx
; AVX2-NEXT:    movabsq $6966426675817289639, %rdx # imm = 0x60ADB826E5E517A7
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rdx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq $11, %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    imulq $5423, %rdx, %rax # imm = 0x152F
; AVX2-NEXT:    subq %rax, %rcx
; AVX2-NEXT:    vmovq %rcx, %xmm1
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; AVX2-NEXT:    vpextrq $1, %xmm0, %rcx
; AVX2-NEXT:    movabsq $7220743857598845893, %rdx # imm = 0x64353C48064353C5
; AVX2-NEXT:    movq %rcx, %rax
; AVX2-NEXT:    imulq %rdx
; AVX2-NEXT:    movq %rdx, %rax
; AVX2-NEXT:    shrq $63, %rax
; AVX2-NEXT:    sarq $8, %rdx
; AVX2-NEXT:    addq %rax, %rdx
; AVX2-NEXT:    imulq $654, %rdx, %rax # imm = 0x28E
; AVX2-NEXT:    subq %rax, %rcx
; AVX2-NEXT:    vmovq %rcx, %xmm0
; AVX2-NEXT:    vpslldq {{.*#+}} xmm0 = zero,zero,zero,zero,zero,zero,zero,zero,xmm0[0,1,2,3,4,5,6,7]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm0
; AVX2-NEXT:    retq
  %1 = srem <4 x i64> %x, <i64 1, i64 654, i64 23, i64 5423>
  ret <4 x i64> %1
}
