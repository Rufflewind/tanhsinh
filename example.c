#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "tanhsinh.h"

double f(double x, const void *ctx)
{
    (void)ctx;
    return exp(-x / 5.) * (2. + sin(2. * x));
}

double g(double x, const void *ctx)
{
    const double power = *(const double *)ctx;
    return pow(1. - x, power) * pow(x, -1. / 3.);
}

void check(double exact, double result, double tolerance) {
    if (!(fabs(exact - result) < tolerance)) {
        fprintf(stderr, "error: result does not seem to match\n");
        exit(EXIT_FAILURE);
    }
}

int main(void)
{
    static const double tolerance = 1e-6;
    double est_err, result;
    unsigned num_eval;
    {
        static const double exact = 9.10823960732299650652;
        result = tanhsinh_quad(f, NULL, 0, 10, tolerance, &est_err, &num_eval);
        printf("integral[0, 10] exp(-x/5) (2 + sin(2 x)):\n"
               "  exact:    %.17g\n"
               "  numeric:  %.17g +/- %.2g (%u evaluations)\n",
               exact, result, est_err, num_eval);
        check(exact, result, tolerance);
    }
    {
        static const double power = 5.;
        static const double exact = 0.417685255920550038197;
        result = tanhsinh_quad(g, &power, 0, 1, tolerance, NULL, NULL);
        printf("integral[0,  1] (1 - x)^5 x^(-1/3):\n"
               "  exact:    %.17g\n"
               "  numeric:  %.17g\n",
               exact, result);
        check(exact, result, tolerance);
    }
    return 0;
}
