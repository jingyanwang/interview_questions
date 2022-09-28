docker build -t jingyanwang1/spark:1.0.1 .

docker run -it ^
-p 0.0.0.0:6788:6788 ^
-p 0.0.0.0:4040:4040 ^
-p 0.0.0.0:6894:6894 ^
-v "C:\\Users\\jimwa\\Documents\\GitHub\\DataQuest-JW":"/code" ^
-v "C:\data\rovio":"/data" ^
jingyanwang1/spark:1.0.1 

http://localhost:6788/notebooks/code/jingyan_wang_churn_prediction_model.ipynb

############Dockerfile###########
FROM openjdk:8

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git 
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y tar

RUN apt-get install -y python3-dev
RUN apt-get install -y python3-pip

####flask
WORKDIR /

RUN pip3 install Flask==1.1.1
RUN pip3 install flask_restplus==0.13.0
RUN pip3 install Werkzeug==0.15.5
RUN pip3 install itsdangerous==1.1.0

EXPOSE 9000
WORKDIR /

###
RUN pip3 install pandas==1.1.4
RUN pip3 install pyspark==3.0.1

ENV PYSPARK_PYTHON=/usr/bin/python3
ENV PYSPARK_DRIVER_PYTHON=/usr/bin/python3

RUN pip3 install jinja2==2.10.1
RUN pip3 install MarkupSafe==1.1.1
RUN pip3 install jupyter

RUN echo "DSDGK"

CMD jupyter notebook --ip 0.0.0.0 --port 6788 --NotebookApp.token='' --no-browser --allow-root 

############Dockerfile###########