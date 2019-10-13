cmake_minimum_required(VERSION 2.8)
project(test_pcl)

# use C++11
#add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  #pcl_ros
  pcl_catkin_172
)

catkin_package()

include_directories(${catkin_INCLUDE_DIRS})

add_executable(print_version src/print_version.cpp)
target_link_libraries(print_version ${catkin_LIBRARIES})

