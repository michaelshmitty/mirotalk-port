PORTNAME=			mirotalk
DISTVERSION=		1.5.20
CATEGORIES=			www
MASTER_SITES=		https://git.michaelsmith.be/m/mirotalk-port/releases/download/initial/:node_modules
DISTFILES=			mirotalk-node-modules-${DISTVERSION}${EXTRACT_SUFX}:node_modules
DIST_SUBDIR=		${PORTNAME}

MAINTAINER=			shmitty@protonmail.com
COMMENT=			Simple, secure, fast and real time video conference web application
WWW=				https://github.com/miroslavpejic85/mirotalk

LICENSE=			AGPLv3

ONLY_FOR_ARCHS=		amd64

EXTRACT_DEPENDS=	node${NODEJS_VERSION}>0:www/node${NODEJS_VERSION} \
					npm${NODEJS_SUFFIX}>0:www/npm${NODEJS_SUFFIX}

USES=				nodejs:22

NO_BUILD=			yes

SUB_FILES=	mirotalk pkg-deinstall pkg-message
SUB_LIST=	MIROTALK_GROUP=${MIROTALK_GROUP} \
		MIROTALK_HOME=${MIROTALK_HOME} \
		MIROTALK_USER=${MIROTALK_USER}

USERS=		${MIROTALK_USER}
GROUPS=		${MIROTALK_GROUP}

USE_GITHUB=			yes
GH_ACCOUNT=			miroslavpejic85
GH_PROJECT=			${PORTNAME}
GH_TAGNAME=			5985501768fb9de93bbb94233b8de2d9e13f4f2f
USE_RC_SUBR=		${PORTNAME}

MIROTALK_GROUP?=	mirotalk
MIROTALK_USER?=		mirotalk
MIROTALK_HOME?=		${PREFIX}/mirotalk

PLIST_SUB+=	MIROTALK_GROUP=${MIROTALK_GROUP} \
		MIROTALK_HOME=${MIROTALK_HOME} \
		MIROTALK_USER=${MIROTALK_USER}

post-extract:
	@${ECHO_MSG} "===>  Installing node modules in ${WRKSRC}"
	@${TAR} -xzf ${DISTDIR}/${DIST_SUBDIR}/mirotalk-node-modules-${DISTVERSION}${EXTRACT_SUFX} -C ${WRKSRC}

do-install:
	${MKDIR} ${STAGEDIR}${MIROTALK_HOME}
	cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${MIROTALK_HOME}

### targets for port maintainer(s)
make-node-modules-archive: extract
	@${ECHO_MSG} "===>  Fetching and installing node modules in ${WRKSRC}"
	@cd ${WRKSRC} && \
	${SETENV} ${MAKE_ENV} npm install --ignore-scripts --no-progress --no-audit --no-fund && \
	${SETENV} ${MAKE_ENV} npm install @ngrok/ngrok-freebsd-x64 --ignore-scripts --no-progress --no-audit --no-fund && \
	${TAR} -czf ${WRKDIR}/mirotalk-node-modules${EXTRACT_SUFX} node_modules

.include <bsd.port.mk>
