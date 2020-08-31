; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512dq | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512DQ
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=ALL --check-prefix=AVX512 --check-prefix=AVX512BW

;
; Variable Shifts
;

define <8 x i64> @var_shift_v8i64(<8 x i64> %a, <8 x i64> %b) nounwind {
; ALL-LABEL: var_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlvq %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <8 x i64> %a, %b
  ret <8 x i64> %shift
}

define <16 x i32> @var_shift_v16i32(<16 x i32> %a, <16 x i32> %b) nounwind {
; ALL-LABEL: var_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlvd %zmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <16 x i32> %a, %b
  ret <16 x i32> %shift
}

define <32 x i16> @var_shift_v32i16(<32 x i16> %a, <32 x i16> %b) nounwind {
; AVX512DQ-LABEL: var_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm2 = ymm1[0],zero,ymm1[1],zero,ymm1[2],zero,ymm1[3],zero,ymm1[4],zero,ymm1[5],zero,ymm1[6],zero,ymm1[7],zero,ymm1[8],zero,ymm1[9],zero,ymm1[10],zero,ymm1[11],zero,ymm1[12],zero,ymm1[13],zero,ymm1[14],zero,ymm1[15],zero
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm3 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512DQ-NEXT:    vpsrlvd %zmm2, %zmm3, %zmm2
; AVX512DQ-NEXT:    vpmovdw %zmm2, %ymm2
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm1, %ymm1
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm1 = ymm1[0],zero,ymm1[1],zero,ymm1[2],zero,ymm1[3],zero,ymm1[4],zero,ymm1[5],zero,ymm1[6],zero,ymm1[7],zero,ymm1[8],zero,ymm1[9],zero,ymm1[10],zero,ymm1[11],zero,ymm1[12],zero,ymm1[13],zero,ymm1[14],zero,ymm1[15],zero
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm0
; AVX512DQ-NEXT:    vpmovzxwd {{.*#+}} zmm0 = ymm0[0],zero,ymm0[1],zero,ymm0[2],zero,ymm0[3],zero,ymm0[4],zero,ymm0[5],zero,ymm0[6],zero,ymm0[7],zero,ymm0[8],zero,ymm0[9],zero,ymm0[10],zero,ymm0[11],zero,ymm0[12],zero,ymm0[13],zero,ymm0[14],zero,ymm0[15],zero
; AVX512DQ-NEXT:    vpsrlvd %zmm1, %zmm0, %zmm0
; AVX512DQ-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm0, %zmm2, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: var_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlvw %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = lshr <32 x i16> %a, %b
  ret <32 x i16> %shift
}

define <64 x i8> @var_shift_v64i8(<64 x i8> %a, <64 x i8> %b) nounwind {
; AVX512DQ-LABEL: var_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm2
; AVX512DQ-NEXT:    vpsrlw $4, %ymm2, %ymm3
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm4 = [15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15]
; AVX512DQ-NEXT:    vpand %ymm4, %ymm3, %ymm3
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm1, %ymm5
; AVX512DQ-NEXT:    vpsllw $5, %ymm5, %ymm5
; AVX512DQ-NEXT:    vpblendvb %ymm5, %ymm3, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsrlw $2, %ymm2, %ymm3
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm6 = [63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63,63]
; AVX512DQ-NEXT:    vpand %ymm6, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpaddb %ymm5, %ymm5, %ymm5
; AVX512DQ-NEXT:    vpblendvb %ymm5, %ymm3, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsrlw $1, %ymm2, %ymm3
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm7 = [127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127]
; AVX512DQ-NEXT:    vpand %ymm7, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpaddb %ymm5, %ymm5, %ymm5
; AVX512DQ-NEXT:    vpblendvb %ymm5, %ymm3, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsrlw $4, %ymm0, %ymm3
; AVX512DQ-NEXT:    vpand %ymm4, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpsllw $5, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpblendvb %ymm1, %ymm3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsrlw $2, %ymm0, %ymm3
; AVX512DQ-NEXT:    vpand %ymm6, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpaddb %ymm1, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpblendvb %ymm1, %ymm3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsrlw $1, %ymm0, %ymm3
; AVX512DQ-NEXT:    vpand %ymm7, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpaddb %ymm1, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpblendvb %ymm1, %ymm3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: var_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlw $4, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpsllw $5, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpsrlw $2, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    vpsrlw $1, %zmm0, %zmm2
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpaddb %zmm1, %zmm1, %zmm1
; AVX512BW-NEXT:    vpmovb2m %zmm1, %k1
; AVX512BW-NEXT:    vmovdqu8 %zmm2, %zmm0 {%k1}
; AVX512BW-NEXT:    retq
  %shift = lshr <64 x i8> %a, %b
  ret <64 x i8> %shift
}

;
; Uniform Variable Shifts
;

define <8 x i64> @splatvar_shift_v8i64(<8 x i64> %a, <8 x i64> %b) nounwind {
; ALL-LABEL: splatvar_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlq %xmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %splat = shufflevector <8 x i64> %b, <8 x i64> undef, <8 x i32> zeroinitializer
  %shift = lshr <8 x i64> %a, %splat
  ret <8 x i64> %shift
}

define <16 x i32> @splatvar_shift_v16i32(<16 x i32> %a, <16 x i32> %b) nounwind {
; ALL-LABEL: splatvar_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpmovzxdq {{.*#+}} xmm1 = xmm1[0],zero,xmm1[1],zero
; ALL-NEXT:    vpsrld %xmm1, %zmm0, %zmm0
; ALL-NEXT:    retq
  %splat = shufflevector <16 x i32> %b, <16 x i32> undef, <16 x i32> zeroinitializer
  %shift = lshr <16 x i32> %a, %splat
  ret <16 x i32> %shift
}

define <32 x i16> @splatvar_shift_v32i16(<32 x i16> %a, <32 x i16> %b) nounwind {
; AVX512DQ-LABEL: splatvar_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxwq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm2
; AVX512DQ-NEXT:    vpsrlw %xmm1, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsrlw %xmm1, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatvar_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxwq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,xmm1[1],zero,zero,zero
; AVX512BW-NEXT:    vpsrlw %xmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %splat = shufflevector <32 x i16> %b, <32 x i16> undef, <32 x i32> zeroinitializer
  %shift = lshr <32 x i16> %a, %splat
  ret <32 x i16> %shift
}

define <64 x i8> @splatvar_shift_v64i8(<64 x i8> %a, <64 x i8> %b) nounwind {
; AVX512DQ-LABEL: splatvar_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpmovzxbq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,zero,zero,zero,zero,xmm1[1],zero,zero,zero,zero,zero,zero,zero
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm2
; AVX512DQ-NEXT:    vpsrlw %xmm1, %ymm2, %ymm2
; AVX512DQ-NEXT:    vpsrlw %xmm1, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm2, %zmm0, %zmm0
; AVX512DQ-NEXT:    vpcmpeqd %xmm2, %xmm2, %xmm2
; AVX512DQ-NEXT:    vpsrlw %xmm1, %xmm2, %xmm1
; AVX512DQ-NEXT:    vpsrlw $8, %xmm1, %xmm1
; AVX512DQ-NEXT:    vpbroadcastb %xmm1, %ymm1
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm1, %zmm1, %zmm1
; AVX512DQ-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatvar_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpmovzxbq {{.*#+}} xmm1 = xmm1[0],zero,zero,zero,zero,zero,zero,zero,xmm1[1],zero,zero,zero,zero,zero,zero,zero
; AVX512BW-NEXT:    vpsrlw %xmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    vpcmpeqd %xmm2, %xmm2, %xmm2
; AVX512BW-NEXT:    vpsrlw %xmm1, %xmm2, %xmm1
; AVX512BW-NEXT:    vpsrlw $8, %xmm1, %xmm1
; AVX512BW-NEXT:    vpbroadcastb %xmm1, %zmm1
; AVX512BW-NEXT:    vpandq %zmm1, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %splat = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %shift = lshr <64 x i8> %a, %splat
  ret <64 x i8> %shift
}

;
; Constant Shifts
;

define <8 x i64> @constant_shift_v8i64(<8 x i64> %a) nounwind {
; ALL-LABEL: constant_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlvq {{.*}}(%rip), %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <8 x i64> %a, <i64 1, i64 7, i64 31, i64 62, i64 1, i64 7, i64 31, i64 62>
  ret <8 x i64> %shift
}

define <16 x i32> @constant_shift_v16i32(<16 x i32> %a) nounwind {
; ALL-LABEL: constant_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlvd {{.*}}(%rip), %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <16 x i32> %a, <i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 8, i32 7, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 8, i32 7>
  ret <16 x i32> %shift
}

define <32 x i16> @constant_shift_v32i16(<32 x i16> %a) nounwind {
; AVX512DQ-LABEL: constant_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512DQ-NEXT:    vmovdqa {{.*#+}} ymm2 = <u,32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2>
; AVX512DQ-NEXT:    vpmulhuw %ymm2, %ymm1, %ymm3
; AVX512DQ-NEXT:    vpblendw {{.*#+}} xmm1 = xmm1[0],xmm3[1,2,3,4,5,6,7]
; AVX512DQ-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm3[4,5,6,7]
; AVX512DQ-NEXT:    vpmulhuw %ymm2, %ymm0, %ymm2
; AVX512DQ-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0],xmm2[1,2,3,4,5,6,7]
; AVX512DQ-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm2[4,5,6,7]
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: constant_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlvw {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = lshr <32 x i16> %a, <i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11, i16 12, i16 13, i16 14, i16 15, i16 0, i16 1, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11, i16 12, i16 13, i16 14, i16 15>
  ret <32 x i16> %shift
}

define <64 x i8> @constant_shift_v64i8(<64 x i8> %a) nounwind {
; AVX512DQ-LABEL: constant_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm1
; AVX512DQ-NEXT:    vpxor %xmm2, %xmm2, %xmm2
; AVX512DQ-NEXT:    vpunpckhbw {{.*#+}} ymm3 = ymm1[8],ymm2[8],ymm1[9],ymm2[9],ymm1[10],ymm2[10],ymm1[11],ymm2[11],ymm1[12],ymm2[12],ymm1[13],ymm2[13],ymm1[14],ymm2[14],ymm1[15],ymm2[15],ymm1[24],ymm2[24],ymm1[25],ymm2[25],ymm1[26],ymm2[26],ymm1[27],ymm2[27],ymm1[28],ymm2[28],ymm1[29],ymm2[29],ymm1[30],ymm2[30],ymm1[31],ymm2[31]
; AVX512DQ-NEXT:    vbroadcasti128 {{.*#+}} ymm4 = [2,4,8,16,32,64,128,256,2,4,8,16,32,64,128,256]
; AVX512DQ-NEXT:    # ymm4 = mem[0,1,0,1]
; AVX512DQ-NEXT:    vpmullw %ymm4, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpsrlw $8, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpunpcklbw {{.*#+}} ymm1 = ymm1[0],ymm2[0],ymm1[1],ymm2[1],ymm1[2],ymm2[2],ymm1[3],ymm2[3],ymm1[4],ymm2[4],ymm1[5],ymm2[5],ymm1[6],ymm2[6],ymm1[7],ymm2[7],ymm1[16],ymm2[16],ymm1[17],ymm2[17],ymm1[18],ymm2[18],ymm1[19],ymm2[19],ymm1[20],ymm2[20],ymm1[21],ymm2[21],ymm1[22],ymm2[22],ymm1[23],ymm2[23]
; AVX512DQ-NEXT:    vbroadcasti128 {{.*#+}} ymm5 = [256,128,64,32,16,8,4,2,256,128,64,32,16,8,4,2]
; AVX512DQ-NEXT:    # ymm5 = mem[0,1,0,1]
; AVX512DQ-NEXT:    vpmullw %ymm5, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpsrlw $8, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpackuswb %ymm3, %ymm1, %ymm1
; AVX512DQ-NEXT:    vpunpckhbw {{.*#+}} ymm3 = ymm0[8],ymm2[8],ymm0[9],ymm2[9],ymm0[10],ymm2[10],ymm0[11],ymm2[11],ymm0[12],ymm2[12],ymm0[13],ymm2[13],ymm0[14],ymm2[14],ymm0[15],ymm2[15],ymm0[24],ymm2[24],ymm0[25],ymm2[25],ymm0[26],ymm2[26],ymm0[27],ymm2[27],ymm0[28],ymm2[28],ymm0[29],ymm2[29],ymm0[30],ymm2[30],ymm0[31],ymm2[31]
; AVX512DQ-NEXT:    vpmullw %ymm4, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpsrlw $8, %ymm3, %ymm3
; AVX512DQ-NEXT:    vpunpcklbw {{.*#+}} ymm0 = ymm0[0],ymm2[0],ymm0[1],ymm2[1],ymm0[2],ymm2[2],ymm0[3],ymm2[3],ymm0[4],ymm2[4],ymm0[5],ymm2[5],ymm0[6],ymm2[6],ymm0[7],ymm2[7],ymm0[16],ymm2[16],ymm0[17],ymm2[17],ymm0[18],ymm2[18],ymm0[19],ymm2[19],ymm0[20],ymm2[20],ymm0[21],ymm2[21],ymm0[22],ymm2[22],ymm0[23],ymm2[23]
; AVX512DQ-NEXT:    vpmullw %ymm5, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512DQ-NEXT:    vpackuswb %ymm3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm1, %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: constant_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX512BW-NEXT:    vpunpckhbw {{.*#+}} zmm2 = zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[12],zmm1[12],zmm0[13],zmm1[13],zmm0[14],zmm1[14],zmm0[15],zmm1[15],zmm0[24],zmm1[24],zmm0[25],zmm1[25],zmm0[26],zmm1[26],zmm0[27],zmm1[27],zmm0[28],zmm1[28],zmm0[29],zmm1[29],zmm0[30],zmm1[30],zmm0[31],zmm1[31],zmm0[40],zmm1[40],zmm0[41],zmm1[41],zmm0[42],zmm1[42],zmm0[43],zmm1[43],zmm0[44],zmm1[44],zmm0[45],zmm1[45],zmm0[46],zmm1[46],zmm0[47],zmm1[47],zmm0[56],zmm1[56],zmm0[57],zmm1[57],zmm0[58],zmm1[58],zmm0[59],zmm1[59],zmm0[60],zmm1[60],zmm0[61],zmm1[61],zmm0[62],zmm1[62],zmm0[63],zmm1[63]
; AVX512BW-NEXT:    vpsllvw {{.*}}(%rip), %zmm2, %zmm2
; AVX512BW-NEXT:    vpsrlw $8, %zmm2, %zmm2
; AVX512BW-NEXT:    vpunpcklbw {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[16],zmm1[16],zmm0[17],zmm1[17],zmm0[18],zmm1[18],zmm0[19],zmm1[19],zmm0[20],zmm1[20],zmm0[21],zmm1[21],zmm0[22],zmm1[22],zmm0[23],zmm1[23],zmm0[32],zmm1[32],zmm0[33],zmm1[33],zmm0[34],zmm1[34],zmm0[35],zmm1[35],zmm0[36],zmm1[36],zmm0[37],zmm1[37],zmm0[38],zmm1[38],zmm0[39],zmm1[39],zmm0[48],zmm1[48],zmm0[49],zmm1[49],zmm0[50],zmm1[50],zmm0[51],zmm1[51],zmm0[52],zmm1[52],zmm0[53],zmm1[53],zmm0[54],zmm1[54],zmm0[55],zmm1[55]
; AVX512BW-NEXT:    vpsllvw {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    vpsrlw $8, %zmm0, %zmm0
; AVX512BW-NEXT:    vpackuswb %zmm2, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = lshr <64 x i8> %a, <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0, i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 7, i8 6, i8 5, i8 4, i8 3, i8 2, i8 1, i8 0>
  ret <64 x i8> %shift
}

;
; Uniform Constant Shifts
;

define <8 x i64> @splatconstant_shift_v8i64(<8 x i64> %a) nounwind {
; ALL-LABEL: splatconstant_shift_v8i64:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrlq $7, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <8 x i64> %a, <i64 7, i64 7, i64 7, i64 7, i64 7, i64 7, i64 7, i64 7>
  ret <8 x i64> %shift
}

define <16 x i32> @splatconstant_shift_v16i32(<16 x i32> %a) nounwind {
; ALL-LABEL: splatconstant_shift_v16i32:
; ALL:       # %bb.0:
; ALL-NEXT:    vpsrld $5, %zmm0, %zmm0
; ALL-NEXT:    retq
  %shift = lshr <16 x i32> %a, <i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5, i32 5>
  ret <16 x i32> %shift
}

define <32 x i16> @splatconstant_shift_v32i16(<32 x i16> %a) nounwind {
; AVX512DQ-LABEL: splatconstant_shift_v32i16:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsrlw $3, %ymm0, %ymm1
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm0
; AVX512DQ-NEXT:    vpsrlw $3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm0, %zmm1, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatconstant_shift_v32i16:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlw $3, %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = lshr <32 x i16> %a, <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>
  ret <32 x i16> %shift
}

define <64 x i8> @splatconstant_shift_v64i8(<64 x i8> %a) nounwind {
; AVX512DQ-LABEL: splatconstant_shift_v64i8:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vpsrlw $3, %ymm0, %ymm1
; AVX512DQ-NEXT:    vextracti64x4 $1, %zmm0, %ymm0
; AVX512DQ-NEXT:    vpsrlw $3, %ymm0, %ymm0
; AVX512DQ-NEXT:    vinserti64x4 $1, %ymm0, %zmm1, %zmm0
; AVX512DQ-NEXT:    vpandq {{.*}}(%rip), %zmm0, %zmm0
; AVX512DQ-NEXT:    retq
;
; AVX512BW-LABEL: splatconstant_shift_v64i8:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vpsrlw $3, %zmm0, %zmm0
; AVX512BW-NEXT:    vpandq {{.*}}(%rip), %zmm0, %zmm0
; AVX512BW-NEXT:    retq
  %shift = lshr <64 x i8> %a, <i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3, i8 3>
  ret <64 x i8> %shift
}
