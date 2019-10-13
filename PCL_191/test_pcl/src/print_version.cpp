
#include <iostream>
#include <pcl/point_types.h>

int main(int, char**)
{
    //std::cout << "PCL_VERSION: " << PCL_VERSION << std::endl; // e.g. 100702
    std::cout << "PCL_VERSION_PRETTY: " << PCL_VERSION_PRETTY << std::endl; // e.g. 1.7.2

    pcl::PointXYZ point(1.0, 2.0, 3.0);
    std::cout << "point: " << point << std::endl;

    return 0;
}
