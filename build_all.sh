#!/usr/bin/env bash

# update the submodules: Caffe and Dense Flow
#git submodule update --remote


# install Dense_Flow dependencies
sudo apt-get -qq install libzip-dev

# install common dependencies: OpenCV
# adpated from OpenCV.sh
version="2.4.13"

echo "Building OpenCV" $version
[[ -d 3rd-party ]] || mkdir 3rd-party/
cd 3rd-party/

if [ ! -d "opencv-$version" ]; then
    echo "Installing OpenCV Dependenices"
    sudo apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils

    echo "Downloading OpenCV" $version
    wget -O OpenCV-$version.zip https://github.com/Itseez/opencv/archive/$version.zip

    echo "Extracting OpenCV" $version
    unzip OpenCV-$version.zip
fi

echo "Building OpenCV" $version
cd opencv-$version
[[ -d build ]] || mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D WITH_TBB=ON  -D WITH_V4L=ON ..
if make -j32 ; then
    cp lib/cv2.so ../../../
    echo "OpenCV" $version "built."
else
    echo "Failed to build OpenCV. Please check the logs above."
    exit 1
fi

# build dense_flow
cd ../../../

echo "Building Dense Flow"
cd lib/dense_flow
[[ -d build ]] || mkdir build
cd build
OpenCV_DIR=../../../3rd-party/opencv-$version/build/ cmake .. -DCUDA_USE_STATIC_CUDA_RUNTIME=OFF
if make -j ; then
    echo "Dense Flow built."
    echo "All tools built. Happy experimenting!"
else
    echo "Failed to build Dense Flow. Please check the logs above."
    exit 1
fi


