cmake_minimum_required(VERSION 2.8)
project(test_pcl)

# use C++11
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  #pcl_ros
  pcl_catkin_191
)

catkin_package()

include_directories(${catkin_INCLUDE_DIRS})

add_executable(print_version src/print_version.cpp)
target_link_libraries(print_version ${catkin_LIBRARIES})

set(_TEST_CUDA OFF)

if(_TEST_CUDA)
    find_package(CUDA 6.0 REQUIRED)
    message("Found CUDA ${CUDA_VERSION_STRING} at ${CUDA_TOOLKIT_ROOT_DIR}")
    message("CUDA_INCLUDE_DIRS = " ${CUDA_INCLUDE_DIRS})

    add_executable(test_cuda src/test_cuda.cpp)
    target_link_libraries(test_cuda ${catkin_LIBRARIES}
                                    ${CUDA_LIBRARIES})
    target_include_directories(test_cuda PRIVATE ${CUDA_INCLUDE_DIRS})
endif()
