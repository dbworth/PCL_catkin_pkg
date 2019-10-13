## pcl_catkin_181

A catkin wrapper for PCL 1.8.1 (8 Aug 2017)  
This downloads and compiles the source code.  

Author: David Butterworth, 2018-2019.  
Based on a package by ETHZ-ASL, except this version automatically downloads the source and does not depend on other packages like `catkin_simple`.  


### Installation

This package was tested on Ubuntu 16.04 and 18.04  

(Optional) Enable GPU support using CUDA:  
Edit  
`cmake/ExternalProject_PCL_1.8.1.cmake`  
and enable  
`SET(_ENABLE_CUDA ON)`  

Copy this package into the `src` directory of your catkin workspace.  
Build your catkin workspace:  
e.g.  
Use `catkin build` from `catkin_tools`.  

Ignore the compiler warnings about deprecated PCL functions :-)  

### Usage

Check the `test_pcl` package for an example.  

