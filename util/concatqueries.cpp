#include <iostream>
#include <fstream>
#include <string_view>
#include <filesystem>
#include <vector>

std::string_view trim(std::string_view filename)
{
        const auto slashpos = filename.rfind('/');
        if(slashpos != std::string_view::npos)
        {
                filename.remove_prefix(slashpos + 1);
        }
        return filename;
}

bool isnum(const std::string_view filename)
{
        if(filename.empty())
        {
                return false;
        }

        for(char c : filename)
        {
                if(!std::isdigit(c))
                {
                        return false;
                }
        }

        return true;
}

bool good(const std::string_view filename)
{
        const std::string_view trimmed = trim(filename);

        return std::filesystem::exists(filename) && trimmed.size() >= 4 &&
               std::string_view(trimmed.end() - 4, trimmed.end()) == ".sql" &&
               isnum(std::string_view(trimmed.begin(), trimmed.end() - 4));
}

int main(int argc, const char* argv[])
{
        std::vector<std::string_view> accepted;
        std::vector<std::string_view> discarded;

        for(int i = 1; i < argc; ++i)
        {
                if(good(argv[i]))
                {
                        accepted.push_back(argv[i]);
                }
                else
                {
                        discarded.push_back(argv[i]);
                        continue;
                }

                std::ifstream in(argv[i]);
                if(!in.good())
                {
                        discarded.push_back(argv[i]);
                        continue;
                }

                std::cout << in.rdbuf() << '\n';
        }

        std::cerr << "Accepted files:\n";
        for(auto sv : accepted)
        {
                std::cerr << sv << '\n';
        }

        std::cerr << "\nDiscarded files:\n";
        for(auto sv : discarded)
        {
                std::cerr << sv << '\n';
        }

        return 0;
}
