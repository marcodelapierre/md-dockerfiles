FROM jupyter/scipy-notebook

MAINTAINER Marco De La Pierre <marco.delapierre@pawsey.org.au>

RUN conda install --yes \
      netCDF4 \
      pytables \
    && conda clean -tipsy && \
    npm cache clean --force && \
    rm -rf $CONDA_DIR/share/jupyter/lab/staging && \
    rm -rf /home/$NB_USER/.cache/yarn && \
    rm -rf /home/$NB_USER/.node-gyp && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER $NB_UID
