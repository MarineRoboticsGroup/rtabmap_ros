FROM ros:melodic-perception
USER root



# Install build dependencies
RUN apt-get update && \
    apt-get install -y ros-melodic-rtabmap ros-melodic-rtabmap-ros && \
    apt-get remove -y ros-melodic-rtabmap ros-melodic-rtabmap-ros

# g2o from source
RUN git clone https://github.com/RainerKuemmerle/g2o.git && \
     cd g2o && \
     mkdir build && cd build && \
     cmake -DBUILD_WITH_MARCH_NATIVE=OFF -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF -DG2O_USE_OPENGL=OFF .. && \
     make -j4 && \
     make install

# GTSAM
RUN cd ~ && \
     git clone --branch 4.0.0 https://github.com/borglab/gtsam.git && \
     cd ~/gtsam/ && \
     mkdir build && \
     cd build && \
     cmake -DGTSAM_USE_SYSTEM_EIGEN=ON -DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF -DGTSAM_BUILD_UNSTABLE=ON .. && \
     make check -j4 && \
     make install -j4

RUN cd ~ && \
     git clone https://github.com/MarineRoboticsGroup/rtabmap.git rtabmap && \
     cd ~/rtabmap && \
     git checkout feat/match_other_kf && \
     mkdir build && \
     cd ~/rtabmap/build && \
     cmake .. && \
     make -j4 && \
     make install

RUN cd ~ && \
   apt-get install -y ros-melodic-catkin && \
   apt-get install -y cmake python-catkin-pkg python-empy python-nose python-setuptools libgtest-dev build-essential python-catkin-tools

WORKDIR ~
