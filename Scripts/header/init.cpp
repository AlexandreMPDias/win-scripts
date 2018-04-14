#include "switcher.hpp"
#include <iostream>
using namespace std;

int main(int argc, char* argv[]){
    run(argc, argv, "cd");
    if(argc == 2){
        string s(argv[2]);
        s = "workon " + s;
        system(s.c_str());
    }
}