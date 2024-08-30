FROM quay.io/redhat-user-workloads/exd-rcerven-tenant/testnudging/test1:96b8100fbc7d72684726ec77802bfdfd3225582b AS nudgedimage

#RUN echo "nudged image"
#RUN mkdir /testdir
#COPY somedir/app.py /testdir
#
#FROM registry.access.redhat.com/ubi9/python-39:1-186.1720018722

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

#COPY --from=nudgeimage /testdir/* .

# Specify the command to run on container start
CMD [ "python", "./app.py" ]
