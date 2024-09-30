FROM osrf/ros:humble-desktop-full

SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y ros-humble-robot-localization \
    && apt-get install -y ros-humble-robot-state-publisher \
    && rm -rf /var/lib/apt/lists/*

RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:borglab/gtsam-release-4.1 \
    && apt-get update \
    && apt install -y libgtsam-dev libgtsam-unstable-dev

RUN mkdir -p ~/catkin_ws/src \
    && cd ~/catkin_ws/src \
    && git clone --recursive --branch humble https://github.com/rsasaki0109/li_slam_ros2 \
    && mv /opt/ros/humble/include/pcl_conversions/pcl_conversions/pcl_conversions.h /opt/ros/humble/include/pcl_conversions/pcl_conversions.h 
RUN cd ~/catkin_ws \
    && rosdep update \
    && source /opt/ros/humble/setup.bash \
    && rosdep install --from-paths src --ignore-src -yr \
    && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc \
    && echo "source /root/catkin_ws/install/setup.bash" >> /root/.bashrc

WORKDIR /root/catkin_ws
