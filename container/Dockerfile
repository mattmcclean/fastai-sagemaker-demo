# Build an image that can do training and inference in SageMaker
# This is a Python 2 image that uses the nginx, gunicorn, flask stack
# for serving inferences in a stable way.

ARG aws_account_id
ARG aws_region

FROM $aws_account_id.dkr.ecr.$aws_region.amazonaws.com/fastai:latest

MAINTAINER Matt McClean <mmcclean@amazon.com>

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         nginx \
    && rm -rf /var/lib/apt/lists/*

# Here we get all python packages.
# These optimizations save a fair amount of space in the image, which reduces start up time.
RUN pip install flask gevent gunicorn && \
        rm -rf /root/.cache

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"

# Set up the program in the image
COPY conv_net /opt/program
WORKDIR /opt/program

RUN ln -s /fastai/fastai fastai
