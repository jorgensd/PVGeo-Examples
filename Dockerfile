FROM dolfinx/lab

RUN apt-get update && \
    apt-get -y install libgl1-mesa-dev \
    xvfb && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Install optional dependencies of pyvista 
RUN pip3 install --no-cache pyvista ipyvtk_simple

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
# Add headless display
RUN chown -R ${NB_UID} ${HOME}
COPY start /srv/bin/start
RUN  chmod +x /srv/bin/start

USER ${USER}

EXPOSE 8888/tcp
ENV SHELL /bin/bash


ENTRYPOINT ["/srv/bin/start", "jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]
