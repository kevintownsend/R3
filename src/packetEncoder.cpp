#include <convey/usr/cny_comp.h>
#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <fstream>
#include "packetEncoder.h"
#include "mmio.h"
using namespace std;
//TODO: create log file
typedef unsigned char uint8;

int sparseToCoo(uint32* c, uint32* r, double* val, void** coo, uint32 nz){


    uint64* cooU64 = (uint64*)malloc(sizeof(uint64) * nz * 2);
    uint64 tmp;
    uint64 loc = 0;
    for(uint32 i = 0; i < nz; i++){
        tmp = (((uint64)c[i]) << 32) | (r[i]);
        cooU64[loc++] = tmp;
        cooU64[loc++] = *((uint64*)(val + i));
    }
    
    *coo = (void*)cooU64;
    return 0;
}

typedef struct{
    int column;
    double val[16];
    int prev;
    int next;
}shortStack;

void clearShortStack(shortStack* inst){
    inst->column = 0;
    for(int i = 0; i < 16; i++)
        inst->val[i] = 0;
    inst->prev = -1;
    inst->next = -1;
}

void stabilityCheck(int ptr, shortStack* memory){
    int startPoint = ptr;
    ptr = memory[ptr].next;
    cout << "stabitly check" << endl;
    while(ptr != startPoint){
        cout << "element:" << ptr << endl;
        cout << memory[ptr].column << endl;
        for(int i = 0; i < 16; i++)
            cout << memory[ptr].val[i] << endl;
        cout << memory[ptr].prev << endl;
        cout << memory[ptr].next << endl;
        ptr = memory[ptr].next;
    }
    cout << "stability check done" << endl;
}



