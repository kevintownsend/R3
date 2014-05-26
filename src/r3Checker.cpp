#include <iostream>
#include <stdint.h>
#include <cstdio>
#include <cstdlib>
#include <map>
#include "r3.h"
#include "packetEncoder.h"

using namespace std;
map<int64_t, map<int64_t, double> > cooMapper(int* row, int* col, double* val, int M, int N, int nnz);
map<int64_t, map<int64_t, double> > r3Mapper(spoonHeader* headerInfo, int sets);

void r3Check(spoonHeader* headerInfo, int* row, int* col, double* val, int M, int N, int nnz, int sets=1){
    map<int64_t, map<int64_t, double> > cooMatrix = cooMapper(row, col, val, M, N, nnz);
    map<int64_t, map<int64_t, double> > r3Matrix = r3Mapper(headerInfo, sets);
    int i = 0;
    cerr << "Checking if all encoded values are in the matrix" << endl;
    for(map<int64_t, map<int64_t, double> >::iterator it1 = r3Matrix.begin(); it1 != r3Matrix.end(); it1++){
        for(map<int64_t, double>::iterator it2 = it1->second.begin(); it2 != it1->second.end(); it2++){
            if(cooMatrix[it1->first].count(it2->first)){
                if(r3Matrix[it1->first][it2->first] != cooMatrix[it1->first][it2->first]){
                    cerr << dec;
                    cerr << "ERROR: mismatch at: " << it1->first << ", " << it2->first << endl;
                    cerr << "iteration: " << i << endl;
                    return;
                }
            }else{
                cerr << dec;
                cerr << "ERROR: mismatch at: " << endl;
                cerr << "r3matrix: " << it1->first << ", " << it2->first << endl;
                cerr << "iteration: " << i << endl;
                return;
            }
            i++;
        }
    }
    cerr << "Checking if all coo values are encoded" << endl;
    for(map<int64_t, map<int64_t, double> >::iterator it1 = cooMatrix.begin(); it1 != cooMatrix.end(); it1++){
        for(map<int64_t, double>::iterator it2 = it1->second.begin(); it2 != it1->second.end(); it2++){
            if(r3Matrix[it1->first].count(it2->first)){
                if(r3Matrix[it1->first][it2->first] != cooMatrix[it1->first][it2->first]){
                    cerr << dec;
                    cerr << "ERROR: mismatch at: " << it1->first << ", " << it2->first << endl;
                    cerr << "iteration: " << i << endl;
                    return;
                }
            }else{
                cerr << dec;
                cerr << "ERROR: mismatch at: " << endl;
                cerr << "coo matrix: " << it1->first << ", " << it2->first << endl;
                cerr << "iteration: " << i << endl;
                return;
            }
            i++;
        }
    }
}

map<int64_t, map<int64_t, double> > r3Mapper(spoonHeader* headerInfo, int sets){
    map<int64_t, map<int64_t, double> > ret;
    int64_t offset = 0;
    for(int i = 0; i < sets * 64; i++){
        uint64_t nnz, aMemSize;
        void* a = headerInfo[i].a;
        nnz = headerInfo[i].nnz;
        aMemSize = headerInfo[i].aSize;

        double* mcv = headerInfo[i].mcv;
        if(nnz == 0)
            continue;
        uint64 tmp;
        double mcVals[256];
        for(int j = 0; j < 256; j++){
            mcVals[j] = mcv[j];
        }
        uint64 buffer[4];
        uint64_t* a64 = (uint64_t*)a;
        buffer[0] = *a64++;
        buffer[1] = *a64++;
        buffer[2] = 0;
        buffer[3] = 0;
        int count = 16;
        uint64 currRow = 0;
        uint64 delta = 0;
        double matVal;
        int opcode;
        uint64 row = 0;
        uint64 col = 0;
        uint64 oldCol = ULONG_MAX;
        uint64 tmpVector;
        while(!(!buffer[0] && !buffer[1])){
            opcode = (buffer[0] & 7);
            switch(buffer[0] & 7){
                case 0:
                    currRow++;
                    break;
                case 1:
                    delta = (buffer[0] >> 3) & 0x1F;
                    break;
                case 2:
                    delta = (((buffer[0] >> 16) & 0xFF) << 5)|((buffer[0] >> 3) & 0x1F);
                    break;
                case 3:
                    delta = (((buffer[0] >> 16) & 0xFFFFFF) << 5)|((buffer[0] >> 3) & 0x1F);
                    break;
                case 4:
                    delta = (((buffer[0] >> 16) & 0xFFFFFFFFFF) << 5)|((buffer[0] >> 3) & 0x1F);
                    break;
                case 5:
                    delta = (buffer[0] >> 3) & 0x1F;
                    break;
                case 6:
                    delta = (((buffer[1] >> 8) & 0xFFFF) << 5)|((buffer[0] >> 3) & 0x1F);
                    break;
                case 7:
                    delta = (((buffer[1] >> 8) & 0xFFFFFFFFFF) << 5)|((buffer[0] >> 3) & 0x1F);
                    break;
            }
            if((opcode > 0)&&(opcode < 5)){
                matVal = mcVals[(buffer[0] >> 8) & 0xFF];
            }else{
                tmp = ((buffer[1] << 56)|(buffer[0] >> 8));
                matVal = *(double*)&tmp;
            }
            if(opcode > 0){
                row = row + (delta & 0x0F);
                if(row > 15){
                    row %= 16;
                    col++;
                }
                col += (delta >> 4);
                oldCol = col;
                ret[row + currRow*16 + offset][col] = matVal;
            }else{
                row = 0;
                col = 0;
            }
            int shift;
            switch(opcode){
                case 0:
                    shift = 1;
                    break;
                case 1:
                    shift = 2;
                    break;
                case 2:
                    shift = 3;
                    break;
                case 3:
                    shift = 5;
                    break;
                case 4:
                    shift = 7;
                    break;
                case 5:
                    shift = 9;
                    break;
                case 6:
                    shift = 11;
                    break;
                case 7:
                    shift = 14;
                    break;
            }
            if(shift < 8){
                buffer[0] = (buffer[1] << (64 - shift * 8))|(buffer[0] >> (shift * 8));
                buffer[1] = (buffer[2] << (64 - shift * 8))|(buffer[1] >> (shift * 8));
                buffer[2] = (buffer[3] << (64 - shift * 8))|(buffer[2] >> (shift * 8));
                buffer[3] = buffer[3] >> (shift * 8);
            }else{
                buffer[0] = (buffer[2] << (128 - shift * 8))|(buffer[1] >> -(64 - shift * 8));
                buffer[1] = (buffer[3] << (128 - shift * 8))|(buffer[2] >> -(64 - shift * 8));
                buffer[2] = (buffer[3] >> -(64 - shift * 8));
                buffer[3] = 0;
            }
            count -= shift;
            
            while(count < 16){
                tmp = *a64++;
                buffer[count / 8] = (tmp << ((count % 8) * 8))|buffer[count / 8];
                if(count % 8)
                    buffer[(count / 8) + 1] = (tmp >> ((8 - (count % 8)) * 8));
                count = count + 8;
            }
        }
        offset += headerInfo[i].resLength;
    }
    return ret;
}

map<int64_t, map<int64_t, double> > cooMapper(int* row, int* col, double* val, int M, int N, int nnz){
    map<int64_t, map<int64_t, double> > ret;
    for(int i1 = 0; i1 < nnz; i1++){
        ret[row[i1]][col[i1]] = val[i1];
    }
    return ret;
}
