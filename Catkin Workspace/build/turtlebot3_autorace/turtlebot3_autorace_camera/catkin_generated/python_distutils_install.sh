#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/mstbc/Desktop/mstbc/src/turtlebot3_autorace/turtlebot3_autorace_camera"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/mstbc/Desktop/mstbc/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/mstbc/Desktop/mstbc/install/lib/python2.7/dist-packages:/home/mstbc/Desktop/mstbc/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/mstbc/Desktop/mstbc/build" \
    "/usr/bin/python2" \
    "/home/mstbc/Desktop/mstbc/src/turtlebot3_autorace/turtlebot3_autorace_camera/setup.py" \
     \
    build --build-base "/home/mstbc/Desktop/mstbc/build/turtlebot3_autorace/turtlebot3_autorace_camera" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/mstbc/Desktop/mstbc/install" --install-scripts="/home/mstbc/Desktop/mstbc/install/bin"
