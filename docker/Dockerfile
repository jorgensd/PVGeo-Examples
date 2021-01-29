FROM dolfinx/lab

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && \
    apt-get -y install libgl1-mesa-dev \ 
    xvfb

# Install optional dependencies of pyvista 
RUN pip3 install --upgrade pyvista ipyvtk_simple

# Allow jupyterlab for ipyvtk
ENV DISPLAY=:99.0
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_USE_IPYVTK=true

ADD PVGeo-Examples/docker/nbstart /srv/bin/start
RUN  chmod +x /srv/bin/nbstart

ENTRYPOINT ["jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root", "/srv/bin/nbstart"]
