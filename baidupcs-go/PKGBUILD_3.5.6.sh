# Maintainer: Felix Yan <felixonmars@archlinux.org>

pkgname=baidupcs-go
_pkgname=BaiduPCS-Go
pkgver=3.5.6
pkgrel=2
pkgdesc="Terminal utility for Baidu Network Disk"
arch=('x86_64')
_importpath="github.com/iikira/${_pkgname}"
url="https://${_importpath}"
license=('Apache')
depends=('glibc')
makedepends=('go-pie' 'git')
conflicts=("baidupcs")
provides=("baidupcs")
source=("${pkgname}-${pkgver}.tar.gz::${url}/archive/v${pkgver}.tar.gz")
sha512sums=('fcec0e07b984dd83e554c98866db771737284c3ce1321e4fa05137e5d7ae59f5d4d1280024984dab3a5aa0a097312d0454c6d0d16d97c823d97342c44c8ca31e')

prepare() {
    cd "${srcdir}"

    mkdir -p .gopath/src/github.com/iikira
    ln -rTsf "${_pkgname}-${pkgver}" ".gopath/src/${_importpath}"
    export GOPATH="${srcdir}/.gopath:/usr/share/gocode"
}

build() {
    cd "${srcdir}"
    go build -v -work -x "${_importpath}"
}

package() {
    cd "${srcdir}"
    install -Dm755 "${_pkgname}" "${pkgdir}/usr/bin/baidupcs"
    install -Dm644 "${_pkgname}-${pkgver}/README.md" -t "${pkgdir}/usr/share/doc/${pkgname}"
}
