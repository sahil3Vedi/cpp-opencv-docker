FROM gcc:11.2
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN apt-get update && apt-get upgrade
RUN apt-get install -y build-essential
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN apt-get -y install python-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
RUN apt-get -y install vim
RUN git clone https://github.com/opencv/opencv.git
RUN mkdir opencv/build
WORKDIR /usr/src/myapp/opencv
RUN git checkout -b 4.1.2
WORKDIR /usr/src/myapp/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_GENERATE_PKGCONFIG=ON -D BUILD_EXAMPLES=ON ..
RUN make -j8
RUN make install
WORKDIR /usr/src/myapp
