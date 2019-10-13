cmake_minimum_required(VERSION 2.8)
project(pcl_catkin_181)

find_package(catkin REQUIRED)

find_package(Boost REQUIRED COMPONENTS system filesystem thread)

#find_package(Eigen REQUIRED)
find_package(Eigen3 REQUIRED)

message("EIGEN3_INCLUDE_DIRS = " ${EIGEN3_INCLUDE_DIRS})

# Execute catkin_package_xml()
# This sets the 'CATKIN_GLOBAL_***' variables.
if(NOT _CATKIN_CURRENT_PACKAGE)
  catkin_package_xml()
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

message("\nDownloading & compiling PCL source ... \n")

include(ExternalProject_PCL_1.8.1)

install(DIRECTORY ${CATKIN_DEVEL_PREFIX}/include/pcl
        DESTINATION ${CATKIN_GLOBAL_INCLUDE_DESTINATION}
        FILES_MATCHING PATTERN "*.h"
                       PATTERN "*.hpp"
                       PATTERN ".svn" EXCLUDE)

catkin_package(INCLUDE_DIRS ${_PCL_CATKIN_INCLUDE_DIR}
               DEPENDS EIGEN3
               LIBRARIES pcl_common
                         pcl_features
                         pcl_filters
                         pcl_io
                         pcl_kdtree
                         pcl_keypoints
                         pcl_octree
                         pcl_outofcore
                         #pcl_people
                         pcl_recognition
                         pcl_registration
                         pcl_sample_consensus
                         pcl_search
                         pcl_segmentation
                         pcl_surface
                         #pcl_tracking
                         pcl_visualization)
