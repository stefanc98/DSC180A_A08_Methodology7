FROM rocker/r-base:latest

USER root

COPY ./ ./
RUN Rscript ./run.R test

USER $NB_UID
