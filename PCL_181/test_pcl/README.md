## test_pcl

A catkin package containing tests to check if PCL (PointCloud Library) is installed correctly and that your ROS packages are linking to the correct version.  

### Usage:

Print the PCL version:  
`$ rosrun test_pcl print_version`  

Check if PCL was compiled with support for NVidia CUDA:  
Edit  
`CMakeLists.txt`  
enable  
`set(_TEST_CUDA ON)`  
and re-compile.  
`$ rosrun test_pcl test_cuda`  