int basicTo16ColMajRowMaj(uint64* source, uint64** dest, int nnz){
    shortStack* theHelp = (shortStack*)malloc(10000 * sizeof(shortStack));
    *dest = (uint64*)malloc(nnz * 2 * sizeof(uint64));
    int start = -1;
    int stackCount = 0;
    int sourcePtr = 0;
    int destPtr = 0;
    ofstream logFile;
    logFile.open("log", ios_base::app);
    if(theHelp == NULL){
        cout << "the Help is no help" << endl;
        logFile << "unable to allocate theHelp" << endl;
    }
    if(*dest == NULL){
        cout << "dest is no help" << endl;
        logFile << "unable to allocate *dest" << endl;
    }
    start = 0;
    stackCount++;
    clearShortStack(theHelp);
    theHelp[0].column = (int)(source[sourcePtr] >> 32);
    theHelp[0].val[(int)source[sourcePtr]] = *(double*)&(source[sourcePtr + 1]);
    sourcePtr += 2;
    theHelp[0].prev = 0;
    theHelp[0].next = 0;
    int currentRowGroup = 0;
    int theHelpSize = 100000;
    while(sourcePtr < 2 * nnz){
        if(stackCount >= theHelpSize){
            theHelpSize *= 2;
            theHelp = (shortStack*)realloc(theHelp, theHelpSize * sizeof(shortStack));
            if(theHelp == NULL)
                cout << "crap" << endl;
            else
                cout << "level up" << endl;
        }
        //stabilityCheck(start, theHelp);
        int column = (int)(source[sourcePtr] >> 32);
        int row = (int)source[sourcePtr];
        double val = *(double*)&source[sourcePtr + 1];
        if(currentRowGroup == row / 16){
            int stackPtr = start;
            if(column < theHelp[start].column){
                clearShortStack(&theHelp[stackCount]);
                theHelp[stackCount].column = column;
                theHelp[stackCount].val[row % 16] = val;
                theHelp[stackCount].prev = theHelp[start].prev;
                theHelp[stackCount].next = start;
                theHelp[theHelp[stackCount].prev].next = stackCount;
                theHelp[theHelp[stackCount].next].prev = stackCount;
                start = stackCount;
                stackCount++;
            }else{
                while((theHelp[stackPtr].next != start) && (theHelp[theHelp[stackPtr].next].column <= column)){
                    stackPtr = theHelp[stackPtr].next;
                }
                if(theHelp[stackPtr].column == column){
                    theHelp[stackPtr].val[row % 16] = val;
                }else{
                    clearShortStack(&theHelp[stackCount]);
                    theHelp[stackCount].val[row % 16] = val;
                    theHelp[stackCount].column = column;
                    theHelp[stackCount].next = theHelp[stackPtr].next;
                    theHelp[stackCount].prev = stackPtr;
                    theHelp[stackPtr].next = stackCount;
                    theHelp[theHelp[stackCount].next].prev = stackCount;
                    
                    //TODO: add short stacka
                    stackCount++;
                }
            }
        }else{
            int stackPtr = start;
            /*
            logFile << "dump to destination" << endl;
            logFile << "fraction lines complete:" << destPtr/2 << "/" << nnz*2 << endl;
            logFile << "start:" << start << endl;
            logFile << "stackCount " << stackCount << endl;
            */
            for(int i = 0; i < 16; i++){
                if(theHelp[stackPtr].val[i] != 0){
                    double tmp;
                    if(destPtr >= 2*nnz)
                        cout << "error: dest overflow" << endl;
                    if(stackPtr >= 100000)
                        cout << "error: stackPtr overflow" << endl;
                    (*dest)[destPtr++] = (((uint64)theHelp[stackPtr].column) << 32) | (currentRowGroup * 16 + i); //TODO: find bug
                    tmp = (theHelp[stackPtr].val[i]);
                    (*dest)[destPtr++] = *((uint64*)(&tmp));
                }
            }
            stackPtr = theHelp[stackPtr].next;
            while(stackPtr != start){
                for(int i = 0; i < 16; i++){
                    if(theHelp[stackPtr].val[i] != 0){
                        double tmp;
                        
                        (*dest)[destPtr++] = (((uint64)theHelp[stackPtr].column) << 32) | (currentRowGroup * 16 + i);
                        tmp = theHelp[stackPtr].val[i];
                        (*dest)[destPtr++] = *(uint64*)&tmp;
                    }
                }
                stackPtr = theHelp[stackPtr].next;
            }
            start = 0;
            stackCount = 1;
            clearShortStack(&theHelp[start]);
            theHelp[0].prev = 0;
            theHelp[0].next = 0;
            theHelp[0].val[row % 16] = val;
            theHelp[0].column = column;
            currentRowGroup = row / 16;
        }
        sourcePtr += 2;
    }
    int stackPtr = start;
    for(int i = 0; i < 16; i++){
        if(theHelp[stackPtr].val[i] != 0){
            double tmp;
            (*dest)[destPtr++] = (((uint64)theHelp[stackPtr].column) << 32) | (currentRowGroup * 16 + i);
            tmp = (theHelp[stackPtr].val[i]);
            (*dest)[destPtr++] = *((uint64*)(&tmp));
         }
    }
    stackPtr = theHelp[stackPtr].next;
    while(stackPtr != start){
         for(int i = 0; i < 16; i++){
             if(theHelp[stackPtr].val[i] != 0){
                double tmp;
                (*dest)[destPtr++] = (((uint64)theHelp[stackPtr].column) << 32) | (currentRowGroup * 16 + i);
                tmp = theHelp[stackPtr].val[i];
                (*dest)[destPtr++] = *(uint64*)&tmp;
            }
        }
        stackPtr = theHelp[stackPtr].next;
    }
    
    //TODO:add rest
    //TODO:
    free(theHelp);
    logFile.close();
    return destPtr;
}

