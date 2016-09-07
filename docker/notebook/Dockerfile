FROM smly/base:0.4
MAINTAINER Kohei <i@ho.lc>

# tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.9.0/tini && \
    echo "faafbfb5b079303691a939a747d7f60591f2143164093727e870b289a44d9872 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV NB_USER kohei
ENV NB_UID 1000

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER

# Setup jovyan home directory
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir -p -m 700 /home/$NB_USER/.local/share/jupyter && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc

USER root

EXPOSE 8888
WORKDIR /home/$NB_USER/work
ENTRYPOINT ["tini", "--"]
CMD ["run_notebook.sh"]

# jupyter notebook
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py
COPY run_notebook.sh /usr/local/bin/run_notebook.sh
RUN chmod +x /usr/local/bin/run_notebook.sh
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

USER $NB_USER
