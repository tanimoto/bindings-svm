#include "svm.h"

struct svm_model
{
	struct svm_parameter param;
	int nr_class;
	int l;
	struct svm_node **SV;
	double **sv_coef;
	double *rho;
	double *probA;
	double *probB;

	// for classification only
	int *label;
	int *nSV;
	int free_sv;
};
