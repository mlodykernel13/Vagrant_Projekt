FROM jupyter/datascience-notebook:hub-3.1.1

USER root

# Tworzymy grupę nauczyciele
RUN groupadd nauczyciele

# Tworzymy użytkownika nauczyciel i dodajemy do grupy nauczyciele
RUN useradd -m -s /bin/bash -G nauczyciele nauczyciel1

# Tworzymy użytkownika student
RUN useradd -m -s /bin/bash student1

# Tworzymy katalog shared i dajemy grupie nauczyciele prawa RW, inni tylko R
RUN mkdir -p /home/shared && \
    chown root:nauczyciele /home/shared && \
    chmod 775 /home/shared

# (Opcjonalnie) instalacja dodatkowych pakietów
RUN pip install jupyterlab-language-pack-pl-PL octave_kernel
RUN pip install dockerspawner
USER jovyan

# Kopiujemy plik konfiguracyjny jupyterhub_config.py (jeśli jest w kontekście builda)
# COPY jupyterhub_config.py /srv/jupyterhub/jupyterhub_config.py

CMD ["jupyterhub"]
