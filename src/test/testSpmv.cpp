/**
 * This creates a random matrix and tests it.
 */

#include <iostream>
#include <cstdlib>
#include <vector>
#include "r3.h"
#include "r3Checker.h"
#include <fstream>
#include <sstream>
#include <string>

using namespace std;

int main(int argc, char* argv[]){
    int mode = 0;
    cerr << "argc: " << argc << endl;
    if(argc == 1)
        mode = 0;
    else if(argc == 2)
        mode = 1;
    else{
        cerr << "usage: testSpmv [file]" << endl;
        return 1;
    }
    vector<int> indexI;
    vector<int> indexJ;
    vector<double> value;
    int M, N, nnz;
    switch(mode){
        case 0:{
            M = 128;
            N = 128;
            int i = 0; int j = 0;

            while(i < 128){
                value.push_back((double)rand()/rand());
                indexI.push_back(i);
                indexJ.push_back(j);
                j += (rand()%50 + 1);
                if(j >= 128){
                    j -= 128;
                    i++;
                }
            }
            nnz = value.size();
            break;
        }
        case 1:{
            //TODO: read matrix
            ifstream mtxFile(argv[1]);
            string line;
            getline(mtxFile, line);
            getline(mtxFile, line);
            stringstream(line) >> M >> N >> nnz;
            cerr << M << " " << N << " " << nnz << endl;
            for(int i = 0; i < nnz; i++){
                getline(mtxFile, line);
                int tmp1, tmp2;
                double tmpD;
                stringstream(line) >> tmp1 >> tmp2 >> tmpD;
                indexI.push_back(tmp1);
                indexJ.push_back(tmp2);
                value.push_back(tmpD);
            }
            break;
        }
    }
    vector<double> xVector;
    for(int i = 0; i < N; i++){
        xVector.push_back(i);
    }
    //for(int i = 0; i < value.size(); i++){
    //    cerr << indexI[i] << " " << indexJ[i] << " " << value[i] << endl;
    //}
    vector<double> yVector;
    vector<double> yVectorCheck;

    for(int i = 0; i < M; i++){
        yVector.push_back(0);
        yVectorCheck.push_back(0);
    }
    for(int i = 0; i < value.size(); i++){
        yVectorCheck[indexI[i]] += value[i] * xVector[indexJ[i]];
    }
    cerr << "before encoding" << endl;
    spoonHeader* encodedMatrix = cnySpoonFmt(&indexI[0], &indexJ[0], &value[0], M, N, nnz);
    //TODO: run outside of emulator check validity
    r3Check(encodedMatrix, &indexI[0], &indexJ[0], &value[0], M, N, nnz);
    cerr << "before run" << endl;
    runR3(encodedMatrix, &xVector[0], &yVector[0]);
    cerr << "after run"  << endl;
    int errorCount = 0;
    for(int i = 0; i < yVectorCheck.size(); i++){
        if((yVectorCheck[i] > (yVector[i] * 1.01)) || (yVectorCheck[i] * 1.01) < yVector[i]){
            cerr << dec;
            cerr << "mismatch at: " << i << endl;
            cerr << "yVector: " << yVector[i] << endl;
            cerr << "yVectorCheck: " << yVectorCheck[i] << endl;
            errorCount++;
            if(errorCount == 10)
                break;
        }
    }

    cerr << "finished with " << errorCount << " errors" << endl;
}
