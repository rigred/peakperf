#include "k10.hpp"
#define OP_PER_IT B_128_8_NOFMA_OP_IT

TYPE farr_k10[MAX_NUMBER_THREADS][SIZE] __attribute__((aligned(64)));  

#pragma GCC target("sse,sse2,sse3,sse4a")
void compute_k10(TYPE *farr, TYPE mult, int index) {
  farr = farr_k10[index];
  
  for(long i=0; i < BENCHMARK_CPU_ITERS; i++) {
    farr[0]  = _mm_add_ps(farr[0], farr[1]);
    farr[2]  = _mm_add_ps(farr[2], farr[3]);
	farr[4]  = _mm_add_ps(farr[4], farr[5]);
    farr[6]  = _mm_add_ps(farr[6], farr[7]);
    
	farr[8]  = _mm_mul_ps(farr[8], farr[9]);
    farr[10]  = _mm_mul_ps(farr[10], farr[11]);
    farr[12]  = _mm_mul_ps(farr[12], farr[13]);
    farr[14]  = _mm_mul_ps(farr[14], farr[15]);
  }
}
