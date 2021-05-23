#include <fmt/core.h>
#include <fstream>
#include <string>
#include <iostream>

int main(const int argc, const char* argv[])
{
        for(int i = 1; i < argc; ++i)
        {
                std::ifstream in(argv[i]);

                int count = 0;
                std::string line;
                while(std::getline(in, line))
                {
                        count += (!line.empty() && line.front() != '#');
                }

                fmt::print("input file '{}': {} entries\n", argv[i], count);
        }
}
