#!/bin/bash
cd /ros_ws
source "/opt/ros/${ROS_DISTRO}/setup.bash"
source "/ros_ws/devel/setup.bash"
exec "$@"
