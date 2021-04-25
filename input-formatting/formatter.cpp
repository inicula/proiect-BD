#include <iostream>
#include "formats.h"

int main(int argc, const char* argv[])
{
        if(argc != 2)
        {
                std::cerr
                    << "Pass only 1 cli argument, the type for which to format the input.\n";
                return 1;
        }

        const std::string_view arg = argv[1];
        if(!ftable.contains(arg))
        {
                std::cerr << "Format for type '" << arg << "' not found.\n";
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
