#include "CaeSim.h"
#include "CaeIsa.h"
#include <cstdio>
#include <iostream>
#include <climits>
#include <stdint.h>
#include <cstdlib>

#define MAX_AEG_INDEX 128
#define PERS_SIGN_CAE          0xff1d001000101000LL

#define AEUIE 0
#undef DEBUG

#ifndef MC_XBAR
#define MC_XBAR 0
#endif

void
CCaeIsa::InitPers()
{
    SetAegCnt(MAX_AEG_INDEX);
    SetPersSign(PERS_SIGN_CAE);
}

void
CCaeIsa::CaepInst(int aeId, int opcode, int immed, uint32 inst, uint64 scalar) // F7,0,20-3F
{
    switch (opcode) {
        case 0x20: {
            cout << "Hello World from emulated ae" << aeId << endl;
            for(int i = 0; i < 16; i++){
                uint64 vector = ReadAeg(aeId, 1);
                uint64 aAdr, yAdr, nnz, aMemSize, resultSize,mcv;
                aAdr = ReadAeg(aeId, 6 + i * 6);
                yAdr = ReadAeg(aeId, 7 + i * 6);
                nnz = ReadAeg(aeId, 8 + i * 6);
                aMemSize = ReadAeg(aeId, 9 + i * 6);
                resultSize = ReadAeg(aeId, 10 + i * 6);
                mcv = ReadAeg(aeId, 11 + i * 6);
                if(nnz == 0)
                    continue;
                else{
                    cerr << hex << "vector: " << vector << endl;
                    cerr << "aAdr: " << aAdr << endl;
                    cerr << "yAdr: " << yAdr << endl;
                    cerr << dec << "nnz: " << nnz << endl;
                    cerr << "aMemSize: " << aMemSize << endl;
                    cerr << "resultSize: " << resultSize << endl;
                    cerr << hex << "mcv: " << mcv << endl;
                }
                double* tmpResult = (double*)malloc(sizeof(double) * resultSize);
                for(int j = 0; j < (int)resultSize; j++)
                    tmpResult[j] = 0;
                uint64 tmp;
                double mcVals[256];
                for(int j = 0; j < 256; j++){
                    AeMemLoad(aeId, McNum(mcv), mcv, 8, false, (uint64&)mcVals[j]);
                    mcv += 8;
                }
                uint64 buffer[4];
                AeMemLoad(aeId, McNum(aAdr), aAdr, 8, false, buffer[0]);
                aAdr += 8;
                AeMemLoad(aeId, McNum(aAdr), aAdr, 8, false, buffer[1]);
                aAdr += 8;
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
                //return;
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
                        if(oldCol != col)
                            AeMemLoad(aeId, McNum(vector + 8 * col), vector + 8 * col, 8, false, tmpVector);
                        oldCol = col;
                        tmpResult[row + (currRow * 16)] += matVal * *(double*)&tmpVector;
                        /*cout << "updateing" << endl;
                        cout << "row:" << (row + (currRow * 16)) << endl;
                        cout << "column:" << col << endl;
                        cout << "vector:" << *(double*)&tmpVector << endl;
                        cout << "matrix:" << matVal << endl;
                        cout << "adding:" << matVal * *(double*)&tmpVector << endl;
                        cout << "result:" << *(double*)&tmpResult[row + (currRow* 16)] << endl;*/
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
                    
                    /*cout << "before" << endl;
                    for(int i = 3; i >= 0; i--){
                        printf("%016lx", buffer[i]);
                    }
                    cout << endl;*/
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
                    /*
                    cout << "after" << endl;
                    for(int i = 3; i >= 0; i--){
                        printf("%016lx", buffer[i]);
                    }
                    cout << endl;*/
                    count -= shift;
                    
                    while(count < 16){
                        AeMemLoad(aeId, McNum(aAdr), aAdr, 8, false, tmp);
                        //tmp = 0;
                        aAdr += 8;
                        buffer[count / 8] = (tmp << ((count % 8) * 8))|buffer[count / 8];
                        if(count % 8)
                            buffer[(count / 8) + 1] = (tmp >> ((8 - (count % 8)) * 8));
                        count = count + 8;
                    }
                }
                for(int j = 0; j < (int)resultSize; j++){
                    uint64 tmp = yAdr + 8 * j;
                    AeMemStore(aeId, McNum(tmp), yAdr + 8 * j, 8, false, *(uint64*)&(tmpResult[j]));
                }
                free(tmpResult);
            }
            cerr << "done" << endl;
	        break;}
	    default:
	        printf("Default case hit - opcode = %x\n", opcode);
	        for (int aeId = 0; aeId < CAE_AE_CNT; aeId += 1)
		        SetException(aeId, AEUIE);
	    
    }
}

