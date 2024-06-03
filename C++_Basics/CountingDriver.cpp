#include <iostream>
#include "Counting.h"
#include <fstream>
#include <vector>


int main()
{
	std::ifstream file("file.txt"); //read the input file and store it in file

    	std::vector<int> outputValues = FLLBAY001::count(file);

    	for (int r=0; r<outputValues.size(); r++){
        	std::cout<< outputValues.at(r);
        	std::cout<<" ";
    	}	
	
}
