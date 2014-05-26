/**
 * cnySpoonFmt converts the coo format to the compressed format for R3
 */
#include <convey/usr/cny_comp.h>
#include "packetEncoder.h"
spoonHeader* cnySpoonFmt(int* row, int* col, double* val, int M, int N, int nnz);
void runR3(spoonHeader* headerInfo, double* x, double* y);
spoonHeader* cnySpoonFmt(int* row, int* col, double* val, int M, int N, int nnz, int maxSize, int* sets);
void runR3(spoonHeader* headerInfo, double* x, double* y, int sets);
extern cny_image_t sig;
