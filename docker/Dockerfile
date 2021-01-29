FROM dolfinx/lab

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && \
    apt-get -y install libgl1-mesa-dev \ 
    xvfb && \
         apt-get clean && rm -rf /var/lib/apt/lists/*

# Install optional dependencies of pyvista 
RUN pip3 install --no-cache pyvista ipyvtk_simple

# Add headless display
COPY expath/docker/nbstart /srv/bin/nbstart
RUN  chmod +x /srv/bin/nbstart

EXPOSE 8888/tcp
ENV SHELL /bin/bash

ENTRYPOINT ["/srv/bin/nbstart", "jupyter", "lab", "--ip", "0.0.0.0", "--no-browser", "--allow-root"]
