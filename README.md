tanh-sinh quadrature
====================

**Quick links:** [documentation][doc], [releases][rel].

Performs numerical integration in one dimension using
[tanh-sinh quadrature][0].

This quadrature method provides good results for a variety of functions
and is about as general purpose as feasible.  It is also fairly robust at
handling singularities at the endpoints of the integral.

The method is described in the [paper by Masatake Mori and Masaaki
Sugihara][1] and is sometimes referred to as the double-exponential method.

The code was originally written by [John D. Cook][2], who has dedicated
the code to the [public domain][3].

Installation
------------

Download and unpack the [latest release][rel], then run:

    make PREFIX=/usr/local install

Replace `/usr/local` with wherever you want it to be installed.

Alternatively, you can just drop `tanhsinh.h` and `tanhsin.c` directly into
your project.

[0]: https://en.wikipedia.org/wiki/Tanh-sinh_quadrature
[1]: http://dx.doi.org/10.1016/S0377-0427%2800%2900501-X
[2]: http://codeproject.com/Articles/31550/Fast-Numerical-Integration
[3]: https://creativecommons.org/publicdomain/zero/1.0

[doc]: https://rufflewind.com/tanhsinh/tanhsinh_8h.html
[rel]: https://github.com/Rufflewind/tanhsinh/releases
