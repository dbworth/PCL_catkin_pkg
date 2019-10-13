#
# PCL 1.8.1
#

SET(_PCL_CXX_FLAGS "${_PCL_CXX_FLAGS} -std=c++11")

# Enable GPU and CUDA support
SET(_ENABLE_CUDA OFF)

set(_PCL_CATKIN_INCLUDE_DIR ${CATKIN_DEVEL_PREFIX}/include/pcl-1.8)

file(MAKE_DIRECTORY ${CATKIN_DEVEL_PREFIX}/include)
file(MAKE_DIRECTORY ${_PCL_CATKIN_INCLUDE_DIR})

# PCL uses -march=native which can be dangerous to use together with Eigen 3.3
# as this can introduce different vectorization settings in different parts
# of the code. So we manually set the compiler flags here to avoid this issue.
include(pcl_find_sse)

# Flags that PCL defines by default:
# http://github.com/PointCloudLibrary/pcl/blob/master/CMakeLists.txt#L112
SET(_PCL_CXX_FLAGS "-Wall -Wextra -Wno-unknown-pragmas -fno-strict-aliasing -Wno-format-extra-args -Wno-sign-compare -Wno-invalid-offsetof -Wno-conversion -DBOOST_UUID_RANDOM_GENERATOR_COMPAT ${SSE_FLAGS} -Wabi")

# Suppress warnings:
#  - Deprecated pcl::SAC_SAMPLE_SIZE in PCL sample_consensus.
#  - Multi-line comment using in VTK Math.
SET(_PCL_CXX_FLAGS "${_PCL_CXX_FLAGS} -Wno-comment -Wdeprecated-declarations")

if(NOT CMAKE_BUILD_TYPE)
  MESSAGE(FATAL_ERROR "CMAKE_BUILD_TYPE must not be empty!")
endif()
string(TOUPPER ${CMAKE_BUILD_TYPE} _UC_BUILD_TYPE)

# Add PCL CXX_FLAGS to CXX_FLAGS_RELWITHDEBINFO
SET(_PCL_CXX_FLAGS_${_UC_BUILD_TYPE} "${CMAKE_CXX_FLAGS_${_UC_BUILD_TYPE}} ${_PCL_CXX_FLAGS}")

SET(_PCL_SRC_PATH "pcl_src")
SET(_PCL_BUILD_PATH "pcl_build")
ExternalProject_Add(pcl_src
  URL https://github.com/PointCloudLibrary/pcl/archive/pcl-1.8.1.zip
  URL_MD5 d6a98ffadc89bd8fc7fadf8c6bff62ff
  UPDATE_COMMAND ""
  SOURCE_DIR ${_PCL_SRC_PATH}
  BINARY_DIR ${_PCL_BUILD_PATH}
  PATCH_COMMAND patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/patches/add-support-for-cuda-9-and-10.patch &&
                patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/patches/Fix-some-CUDA-9-related-errors.patch &&
                patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/patches/Supressed-deprecation-warnings.patch &&
                patch -p1 < ${CMAKE_CURRENT_SOURCE_DIR}/patches/Fix-compilation-issues-in-CUDA-9.1.patch
  CONFIGURE_COMMAND cd ../${_PCL_BUILD_PATH} && cmake
    -DCMAKE_INSTALL_PREFIX=${CATKIN_DEVEL_PREFIX}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_CXX_FLAGS=${_PCL_CXX_FLAGS}
    -DCMAKE_CXX_FLAGS_${_UC_BUILD_TYPE}=${_PCL_CXX_FLAGS_${_UC_BUILD_TYPE}}
    -DPCL_SHARED_LIBS=TRUE
    -DBUILD_2d=ON
    -DBUILD_apps=OFF
    -DBUILD_common=ON
    -DBUILD_examples=OFF
    -DBUILD_features=ON
    -DBUILD_filters=ON
    -DBUILD_geometry=ON
    -DBUILD_global_tests=OFF
    -DBUILD_io=ON
    -DBUILD_kdtree=ON
    -DBUILD_keypoints=ON
    -DBUILD_ml=ON
    -DBUILD_octree=ON
    -DBUILD_outofcore=ON
    -DBUILD_people=OFF
    -DBUILD_recognition=ON
    -DBUILD_registration=ON
    -DBUILD_sample_consensus=ON
    -DBUILD_search=ON
    -DBUILD_segmentation=ON
    -DBUILD_simulation=ON
    -DBUILD_stereo=ON
    -DBUILD_surface=ON
    -DBUILD_surface_on_nurbs=OFF
    -DBUILD_tools=ON
    -DBUILD_tracking=OFF
    -DBUILD_visualization=ON
    -DBUILD_GPU=${_ENABLE_CUDA}
    -DBUILD_CUDA=${_ENABLE_CUDA}
    -DWITH_CUDA=${_ENABLE_CUDA}
    -DWITH_DAVIDSDK=OFF
    -DWITH_DOCS=OFF
    -DWITH_DSSDK=OFF
    -DWITH_ENSENSO=OFF
    -DWITH_FZAPI=OFF
    -DWITH_LIBUSB=OFF
    -DWITH_OPENGL=OFF
    -DWITH_OPENNI=OFF
    -DWITH_OPENNI2=OFF
    -DWITH_PCAP=OFF
    -DWITH_PNG=OFF
    -DWITH_QHULL=ON
    -DWITH_QT=OFF
    -DWITH_RSSDK=OFF
    -DWITH_VTK=ON ../${_PCL_SRC_PATH}
  BUILD_COMMAND cd ../${_PCL_BUILD_PATH} && make -j8
  INSTALL_COMMAND cd ../${_PCL_BUILD_PATH} && make install -j8
)
