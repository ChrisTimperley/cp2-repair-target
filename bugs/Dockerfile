FROM cmu-mars/cp2:base

ADD bug.diff /home/mars/catkin_ws
RUN cd /home/mars/catkin_ws/src \
 && patch -p0 < /home/mars/catkin_ws/bug.diff \
 && cd /home/mars/catkin_ws \
 && catkin build
