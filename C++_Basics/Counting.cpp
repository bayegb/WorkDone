#include <iostream>   //a system header file - needed to do simple I/O
#include "Counting.h"	         // header file - contains declaration of count()
#include <string>      
#include <vector>      
#include <sstream>     //to use stringstream 
#include <fstream>     //to manipulate txt files


namespace FLLBAY001 {
std::vector<int> count(std::ifstream& inputFile) 
{
	int i=0; //number of individual characters
	int z=0; //number of words
	int y=0; //number of spacial characters
	int l=0; //number of lines
	std::string line;
	std::vector<int> results;
    	std::string word;

	while (getline(inputFile, line)){
        l++;
        std::stringstream stream(line); //stream of words

		while (stream >> word){ //read a word from the string(stream) and place it in the word variable

			if (word.length()==1){ //for single characters
                		if( int(word.at(0))>=48 && 57>=int(word.at(0)) ){ // 0-9
                    			i++;
					z++;
					break;

                		}if ( int(word.at(0))>=65 && 90>=int(word.at(0)) ){ //A-Z
                    			i++;
                    			z++;
                    			break;

                		}if ( int(word.at(0))>=97 && 122>=int(word.at(0)) ){ //a-z
                    			i++;
                    			z++;
                    			break;

                		} else {
                    			y++;
                    			break;

                        	}
                	}

		//loop through the word
		for (int x=0; x< word.length(); x++) {

			// at()- access character at x , int()-casting character into an integer produces ascii value

			if( int(word.at(x))>=48 && 57>=int(word.at(x)) ){ // 0-9
				i++;

			}if ( int(word.at(x))>=65 && 90>=int(word.at(x)) ){ //A-Z
				i++;

			}if ( int(word.at(x))>=97 && 122>=int(word.at(x)) ){ //a-z
				i++;

			} else {
                    		y++;

			}
		}

		
		if (y>0 && i==0){
                	y=0; //prepare variable for next word

		} else { // word has no special characters
                	z++;
                	y=0; //prepare variable for next word
		}

		}

	}

	results = {l,z,i};

	return results;


}
}
