FROM ubuntu:18.04

RUN mkdir /apps && echo "echo ciao mondo" >/apps/ciao.sh && chmod o+x /apps/ciao.sh

RUN echo 'if [ -z ${DEFINE_ME_ONCE+x} ] ; then' >/etc/profile.d/zz_ciao.sh && \
    echo ' export PATH="/apps:$PATH"' >>/etc/profile.d/zz_ciao.sh && \
    echo ' echo "bonjour le monde"' >>/etc/profile.d/zz_ciao.sh && \
    echo ' export DEFINE_ME_ONCE="1"' >>/etc/profile.d/zz_ciao.sh && \
    echo 'fi' >>/etc/profile.d/zz_ciao.sh

RUN mkdir -p /.singularity.d/env/ && \
    echo 'if [ -z ${DEFINE_ME_ONCE+x} ] ; then' >/.singularity.d/env/91-environment.sh && \
    echo ' export PATH="/apps:$PATH"' >>/.singularity.d/env/91-environment.sh && \
    echo ' echo "bonjour le monde"' >>/.singularity.d/env/91-environment.sh && \
    echo ' export DEFINE_ME_ONCE="1"' >>/.singularity.d/env/91-environment.sh && \
    echo 'fi' >>/.singularity.d/env/91-environment.sh

RUN /bin/mv /bin/sh /bin/sh.original && /bin/ln -s /bin/bash /bin/sh

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
CMD [ "/bin/bash" ]
