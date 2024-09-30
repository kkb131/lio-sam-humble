git clone --recursive --branch humble https://github.com/rsasaki0109/li_slam_ros2

# Allow X server to be accessed from the local machine
xhost +local:

# Container name
CONTAINER_NAME="lio_sam_humble2"

# Run the Docker container
docker run --privileged -itd \
        --gpus all \
        -e NVIDIA_DRIVER_CAPABILITIES=all \
        -e NVIDIA_VISIBLE_DEVICES=all \
        --volume=/home/ys/Downloads/bag_data:/root/data \
        --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
        --volume=/etc/localtime:/etc/localtime:ro \
        --volume=/dev:/dev \
        --device=/dev/dri \
        --net=host \
        --ipc=host \
        --name="$CONTAINER_NAME" \
        --env="DISPLAY=$DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        -w /root/catkin_ws/ \
        -v $(realpath ./li_slam_ros2):/root/catkin_ws/src/li_slam_ros2 \
        lio-sam-humble2
