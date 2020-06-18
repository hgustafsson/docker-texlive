FROM ubuntu:latest
MAINTAINER hgustafsson

RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*


RUN echo '\
selected_scheme scheme-small\n\
tlpdbopt_install_docfiles 0\n\
tlpdbopt_install_srcfiles 0' >> /tmp/texlive.profile

WORKDIR /tmp

RUN curl -sL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | tar xz \
    && install-tl-*/install-tl --profile='/tmp/texlive.profile' \
    && rm -rf /tmp/*   

ENV PATH /usr/local/texlive/2020/bin/x86_64-linux:$PATH 

RUN tlmgr install latexmk latexdiff xpatch enumitem rsfs

WORKDIR /home 
CMD tlmgr --version
