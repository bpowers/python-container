FROM debian:jessie

RUN apt-get update && apt-get install -y \
		apache2-utils asciidoc build-essential bzr ca-certificates \
		cdbs coffeescript curl debhelper devscripts dpkg-sig \
		gettext gfortran git graphviz-dev libblas-dev \
		libcairo2-dev libcurl4-gnutls-dev libevent-dev libffi-dev \
		libjpeg-dev liblapack-dev liblinear-dev libmemcached-dev \
		libmysqlclient-dev libncurses5 libncurses5-dev \
		libpng12-dev libprotobuf-dev libprotoc-dev libqhull-dev \
		libsqlite3-dev libsvm-dev libxml2-dev libxslt-dev \
		mercurial npm pkg-config postgresql-client \
		pwgen python2.7 python2.7-dev python-all-dev python-dbg \
		python-dev python-mock python-pip python-support \
		python-virtualenv uuid-dev virtualenv xmlto yui-compressor \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /srv/src

WORKDIR /srv/src

ENV VENV=/srv/env
