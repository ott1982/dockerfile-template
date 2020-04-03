FROM ubuntu:bionic
ENV APP my-app
ENV USER $APP
ENV USER_ID 990
ENV GROUP $USER
ENV GROUP_ID 990
ENV HOME /home/${USER}
ENV OPT /opt/${APP}
ENV LIB /var/lib/${APP}
ENV LOG /var/log/${APP}
ENV ETC /etc/${APP}
RUN apt-get update && apt-get install --yes apt-utils && apt-get install --yes curl jq
RUN groupadd -g ${GROUP_ID} ${GROUP} && useradd -g ${GROUP} -s /sbin/nologin -d ${HOME} -u ${USER_ID} ${USER} && mkdir ${HOME} && chown -R ${USER}:${GROUP} ${HOME}
RUN mkdir -p ${OPT} && chown -R ${USER}:${GROUP} ${OPT}
RUN mkdir -p ${LOG} && chown -R ${USER}:${GROUP} ${LOG}
RUN mkdir -p ${LIB} && chown -R ${USER}:${GROUP} ${LIB}
RUN mkdir -p ${ETC} && chown -R ${USER}:${GROUP} ${ETC}
VOLUME ${LOG} ${LIB} ${OPT} ${ETC}
USER $USER
COPY sh/* ${OPT}/
ENTRYPOINT ${OPT}/migrate.sh