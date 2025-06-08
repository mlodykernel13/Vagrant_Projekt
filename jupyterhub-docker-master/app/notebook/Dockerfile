FROM jupyter/datascience-notebook:hub-3.1.1

USER root

RUN groupadd nauczyciele && \
    useradd -m -s /bin/bash -G nauczyciele nauczyciel1 && \
    useradd -m -s /bin/bash student1 && \
    mkdir -p /home/shared && \
    chown root:nauczyciele /home/shared && \
    chmod 775 /home/shared && \
    pip install jupyterlab-language-pack-pl-PL octave_kernel

USER jovyan
