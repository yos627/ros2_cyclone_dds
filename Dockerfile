ARG ROS_DISTRO=humble

# Use ros-base
FROM ros:${ROS_DISTRO}-ros-base

# Set workspace variable
ENV WS=/home/certis/ros2_ws
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
ENV ROS_DOMAIN_ID=2

# Set shell explicitly
SHELL ["/bin/bash", "-c"]

# Install system dependencies in one layer for efficiency
# NOTE: Added ros-humble-opencv-system for better library support.
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    libgl1 \
#    ros-${ROS_DISTRO}-opencv-system \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install opencv-python

# Set working directory
WORKDIR ${WS}

# Copy the entire source directory into the container's src/
# ASSUMPTION: Your ROS 2 package is located in a local 'src/' folder.
#COPY <your_package>/ src/<your_package>

# Build the workspace
# No need for 'sed' here. The CMD will handle sourcing.
RUN source /opt/ros/${ROS_DISTRO}/setup.bash \
    && colcon build \
    && sed -i '$isource "${WS}/install/setup.bash"' /ros_entrypoint.sh

# Default command to run when the container starts.
# It sources the local workspace and then runs the node.
# The base image automatically prepends /ros_entrypoint.sh to this CMD.
#CMD ["/bin/bash", "-c", "source install/setup.bash && ros2 run camera_publisher camera_publisher_node"]
CMD ["/bin/bash", "-c", "source install/setup.bash"]
