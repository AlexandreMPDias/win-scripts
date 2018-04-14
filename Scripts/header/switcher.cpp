#include "switcher.hpp"

#include <iostream>
#include <cstdlib>
#include <string>
#include <functional>
#include <vector>
#include <fstream>

using namespace std;

#ifndef SCRIPT_PATH_BIN
    cout << "SCRIPT_PATH_BIN not set" << endl;
#else
#ifndef PROJECT_PATH
    cout << "PROJECT_PATH not set" << endl;
#endif

constexpr unsigned int str2int(const char* str, int h = 0)
{
    return !str[h] ? 5381 : (str2int(str, h+1) * 33) ^ str[h];
}


string get_string(string path){
    string spb(SCRIPT_PATH_BIN);
    string proj(PROJECT_PATH);
    string s;
    if(path.length() == 0){
        cout << "Empty Path" << endl;
        return ".";
    }
    switch (str2int(path.c_str())){
        case str2int("."):    return ".";
        case str2int("root"):    return proj;
        case str2int("exp"):    return proj + "\\Experimenting";
        case str2int("script"): return spb + "\\..";
        default:                return proj+ "\\" + path;
    }
}

void insertWhen(string& str, char a, string b){
    vector<string> vec;
    string s = "";
    for(int i = 0 ; i < str.length(); i++){
        if(str[i] == a){
            vec.push_back(s);
            s = "";
        }
        else{
            s += str[i];
        }
    }
    s = vec.at(0);
    for(int i = 1; i < vec.size(); i++){
        s = s + b + vec.at(i);
    }
    str = s;
}

void runner(string cmd, string path){
    string p_path = get_string(path);
    p_path = "\"" + p_path + "\"";
    //cout << p_path << endl;
    string cmd2 = cmd + " " + p_path;
    //cout << cmd2 << endl;
    system(cmd2.c_str());
}

void run(int aa, char *bb[], std::string cmd){
    string s = ".";
    if(aa > 1){
        string a(bb[1]);
        s = a;
    }
    cout << to_string(aa) << endl;
    string p_path = get_string(s);
    p_path = "\"" + p_path + "\"";
    //cout << p_path << endl;
    string cmd2 = cmd + " " + p_path;
    //cout << cmd2 << endl;
    system(cmd2.c_str());
    return;
}

#endif


