FROM quay.io/rcerven_rhtaptest/rcerven-test/testnudging/ttest1:dcd969e325ba6a99598c8704428286e3faa3c50e@sha256:cd65d7586a2b45a997f1dbf0e5b25cc3b6e28dcee3ec747700c2206996f43808 AS nudgedimage
USER 0
RUN echo "nudged image"
RUN mkdir /testdir
COPY somedir/app.py /testdir

#FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnew/newtest1:09c143305d342da9c598f63a0ea25675c0c831e7@sha256:c03dd26fb9259a31039b20429151b993cb5b07ab7460bd5c919f4c494fcd0924 AS nudgedimagesecond
#USER 0
#RUN echo "nudged image"
#RUN mkdir /testdir
#COPY somedir/app.py /testdir


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
#COPY --from=nudgedimagesecond /testdir/* .

# Specify the command to run on container start
CMD [ "python", "./app.py" ]
