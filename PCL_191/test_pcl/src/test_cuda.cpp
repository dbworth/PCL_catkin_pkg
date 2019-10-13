
#include <iostream>

#include <pcl/cuda/point_types.h>
#include <pcl/gpu/octree/octree.hpp>

int main(int, char**)
{
    //std::cout << "PCL_VERSION: " << PCL_VERSION << std::endl; // e.g. 100702 or 100801
    std::cout << "PCL_VERSION_PRETTY: " << PCL_VERSION_PRETTY << std::endl; // e.g. 1.7.2

    const uint8_t r = 255, g = 0, b = 0; // Red color
    const int rgb = ((int)r) << 16 | ((int)g) << 8 | ((int)b); 

    pcl::cuda::PointXYZRGB point(1.0, 2.0, 3.0, rgb);

    std::cout << "pcl::cuda::PointXYZRGB: (" << point.x << ", " << point.y << ", " << point.z << ")" << std::endl;

    return 0;
}
