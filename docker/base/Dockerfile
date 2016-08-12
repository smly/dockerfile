FROM ubuntu:16.04
MAINTAINER Kohei <i@ho.lc>

# Install dependent packages via apt-get
RUN apt-get -y update &&\
    echo ">>>>> packages for building python" &&\
    apt-get --no-install-recommends -y install \
      g++ \
      libsqlite3-dev \
      libssl-dev \
      libreadline-dev \
      libncurses5-dev \
      lzma-dev \
      liblzma-dev \
      libbz2-dev \
      libz-dev \
      libgdbm-dev \
      build-essential \
      cmake \
      make \
      wget \
      unzip \
      &&\
    echo ">>>>> packages for building python packages" &&\
    apt-get --no-install-recommends -y install \
      libblas-dev \
      liblapack-dev \
      libpng-dev \
      libfreetype6-dev \
      pkg-config \
      ca-certificates \
      libhdf5-serial-dev \
      &&\
    echo ">>>>> packages for building OpenCV3" &&\
    apt-get --no-install-recommends -y install \
      git \
      libjpeg8-dev \
      libtiff5-dev \
      libjasper-dev \
      libpng12-dev \
      libavcodec-dev \
      libavformat-dev \
      libswscale-dev \
      libv4l-dev \
      libatlas-base-dev \
      gfortran \
      &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# Python 3.6.0a2
RUN PYTHON3_URL="https://www.python.org/ftp/python/3.6.0/Python-3.6.0a2.tgz" &&\
    PYTHON3_PATH="/opt/python-3.6.0a2" &&\
    CXX="/usr/bin/g++" &&\
    mkdir -p /opt &&\
    cd /opt &&\
    wget -q --no-check-certificate $PYTHON3_URL -O python.tgz &&\
    tar xf python.tgz &&\
    cd Python-3.6.0a2 &&\
    ./configure \
        --prefix=/usr \
        --enable-shared \
        --with-system-ffi \
        --with-ensurepip &&\
    make &&\
    make install &&\
    cd /opt &&\
    rm -rf /opt/python.tgz /opt/Python-3.6.0a2

# OpenCV3
RUN OPENCV_URL="https://github.com/opencv/opencv/archive/3.1.0.tar.gz" &&\
    OPENCV_CONTRIB_URL="https://github.com/opencv/opencv_contrib/archive/3.1.0.tar.gz" &&\
    cd /opt &&\
    wget -q --no-check-certificate $OPENCV_URL -O opencv.tgz &&\
    wget -q --no-check-certificate $OPENCV_CONTRIB_URL -O opencv_contrib.tgz &&\
    tar zxf opencv.tgz &&\
    tar zxf opencv_contrib.tgz &&\
    rm opencv.tgz opencv_contrib.tgz &&\
    mkdir /opt/opencv-3.1.0/build &&\
    cd /opt/opencv-3.1.0/build &&\
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D INSTALL_C_EXAMPLES=OFF \
          -D INSTALL_PYTHON_EXAMPLES=ON \
          -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-3.1.0/modules \
          -D BUILD_EXAMPLES=ON .. &&\
    echo 'find_package(HDF5)' >> ../modules/python/common.cmake &&\
    echo 'include_directories(${HDF5_INCLUDE_DIRS})' >> ../modules/python/common.cmake &&\
    make -j4 &&\
    make install &&\
    ldconfig &&\
    ln -s /usr/local/lib/python3.6/site-packages/cv2.*.so \
          /usr/lib/python3.6/site-packages/cv2.so

# XGBoost
RUN XGBOOST_URL="https://github.com/dmlc/xgboost/archive/0.47.tar.gz" && \
    XGBOOST_PATH="/opt/xgboost-0.47" && \
    XGBOOST_FILE="xgboost.tgz" && \
    cd /opt && \
    wget -q --no-check-certificate $XGBOOST_URL -O $XGBOOST_FILE && \
    tar zxvf $XGBOOST_FILE && rm $XGBOOST_FILE && cd $XGBOOST_PATH && \
    \
    make -j4 &&\
    ln -s $XGBOOST_PATH/xgboost /usr/local/bin/xgboost

# RGF
RUN RGF_URL="http://stat.rutgers.edu/home/tzhang/software/rgf/rgf1.2.zip" &&\
    RGF_FILE="rgf1.2.zip" &&\
    cd /opt &&\
    wget -q --no-check-certificate $RGF_URL -O $RGF_FILE &&\
    echo "753237be5e2ec97f5627c1a0efeb5562caf4f455b3c0114d44bc5bf12595f0a5  rgf1.2.zip" | sha256sum -c - &&\
    unzip $RGF_FILE &&\
    cd rgf1.2 &&\
    \
    make -j4 &&\
    ln -s /opt/rgf1.2/bin/rgf /usr/local/bin/rgf

# LibFM
RUN LIBFM_URL="http://www.libfm.org/libfm-1.42.src.tar.gz" &&\
    LIBFM_FILE="libfm-1.42.src.tar.gz" &&\
    cd /opt &&\
    wget -q --no-check-certificate $LIBFM_URL -O $LIBFM_FILE &&\
    echo "6aaa2503aa1e6da7d08dd86bcf0907ee480f223547ca3b3d08c8f404f7f31695  libfm-1.42.src.tar.gz" | sha256sum -c - &&\
    tar zxf $LIBFM_FILE &&\
    cd libfm-1.42.src &&\
    \
    make -j4 &&\
    ln -s /opt/bin/libFM /usr/local/bin/libFM

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

