#include <convey/usr/cny_comp.h>
#include <cstdlib>
#include <iostream>
#include "packetEncoder.h"
#include "r3.h"

using namespace std;

extern "C" long cpSpoonSmvm();
cny_image_t sig2;
cny_image_t sig;

spoonHeader* cnySpoonFmt(int* row, int* col, double* val, int M, int N, int nnz){
    spoonHeader* headerInfo;
    int stat;
    cny_get_signature((char*)"SMVM", &sig, &sig2, &stat);
    if(stat){
        cout << "ERROR: cny_get_signiture() Failure: " << stat << endl;
        exit(1);
    }

    toSpoon(&headerInfo, row, col, val, M, N, nnz);
    for(int i = 0; i < 64; i++){
        //printPacket(headerInfo[i].a, headerInfo[i].aSize);
        void *A = (void*)cny_cp_malloc(headerInfo[i].aSize);
        cny_cp_memcpy(A, headerInfo[i].a, headerInfo[i].aSize);
        free(headerInfo[i].a);
        headerInfo[i].a = A;
        headerInfo[i].res = NULL;
        double* mcv = (double*)cny_cp_malloc(256 * sizeof(uint64));
        if(headerInfo[i].nnz){
            cny_cp_memcpy(mcv, headerInfo[i].mcv, 256 * sizeof(uint64));
            free(headerInfo[i].mcv);
        }
        headerInfo[i].mcv = mcv;
        //printPacket(headerInfo[i].a, headerInfo[i].aSize);
    }
    spoonHeader* cnyHeaderInfo;
    cnyHeaderInfo = (spoonHeader*)cny_cp_malloc(64 * sizeof(spoonHeader));
    cny_cp_memcpy(cnyHeaderInfo, headerInfo, 64 * sizeof(spoonHeader));
    return cnyHeaderInfo;
}

void runR3(spoonHeader* headerInfo, double* x, double* y){
    
    for(int i = 0; i < 64; i++){
        headerInfo[i].res = y;
        y += headerInfo[i].resLength;
    }
    l_copcall_fmt(sig, cpSpoonSmvm, "AA", (uint64_t)x, (uint64_t)headerInfo);
}


spoonHeader* cnySpoonFmt(int* row, int* col, double* val, int M, int N, int nnz, int maxSize, int* sets){
    spoonHeader* headerInfo;
    int stat;
    cny_get_signature((char*)"SMVM", &sig, &sig2, &stat);
    if(stat){
        cout << "ERROR: cny_get_signiture() Failure: " << stat << endl;
        exit(1);
    }
    cout << "begin spoon" << endl;
    *sets = toSpoon(&headerInfo, row, col, val, (uint64_t)M, (uint64_t)N, (uint64_t)nnz, maxSize);
    cout << "end spoon" << endl;
    cout << "sets: " << *sets << endl;
    for(int i = 0; i < 64 * (*sets); i++){
        //cout << "iteration: " << i << endl;
        //printPacket(headerInfo[i].a, headerInfo[i].aSize);
        void *A = (void*)cny_cp_malloc(headerInfo[i].aSize);
        cny_cp_memcpy(A, headerInfo[i].a, headerInfo[i].aSize);
        free(headerInfo[i].a);
        headerInfo[i].a = A;
        headerInfo[i].res = NULL;
        double* mcv = (double*)cny_cp_malloc(256 * sizeof(uint64));
        if(headerInfo[i].nnz){
            cny_cp_memcpy(mcv, headerInfo[i].mcv, 256 * sizeof(uint64));
            free(headerInfo[i].mcv);
        }
        headerInfo[i].mcv = mcv;
        //printPacket(headerInfo[i].a, headerInfo[i].aSize);
    }
    cout << "near done" << endl;
    spoonHeader* cnyHeaderInfo;
    cnyHeaderInfo = (spoonHeader*)cny_cp_malloc((*sets) * 64 * sizeof(spoonHeader));
    cny_cp_memcpy(cnyHeaderInfo, headerInfo, (*sets) * 64 * sizeof(spoonHeader));
    return cnyHeaderInfo;
}

void runR3(spoonHeader* headerInfo, double* x, double* y, int sets){
    for(int i = 0; i < sets * 64; i++){
        headerInfo[i].res = y;
        y += headerInfo[i].resLength;
    }
    for(int i = 0; i < sets; i++){
        l_copcall_fmt(sig, cpSpoonSmvm, "AA", (uint64_t)x, (uint64_t)(headerInfo + 64 * (i)));
    }
}
