FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnudging/test1:08d0eb8aaa8c0668d481aebf7fb8d3bb1f42ca5b@sha256:c51451c1f98b5c3fb7a4e3c13e9106bcf848303ad2c4ab0b561333d3f82ae37b AS nudgedimage
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
