#!/bin/bash
cd "${ROS_WS}"
__argv=( "$@" )
set -- ""
. "/opt/ros/${ROS_DISTRO}/setup.bash"
. "${ROS_WS}/devel/setup.bash"
exec "${__argv}"
