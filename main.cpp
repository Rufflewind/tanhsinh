#include <iostream>
#include <cmath>
#include <iomanip>
#include "DEIntegrator.h"

class DemoFunction1
{
public:
	double operator()(double x) const
	{
		return exp(-x/5.0)*(2.0 + sin(2.0*x));
	}
};

class DemoFunction2
{
public:
	double operator()(double x) const
	{
		return pow(1.0 - x, 5.0)*pow(x, -1.0/3.0);
	}
};

int main()
{
	DemoFunction1 f1;
	int evaluations;
	double errorEstimate;
	std::cout << std::setprecision(15);
	double integral = DEIntegrator<DemoFunction1>::Integrate(f1, 0, 10, 1e-6, evaluations, errorEstimate);
	std::cout << integral << ", " << errorEstimate << ", " << evaluations << "\n";

	DemoFunction2 f2;
	integral = DEIntegrator<DemoFunction2>::Integrate(f2, 0, 1, 1e-6);
	std::cout << integral << "\n";

	return 0;
}