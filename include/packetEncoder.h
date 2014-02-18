#ifndef PACKETENCODER_H
    #define PACKETENCODER_H
    typedef unsigned long long int uint64;
    typedef long long int int64;
    typedef unsigned int uint32;
    typedef struct{
        void* a;
        double* res;
        uint64 nnz;
        uint64 aSize;
        uint64 resLength;
        double* mcv;
    }spoonHeader;
    int sparseToCoo(uint32* c, uint32* r, double* val, void** coo, uint32 nz);
    //split data format: a, res, nnz, a mem size, res_size
    int splitCoo(void* coo, uint32 nz, uint64** splitData, double* y);
    int mmReadUnsymmetricSparseToCooAndSplit(char* name, int *M, int *N, int *nnz, void** coo, double** emptyY,uint64** splitData);
    int basicTo16ColMajRowMaj(uint64* source, uint64** dest, int nnz);
    int find256Mcv(uint64** values, uint64* source, int nnz);
    //int find256x64Mcv(uint64** allValues, uint64* source, uint64* oldSplitData);
    int spoonPackets(void** spank, uint64* source, uint64* values, int nnz, uint64* spankSpace);
    int toSpoon(spoonHeader* spoonData, int* row, int* col, double* val, int M, int N, int nnz);
    int toSpoon(spoonHeader** spoonData, int* row, int* col, double* val, int M, int N, int nnz);
    int toSpoon(spoonHeader** spoonData, int* row, int* col, double* val, uint64_t M, uint64_t N, uint64_t nnz, int maxSize);
    void printPacket(void* packets, uint64 totalSize);
    void printMatrix(void* packets, uint64 totalSize, double* mcv);
#endif