int splitCoo(void* coo, uint32 nz, uint64** splitData, double* y){
    //split data format: a, res, nnz, a mem size, res_size
    uint64* cooU64 = (uint64*)coo;
    double cutSize = nz / 64.0;
    *splitData = (uint64*)malloc(64 * 5 * sizeof(uint64));
    uint64* data = *splitData;
    uint64 cursor = 0;
    data[0] = (uint64)coo;
    data[1] = (uint64)y;
    for(uint32 j = 1; j < 64; j++){
        cursor = j * cutSize;
        while(((cooU64[2 * cursor] % 0x10) == 0) && (cursor < nz)){
            cursor++;
        }
        while(((cooU64[2 * cursor] % 0x10) != 0) && (cursor < nz)){
            cursor++;
        }
        
        //a
        data[j * 5] = cursor * 16 + (uint64)coo;
        
        //res
        data[j * 5 + 1] = data[1] + ((uint32)(cooU64[2 * (cursor - 1)]) + 1 - (uint32_t)(cooU64[0])) * 8;
        //nnz
        data[(j - 1) * 5 + 2] = (data[j * 5]  - (data[(j - 1) * 5] )) / 16;
        //a mem size
        data[(j - 1) * 5 + 3] = data[(j - 1) * 5 + 2] * 16;
        //res_size
        data[(j - 1) * 5 + 4] = (data[j * 5 + 1] - data[(j - 1) * 5 + 1]) / 8;
    }
    data[63 * 5 + 2] = (uint64)nz - (data[63 * 5] - (uint64)coo) / 16;
    data[63 * 5 + 3] = data[63 * 5 + 2] * 16;
    data[63 * 5 + 4] = ((uint32)(cooU64[2 * (nz - 1)]) + 1) - (data[63 * 5 + 1] - data[1]) / 8;
    
    return 0;
}

int mmReadUnsymmetricSparseToCooAndSplit(char* name, int *M, int *N, int *nnz, void** coo, double** emptyY,uint64** splitData){
    double *val;
    int *I, *J;
    mm_read_unsymmetric_sparse(name, M, N, nnz, &val, &I, &J);
    void* hostCoo;
    sparseToCoo((uint32*)I, (uint32*)J, val, &hostCoo, *nnz);
    *coo = (void*)cny_cp_malloc(*nnz * 2 * 8);
    cny_cp_memcpy(*coo, hostCoo, *nnz * 2 * 8);
    
    *emptyY = (double*)cny_cp_malloc(*M * sizeof(double));
    uint64* hostSplitData;
    splitCoo(*coo, *nnz, &hostSplitData, *emptyY);
    *splitData = (uint64*)cny_cp_malloc(64 * 5 * sizeof(uint64));
    cny_cp_memcpy(*splitData, hostSplitData, 64 * 5 * sizeof(uint64));
    free(I);
    free(J);
    free(val);
    free(hostSplitData);
    free(hostCoo);
    return 0;
}

typedef struct{
    uint64 value;
    int left;
    int right;
    int parent;
    int count;
    int smaller;
    int larger;
}valueNode;

void clearValueNode(valueNode* node){
    node->value = 0;
    node->left = -1;
    node->right = -1;
    node->parent = -1;
    node->count = 0;
    node->smaller = -1;
    node->larger = -1;
    return;
}

void dfsMaxCount(valueNode* tree, int currNode, int* counts, uint64* values){
    if(tree[currNode].left != -1){
        dfsMaxCount(tree, tree[currNode].left, counts, values);
    }
    if(tree[currNode].right != -1){
        dfsMaxCount(tree, tree[currNode].right, counts, values);
    }
    int tmpCount = tree[currNode].count;
    uint64 tmpVal = tree[currNode].value;
    int swapCount;
    uint64 swapVal;
    for(int i = 0; i < 256; i++){
        if(counts[i] < tmpCount){
            swapCount = counts[i];
            counts[i] = tmpCount;
            tmpCount = swapCount;
            swapVal = values[i];
            values[i] = tmpVal;
            tmpVal = swapVal;
        }
    }
}

