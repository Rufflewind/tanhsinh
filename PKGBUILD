# Maintainer: Phil Ruffwind <rf@rufflewind.com>
pkgname=tanhsinh-git
pkgver=latest
pkgrel=1
pkgdesc="Numerical integration using tanh-sinh quadrature"
arch=(i686 x86_64)
url=https://github.com/Rufflewind/tanhsinh
license=(PD)
depends=()
makedepends=(git)
source=($pkgname::git://github.com/Rufflewind/tanhsinh)
sha256sums=(SKIP)

pkgver() {
    cd "$srcdir/$pkgname"
    s=`git 2>/dev/null describe --long --tags`
    if [ $? -eq 0 ]
    then
        printf '%s' "$s" | sed 's/^v//;s/\([^-]*-\)g/r\1/;s/-/./g'
    else
        printf 'r%s.%s' "`git rev-list --count HEAD`" \
                        "`git rev-parse --short HEAD`"
    fi
}

build() {
    cd "$srcdir/$pkgname"
    make all
}

package() {
    cd "$srcdir/$pkgname"
    make DESTDIR="$pkgdir" PREFIX=/usr install
}
