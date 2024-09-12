FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnudging/test1:08d0eb8aaa8c0668d481aebf7fb8d3bb1f42ca5b@sha256:2f6df00df270821900671afdf31a079f86c6d3eb7d315d8956e34c7b1b6b8d48 AS nudgedimage
USER 0
RUN echo "nudged image"
RUN mkdir /testdir
COPY somedir/app.py /testdir

FROM registry.access.redhat.com/ubi9/python-39:1-197.1725907694

# By default, listen on port 8081
EXPOSE 8081/tcp
ENV FLASK_PORT=8081

# Set the working directory in the container
WORKDIR /projects

# Copy the content of the local src directory to the working directory
COPY . .

# Install any dependencies
RUN \
  if [ -f requirements.txt ]; \
    then pip install -r requirements.txt; \
  elif [ `ls -1q *.txt | wc -l` == 1 ]; \
    then pip install -r *.txt; \
  fi

USER 0
RUN mkdir /testdir
COPY --from=nudgedimage /testdir/* .

# Specify the command to run on container start
CMD [ "python", "./app.py" ]