int find256Mcv(uint64** values, uint64* source, int nnz){
    *values = (uint64*)malloc(256 * sizeof(uint64));
    valueNode* tree = (valueNode*)malloc(nnz * sizeof(valueNode));
    clearValueNode(tree);
    int root = 0;
    int currNode = 0;
    int nodeCount = 1;
    tree[0].value = source[1];
    tree[0].count = 1;
    for(int i = 1; i < nnz; i++){
        currNode = root;
        while(true){
            if(tree[currNode].value == source[i * 2 + 1]){
                tree[currNode].count += 1;
                break;
            }else if(source[i * 2 + 1] < tree[currNode].value){
                if(tree[currNode].left == -1){
                    clearValueNode(&tree[nodeCount]);
                    tree[nodeCount].value = source[i * 2 + 1];
                    tree[nodeCount].parent = currNode;
                    tree[nodeCount].count = 1;
                    tree[currNode].left = nodeCount;
                    nodeCount++;
                    break;
                }else{
                    currNode = tree[currNode].left;
                }
            }else if(source[i * 2 + 1] > tree[currNode].value){
                if(tree[currNode].right == -1){
                    clearValueNode(&tree[nodeCount]);
                    tree[nodeCount].value = source[i * 2 + 1];
                    tree[nodeCount].parent = currNode;
                    tree[nodeCount].count = 1;
                    tree[currNode].right = nodeCount;
                    nodeCount++;
                    break;
                }else{
                    currNode = tree[currNode].right;
                }
            }
        }
    }
    int counts[256];
    for(int i = 0; i < 256; i++){
        (*values)[i] = 0;
        counts[i] = 0;
    }
    dfsMaxCount(tree, root, counts, *values);
    free(tree);
    return nodeCount;
}

int spoonPackets(void** spoon, uint64* source, uint64* values, int nnz, uint64* spankSpace){
    if(nnz == 0){
        *spoon = NULL;
        *spankSpace = 0;
        return 0;
    }
    *spoon = (void*)malloc(nnz * 2 * sizeof(uint64));
    uint8* spoonByte = (uint8*)*spoon;
    int rowGroup = ((int)source[0]) / 16;
    uint8* currByte = spoonByte;
    uint8 valCode = 0;
    uint64 delta = 0;
    uint8 deltaSize = 0; //number of bytes upto 6, if 7 new line and 7 bytes
    valCode = 255;
    int isCommon = 0;
    int header;
    for(int i = 0; i < 256; i++){
        if(source[1] == values[i]){
            valCode = i;
            isCommon = 1;
            break;
        }
    }
    uint64 tmp;
    delta = (source[0] >> 32) * 16 + (((int)source[0]) - rowGroup * 16);
    deltaSize = 0;
    while((delta >> (deltaSize * 8 + 5)) != 0)
        deltaSize++;
    
    header = 0;
    if(isCommon){
        if(deltaSize < 1)
            header = 1;
        else if(deltaSize < 2)
            header = 2;
        else if(deltaSize < 4){
            header = 3;
            deltaSize = 3;
        }else if(deltaSize < 6){
            header = 4;
            deltaSize = 5;
        }
    }else{
        if(deltaSize < 1){
            header = 5;
        }else if(deltaSize < 3){
            header = 6;
            deltaSize = 2;
        }else if(deltaSize < 6){
            header = 7;
            deltaSize = 5;
        }
    }
    
    *currByte = (uint8)((delta << 3) | header);
    currByte++;
    
    if((header > 0) && (header < 5)){
        *currByte = valCode;
        currByte++;
    }else{ 
        tmp = source[1];
        for(int i = 0; i < 8; i++){
            *currByte = tmp >> (i * 8);
            currByte++;
        }
    }

    for(int i = 0; i < deltaSize; i++){
        *currByte = (uint8)(delta >> (5 + 8 * i));
        currByte++;
    }

    for(int i = 1; i < nnz; i++){
        valCode = 255;
        isCommon = 0;
        for(int j = 0; j < 255; j++){
            if(source[i * 2 + 1] == values[j]){
                valCode = j;
                isCommon = 1;
                break;
            }
        }

        if(rowGroup == (((int)source[i * 2]) / 16)){
            delta = ((source[i * 2] >> 32) - (source[(i - 1) * 2] >> 32)) * 16 + (((int)source[i * 2]) - ((int)source[i * 2 - 2]));
            deltaSize = 0;
            while((delta >> (deltaSize * 8 + 5)) != 0)
                deltaSize++;
        }else{
            *currByte = 0;
            currByte++;
            delta = (source[i * 2] >> 32) * 16 + (((int)source[i * 2]) % 16);
            deltaSize = 0;
            while((delta >> (deltaSize * 8 + 5)) != 0)
                deltaSize++;
            rowGroup = ((int)source[i * 2] / 16);
        }

        header = 0;
        if(isCommon){
            if(deltaSize < 1)
                header = 1;
            else if(deltaSize < 2)
                header = 2;
            else if(deltaSize < 4){
                header = 3;
                deltaSize = 3;
            }else if(deltaSize < 6){
                header = 4;
                deltaSize = 5;
            }
        }else{
            if(deltaSize < 1){
                header = 5;
            }else if(deltaSize < 3){
                header = 6;
                deltaSize = 2;
            }else if(deltaSize < 6){
                header = 7;
                deltaSize = 5;
            }
        }

        *currByte = (uint8)((delta << 3) | header);
        currByte++;

        if((header > 0) && (header < 5)){
            *currByte = valCode;
            currByte++;
        }else{ 
            tmp = source[i * 2 + 1];
            for(int i = 0; i < 8; i++){
                *currByte = tmp >> (i * 8);
                currByte++;
            }
        }


        for(int j = 0; j < deltaSize; j++){
            *currByte = (uint8)(delta >> (5 + 8 * j));
            currByte++;
        }

    }
    while((currByte - spoonByte) % 8){
        *currByte = 0;
        currByte++;
    }
    for(int i = 0; i < 16; i++){
        *currByte = 0;
        currByte++;
    }

    *spankSpace = (int)(currByte - spoonByte);
    return 0;
}

