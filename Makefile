PORTNAME=	mirotalk
DISTVERSION=	1.5.20
CATEGORIES=	net-p2p

MAINTAINER=	m@hacktheplanet.be
COMMENT=	Simple, Secure, Fast Real-Time Video Conferences web application
WWW=		https://github.com/miroslavpejic85/mirotalk

LICENSE=	AGPLv3

EXTRACT_DEPENDS=	node${NODEJS_VERSION}>0:www/node${NODEJS_VERSION} \
			npm${NODEJS_SUFFIX}>0:www/npm${NODEJS_SUFFIX}

USES=		nodejs:22

USE_GITHUB=	yes
GH_ACCOUNT=	miroslavpejic85
GH_PROJECT=	${PORTNAME}
GH_TAGNAME=	5985501768fb9de93bbb94233b8de2d9e13f4f2f
USE_RC_SUBR=	${PORTNAME}

do-build:

do-install:

### targets for port maintainer(s)
make-node-modules-archive: extract
	@${ECHO_MSG} "===>  Fetching and installing node modules in ${WRKSRC}"
	@cd ${WRKSRC} && \
	${SETENV} ${MAKE_ENV} npm install --ignore-scripts --no-progress --no-audit --no-fund && \
	${TAR} -czf ${WRKDIR}/mirotalk-node-modules${EXTRACT_SUFX} node_modules

.include <bsd.port.mk>
