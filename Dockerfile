FROM dolfinx/dolfinx

RUN apt-get update && \
	apt-get install -y --no-install-recommends python3-pip libgl1-mesa-dev xvfb && \
	apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache notebook pyvista

# create user with a home directory
ARG NB_USER=fenics
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}
ENV PETSC_ARCH "linux-gnu-real-32"
RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}


WORKDIR ${HOME}
COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}
COPY start /srv/bin/start
RUN  chmod +x /srv/bin/start

USER ${USER}
ENTRYPOINT ["/srv/bin/start"]
CMD ["python3 test.py"]