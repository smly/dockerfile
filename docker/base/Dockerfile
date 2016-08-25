FROM smly/base0
MAINTAINER Kohei <i@ho.lc>

# python packags
COPY requirements.txt /opt/requirements.txt
COPY requirements_part2.txt /opt/requirements_part2.txt
RUN pip3 install --upgrade pip &&\
    pip3 install -r /opt/requirements.txt &&\
    pip3 install -r /opt/requirements_part2.txt

# python binding for xgboost
RUN cd /opt/xgboost-0.47/python-package &&\
    python3 setup.py install

# TODO: LibFFM
# TODO: GIS related packages
# * GDAL, gdal-bin, ogr2ogr, GEOS
# * basemap descaretes Shapely

# Google SDK, Amazon
RUN pip3 install awscli &&\
    curl https://sdk.cloud.google.com | bash &&\
    pip3 install psycopg2
    pip3 install google-api-python-client

