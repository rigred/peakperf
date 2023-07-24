#include "256_2_nofma.hpp"
#define OP_PER_IT B_256_2_NOFMA_OP_IT

TYPE farr_256_2_nofma[MAX_NUMBER_THREADS][SIZE] __attribute__((aligned(64)));

void compute_256_2_nofma(TYPE *farr, TYPE mult, int index) {
  farr = farr_256_2_nofma[index];

  for(long i=0; i < BENCHMARK_CPU_ITERS; i++) {
    farr[0]  = _mm256_add_ps(farr[0], farr[1]);
    farr[2]  = _mm256_add_ps(farr[2], farr[3]);
  }
}
