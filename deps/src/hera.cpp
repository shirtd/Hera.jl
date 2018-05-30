#include "bottleneck.h"

typedef std::vector<std::pair<double, double>>  PairVector;

extern "C" {

    PairVector to_pairs(int n, double* X) {
        PairVector V;
        for (int i=0; i < n; i++) {
            std::pair<double, double> p;
            p.first = X[2*i];
            p.second = X[2*i + 1];
            V.push_back(p);
        }
        return V;
    }

    double bottleneck(int n, int m, double* A, double* B) {
        PairVector diagramA = to_pairs(n, A);
        PairVector diagramB = to_pairs(m, B);
        return hera::bottleneckDistExact(diagramA, diagramB, 0);
    }

    double bottleneck_approx(int n, int m, double* A, double* B, double t) {
        PairVector diagramA = to_pairs(n, A);
        PairVector diagramB = to_pairs(m, B);
        return hera::bottleneckDistApprox(diagramA, diagramB, t);
    }

    PairVector to_pairs_rng(int s, int n, double* X) {
        PairVector V;
        for (int i=0; i < n; i++) {
            std::pair<double, double> p;
            p.first = X[2*s + 2*i];
            p.second = X[2*s + 2*i + 1];
            V.push_back(p);
        }
        return V;
    }

    void bottlenecks(int n, int* ns, double* d, double** ret) {
        int s = 0;
        PairVector* dgms = new PairVector[n];
        for (int i=0; i < n; i++) {
            dgms[i] = to_pairs_rng(s,ns[i],d);
            s = s + ns[i];
        }

        int l = 0;
        for (int i=0; i < n; i++){
            for (int j=i+1; j < n; j++) {
                (*ret)[l] = hera::bottleneckDistExact(dgms[i], dgms[j], 0);
                l++;
            }
        }
        delete[] dgms;
    }
}
