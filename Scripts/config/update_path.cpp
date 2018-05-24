#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include <stdlib.h>
using namespace std;

#define LOCATION "paths"
#define OUTPUT_PATH "..\\__multipledir.bat"

class AliasPath{
    public:
    AliasPath(string a, string p){
        alias=a;
        path=p;
    }

    bool isValid(){
        return (alias.length() > 0 &&  path.length() > 0);
    }

    void print(){
        cout << ">> " +alias + " :: " + path << endl; 
    }

    string alias;
    string path;
};

vector<AliasPath> all;

int end_of_alias(string line){
    for(int i = 0; i < line.length(); i++){
        if(line[i] == ':') return i;
    }
    return -1;
}

int fillAliasPath(){
    ifstream input(LOCATION);
    if(!input){
        cout << "Cant locate path on " + string(LOCATION) << endl;
        return -1;
    }
    string line;
    string splitter = "::";
    while(getline(input, line)){
        if(line.length() > 0){
            string alias, path;
            int index = end_of_alias(line);
            if(index > 0){
                alias = line.substr(0,index);
                path = line.substr(index + splitter.length(), line.length());
                AliasPath t = AliasPath(alias,path);
                t.print();
                all.push_back(t);
            }
            else{
                cout << "Paths is not correctly formatted." << endl;
            }

        }
    }
    return 0;
}

string batCommand(AliasPath a){
    return "if %1 == " + a.alias + " (\n"+
        + "%2 " + a.path + "\ngoto :eof\n)\n";
}

int convertBAT(){
    ofstream myfile;
    myfile.open(OUTPUT_PATH);
    myfile << "@echo off\n";
    for(AliasPath a : all){
        myfile << batCommand(a);
    }
    myfile << "if %1 == . (\n	%2 .\n	goto :eof\n)\n";
    myfile << "echo Error. [ %2 ] not set for [ %1 ]\necho Jump set to ";
    for(AliasPath a : all){
        myfile << "["+a.alias+"]";
    }
    myfile << "\n";
    myfile.close();
    return 0;
}

int main(){
    int i = fillAliasPath();
    if( i == 0 ){
    convertBAT();
    }
}