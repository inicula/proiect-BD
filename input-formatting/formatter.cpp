#include <iostream>
#include "formats.h"

int main(int argc, const char* argv[])
{
        if(argc != 2)
        {
                fmt::print(stderr, "Pass only 1 cli argument, the type for"
                                   " which to format the input\n");
                return 1;
        }

        const std::string_view arg = argv[1];
        if(!ftable.contains(arg))
        {
                fmt::print(stderr, "Format for type '{}' not found.\n", arg);
                print_avail();
                return 1;
        }

        const auto func_ptr = ftable.at(arg);
        std::string line;
        while(std::getline(std::cin, line))
        {
                if(!line.empty() && line.front() != '#')
                {
                        func_ptr(split(line, ','));
                }
        }
}
