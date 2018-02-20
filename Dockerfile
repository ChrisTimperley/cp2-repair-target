FROM ros:kinetic

# create docker user
ENV USER docker
RUN apt-get update \
 && apt-get install -y --no-install-recommends sudo \
 && useradd -ms /bin/bash "${USER}" \
 && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
 && adduser "${USER}" sudo \
 && apt-get clean \
 && mkdir -p "/home/${USER}" \
 && sudo chown -R "${USER}" "/home/${USER}" \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
USER "${USER}"
WORKDIR "/home/${USER}"

# install basic utilities
RUN sudo apt-get update && \
    sudo apt-get install -y vim wget curl

# use a ROS install file to create a workspace
WORKDIR /ros_ws
ADD pkgs.rosinstall /ros_ws/pkgs.rosinstall
RUN sudo chown -R ${USER} . && \
    wstool init -j8 /ros_ws/src /ros_ws/pkgs.rosinstall

# install system dependencies
# --ignore-src (what does this do?)
RUN rosdep update \
 && rosdep install -i -y -r --from-paths /ros_ws/src \
                        --ignore-src \
                        --skip-keys="python-rosdep python-catkin-pkg python-rospkg" \
                        --rosdistro="${ROS_DISTRO}" \
 && sudo apt-get clean \
 && sudo rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update && \
    sudo apt-get install -y python-catkin-tools

# fix: https://github.com/ros/geometry/issues/144
# fix: https://github.com/ros-drivers/freenect_stack/issues/36
# fix BFL includes
RUN cd /ros_ws/src/ros_comm/xmlrpcpp && \
    sed -i "s#INCLUDE_DIRS include#INCLUDE_DIRS include include/xmlrpcpp#" CMakeLists.txt && \
    cd /ros_ws/src/freenect_stack && \
    find . -type f -exec sed -i "s#libfreenect/libfreenect.h#libfreenect.h#g" "{}" \; && \
    find . -type f -exec sed -i "s#libfreenect/libfreenect_registration.h#libfreenect_registration.h#g" "{}" \; && \
    cd /ros_ws/src/navigation && \
    find . -type f -exec sed -i "s#<bfl/#<#g" {} \;

# build
RUN . "/opt/ros/${ROS_DISTRO}/setup.sh" && \
    mkdir logs && \
    catkin build
