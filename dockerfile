#Download base image ubuntu 20.04
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="ghedirakais@gmail.com"
LABEL version="0.1"
LABEL description="This is custom Docker Image for \ the MultiQC Services."

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
ENV SHELL /bin/bash
# Update Ubuntu Software repository and install wget
SHELL ["/bin/bash", "-c"]
RUN echo $SHELL

RUN apt-get update -y -qq && apt-get install curl apt-utils -y -qq > /dev/null
RUN curl  https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh -o Anaconda3-5.3.1-Linux-x86_64.sh
RUN bash Anaconda3-5.3.1-Linux-x86_64.sh -b -p /opt/anaconda3
#RUN echo $SHELL
RUN ln -s /opt/anaconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh
#RUN echo "export PATH="/opt/anaconda3/bin:$PATH"" >> ~/.bashrc
RUN echo $SHELL
RUN ["/bin/bash", "-c","source ~/.bashrc"]
ENV PATH /opt/anaconda3/bin:$PATH
SHELL ["/bin/bash", "-c"]
#RUN echo $SHELL
RUN ["/bin/bash", "-c","conda update --all -y"]
RUN conda info -a
RUN source /opt/anaconda3/etc/profile.d/conda.sh
RUN conda init bash \
    && . ~/.bashrc \
    && conda create --name py3.7 python=3.7 -q -y \
    && conda activate py3.7 \
    && conda install -c bioconda -c conda-forge multiqc -y -q
RUN multiqc --help

