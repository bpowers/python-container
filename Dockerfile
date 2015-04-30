FROM debian:jessie

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
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
		mysql-client netcat libsnappy-dev \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /srv/src

RUN groupadd -g 1010 socialcode \
	&& useradd -g 1010 -u 1010 socialcode

RUN virtualenv /srv/env -q \
	&& /srv/env/bin/easy_install -q -U distribute \
	&& /srv/env/bin/easy_install -q -U pip

# from github.com/bpowers/gosu:readyexec-1.0
COPY gosu-amd64 /bin/readyexec

# waits for docker-compose dependencies to be ready, then exec's CMD
# as the socialcode user.
ENTRYPOINT ["/bin/readyexec", "socialcode"]

# copy requirements independent of rest of python project so that we
# can cache the install of dependencies
ONBUILD COPY requirements.txt /tmp/requirements.txt
ONBUILD RUN /srv/env/bin/pip install -r /tmp/requirements.txt

ONBUILD COPY . /srv/src

ONBUILD RUN /srv/env/bin/python setup.py develop

WORKDIR /srv/src

ENV VENV=/srv/env
