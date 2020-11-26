FROM rocker/r-base:latest

USER root

COPY ./ ./
RUN Rscript ./run.R test
