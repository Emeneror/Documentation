
.. contents::


|
|


############
Requirements
############

The following elements are required on the system to build vision modules :

.. code-block:: shell

  COMPILER="build-essential"
  REQUIRED="cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev"
  OPTIONAL="python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev"
  EMBEDDED="gcc-arm-linux-gnueabihf"


|
|


##################
I - Install OpenCV
##################

===================
1 - Desktop Install
===================

The following steps will install Opencv on your desktop.

  - it builds OpenCV 4.1.0 branch
  - it builds OpenCV contribs needed for ArUcO tags.

-----
Steps
-----

.. code-block:: shell

  cd vision/opncv-install/script  # go to script directory
  ./opencv_install.sh             # download and compile OpenCV for desktop

-----
Tests
-----

To test OpenCV install, run the following commands. It will loads an Image through OpenCV using ``Imread()`` function.

.. code-block:: shell

  cd vision/src/module/tests/4.1.0_samples/
  cd t_DisplayImage
  ./compile.sh


|


====================
2 - Embedded Install
====================

The following steps will build an embedded Opencv for raspberry-pi

.. TODO