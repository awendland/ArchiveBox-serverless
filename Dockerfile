FROM lambci/lambda:build-python3.6

ARG ARCHIVEBOX_VERSION=django

# Setup archivebox dependencies (simplify to Pipfile once archivebox is on PyPi)
RUN curl -v "https://codeload.github.com/pirate/ArchiveBox/zip/${ARCHIVEBOX_VERSION}" > archivebox-src.zip \
 && unzip archivebox-src.zip \
 && mkdir -p /package/{pylibs,bin} \
 && pip install ArchiveBox*/ -t /package/pylibs

# Setup native dependencies of archivebox
RUN yum install -y rpmdevtools \
 && yum install -y --downloadonly --downloaddir=. wget \
 && rpmdev-extract wget*.rpm \
 && mv wget*/usr/bin/wget /package/bin \
 && rm -rf wget* wget*.* \
 && cp /usr/lib64/python3.4/lib-dynload/_sqlite3.cpython-34m.so /package/pylibs/_sqlite3.so

# Setup handler dependencies
ADD src/ /package/src
RUN pip install -r /package/src/requirements.txt -t /package/pylibs

ENV PATH="/package/bin:/package/pylibs/bin:${PATH}"
ENV PYTHONPATH="/package/pylibs"
ENV CHROME_BINARY="/tmp/chromium"

# Setup non-root user
RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser \
    && chown -R pptruser:pptruser /home/pptruser \
    && chown -R pptruser:pptruser /package \
    && chown -R pptruser:pptruser /tmp
USER pptruser

WORKDIR /package/src
CMD ['python', 'handler.py']
