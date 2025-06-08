FROM jupyter/datascience-notebook:hub-3.1.1

USER root

# grupa nauczyciele
RUN groupadd nauczyciele

RUN useradd -m -s /bin/bash -G nauczyciele nauczyciel1

RUN useradd -m -s /bin/bash student1

# katalog shared i uprawnienia do niego
RUN mkdir -p /home/shared && \
    chown root:nauczyciele /home/shared && \
    chmod 775 /home/shared

# instalacja dodatkowych pakietów
RUN pip install jupyterlab-language-pack-pl-PL octave_kernel
RUN pip install dockerspawner
USER jovyan


CMD ["jupyterhub"]
