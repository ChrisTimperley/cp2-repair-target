#!/bin/bash
cd "${ROS_WS}"
# # copy $@
# __args=("$@")
#
# # clear $@
# CATKIN_SETUP_UTIL_ARGS=--extend
# set --

# WHY DOES THIS BREAK THINGS?
. "/opt/ros/${ROS_DISTRO}/setup.sh"
. "${ROS_WS}/devel/setup.sh"

exec "$@"
# exec "${__args[@]}"
