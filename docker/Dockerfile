FROM dolfinx/lab

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && \
    apt-get -y install libgl1-mesa-dev \ 
    xvfb

# Install optional dependencies of pyvista 
RUN pip3 install --upgrade pyvista ipytvtk_simple

# Allow jupyterlab for ipyvtk
ENV DISPLAY=:99.0
ENV JUPYTER_ENABLE_LAB=yes
ENV PYVISTA_USE_IPYVTK=true

CMD /bin/bash -c "Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &"