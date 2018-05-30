#include "bottleneck.h"

typedef std::vector<std::pair<double, double>>  PairVector;

extern "C" {

    double bottleneck(int n, int m, double* A, double* B) {
        PairVector diagramA;
        for (int i=0; i < n; i++) {
            std::pair<double, double> p;
            p.first = A[2*i];
            p.second = A[2*i + 1];
            diagramA.push_back(p);
            // delete A[2*i];
            // delete A[2*i + 1];
        }
        // delete[] A;

        PairVector diagramB;
        for (int i=0; i < m; i++) {
            std::pair<double, double> p;
            p.first = B[2*i];
            p.second = B[2*i + 1];
            diagramB.push_back(p);
            // delete B[2*i];
            // delete B[2*i + 1];
        }
        // delete[] B;

        return hera::bottleneckDistExact(diagramA, diagramB, 0);
    }
}
