FROM dolfinx/dolfinx
#buildpack-deps:bionic

RUN apt-get update && \
	apt-get install -y --no-install-recommends python3-pip libgl1-mesa-dev xvfb && \
	apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip3 install --no-cache --upgrade pip && \
    pip3 install --no-cache notebook pyvista notebook

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

ENV DISPLAY=:99.0
ENV VISTA_OFF_SCREEN=True
ENV VISTA_PLOT_THEME=document
RUN which Xvfb
RUN Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &
RUN sleep 3
RUN exec "$@"

WORKDIR ${HOME}
COPY . ${HOME}
USER ${USER}