int toSpoon(spoonHeader** spoonData, int* row, int* col, double* val, uint64_t M, uint64_t N, uint64_t nnz, int maxSize){
    int chunks = 64;
    int sets = 1;
    if(maxSize == 0)
        chunks = 64;
    else{
        chunks = nnz / maxSize;
        chunks /= 64;
        chunks *= 64;
        chunks += 64;
        sets = chunks/64;
    }

    *spoonData = (spoonHeader*)malloc(chunks * sizeof(spoonHeader));
    uint64_t tmp, prevTmp;
    prevTmp = 0;
    tmp = 0;
    cout << "first of data:" << endl;
    for(int i = 0; i < 100; i++){
        cout << "(" << row[i] << "," << col[i] << ")" << " = " << val[i];
    }
    for(int i = 1; i < sets; i++){
        tmp = nnz * i / sets;
        if(row[tmp] % 16 < 8){
            while(row[tmp] % 16 != 15)
                tmp--;
            tmp++;
        }else{
            while(row[tmp] % 16 != 0)
                tmp++;
        }
        cout << "this sucks: " << tmp;
        toSpoon(*spoonData + 64 * (i - 1), row + prevTmp, col + prevTmp, val + prevTmp, row[tmp] - row[prevTmp] ,N, tmp - prevTmp);
        prevTmp = tmp;
    }
    toSpoon(*spoonData + 64 * (sets - 1), row + tmp, col + tmp, val + tmp, M - row[tmp], N, nnz - tmp);

    return sets;
}
int toSpoon(spoonHeader** spoonData, int* row, int* col, double* val, int M, int N, int nnz){
    *spoonData = (spoonHeader*)malloc(64 * sizeof(spoonHeader));
    return toSpoon(*spoonData, row, col, val, M, N, nnz);
    
}

