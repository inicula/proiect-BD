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
                return 1;
        }

        std::string line;
        while(std::getline(std::cin, line))
        {
                if(line.empty() || line.front() == '#')
                {
                        continue;
                }

                const auto s = split(line, ',');
                print(arg, s);
        }
}
