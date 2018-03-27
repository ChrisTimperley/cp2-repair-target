#!/bin/bash
cd "${ROS_WS}"
# . "/opt/ros/${ROS_DISTRO}/setup.bash"
# . "${ROS_WS}/devel/setup.bash"
exec "$@"