int toSpoon(spoonHeader* spoonData, int* row, int* col, double* val, int M, int N, int nnz){
    //TODO: change spoonData to single
    void* coo;
    sparseToCoo((uint32*)col, (uint32*)row, val, &coo, (uint32)nnz);

    double* y = (double*)malloc(sizeof(double) * M);
    uint64* splitData;
    splitCoo((uint64*)coo, (uint32)nnz, &splitData, y);
    uint64* cooColRow;
    nnz = basicTo16ColMajRowMaj((uint64*)coo, &cooColRow, nnz);
    
    //spoonHeader* hostSpoonData = (spoonHeader*)malloc(64 * sizeof(spoonHeader));
    spoonHeader* hostSpoonData = spoonData;
    uint64* cooColRowPtr = cooColRow;
    //TODO: move to cny
    for(int i = 0; i < 64; i++){
        if(splitData[i * 5 + 2] == 0){
            hostSpoonData[i].mcv = NULL;
            hostSpoonData[i].a = NULL;
            hostSpoonData[i].aSize = 0;
            hostSpoonData[i].nnz = 0;
            hostSpoonData[i].resLength = 0;
        }else{
            find256Mcv((uint64**)&(hostSpoonData[i].mcv), (uint64*)splitData[i * 5], (int)splitData[i * 5 + 2]);
            spoonPackets(&(hostSpoonData[i].a), cooColRowPtr, (uint64*)hostSpoonData[i].mcv, (int)splitData[i * 5 + 2], &(hostSpoonData[i].aSize));
            cooColRowPtr += 2 * splitData[i * 5 + 2];
            hostSpoonData[i].nnz = splitData[i * 5 + 2];
            hostSpoonData[i].resLength = splitData[i * 5 + 4];
        }
        /*cout << "packet header:" << endl;
        cout << "aSize:" << hostSpoonData[i].aSize << endl;
        cout << "nnz:" << hostSpoonData[i].nnz << endl;
        cout << "resLength:" << hostSpoonData[i].resLength << endl;
        */
    }
    //*spoonData = hostSpoonData;
    return 0;
}

void printPacket(void* packets, uint64 totalSize){
    cout << hex;
    cout << "printing da packets:" << endl;
    for(int64 i = (int64)(totalSize) - 1; i >= 0; i--){
        printf("%02x",(int)((uint8*)packets)[i]);
    }
    cout << endl;
}

void printMatrix(void* packets, uint64 totalSize, double* mcv){
    uint64_t row, col, delta;
    row = 0;
    col = 0;
    uint8_t* stream = (uint8_t*)packets;
    uint64_t streamP = 0;
    double value;
    while(streamP < totalSize){
        int header = stream[streamP] & 0x07;
        delta = (stream[streamP] & 0xF8) >> 3;
        streamP++;
        if(header == 0){
            col = 0;
            row = (row + 0x10) & 0xFFFFFFFFFFFFFFF0;
        }else if(header < 5){
            value = mcv[stream[streamP]];
            streamP++;
            if(header > 1)
                delta |= (uint64_t)stream[streamP++] << 5;
            if(header > 2){
                delta |= (uint64_t)stream[streamP++] << 13;
                delta |= (uint64_t)stream[streamP++] << 21;}
            if(header > 3){
                delta |= (uint64_t)stream[streamP++] << 29;
                delta |= (uint64_t)stream[streamP++] << 37;}
        }else{
            for(int i = 0; i < 8; i++){
                *((uint8_t*)&value + i) = stream[streamP++];
            }
            if(header > 5){
                delta |= (uint64_t)stream[streamP++] << 5;
                delta |= (uint64_t)stream[streamP++] << 13;}
            if(header > 6){
                delta |= (uint64_t)stream[streamP++] << 21;
                delta |= (uint64_t)stream[streamP++] << 29;
                delta |= (uint64_t)stream[streamP++] << 37;}
        }
        cout << dec;
        if(header > 0){
            int tmp = delta & 0xF;
            tmp += row & 0xF;
            if(tmp & 0x10)
                col++;
            row = (row & 0xFFFFFFFFFFFFFFF0) | (tmp & 0xF);
            col += delta >> 4;
            cout << "Delta:" << delta << endl;
            cout << row << " " << col << " " << value << endl;
        }else{
            cout << "END OF ROW" << endl;
        }
    }
}
