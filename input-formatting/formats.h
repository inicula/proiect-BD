#include <fmt/core.h>
#include "helper.h"
#include <unordered_map>

template<typename T>
using formatfunc_t = void (*)(const std::vector<T>&);

constexpr const char* fstr[] = {"insert into locations\nvalues ({}, '{}', '{}');\n\n",
                                "insert into customers\nvalues ({}, '{}');\n\n"};

template<typename... Args>
void print(const char* format_str, Args&&... args)
{
        fmt::print(format_str, args...);
}

namespace ftypes
{

void location(const auto& vec)
{
        print(fstr[0], vec[0], vec[1], vec[2]);
}

void customer(const auto& vec)
{
        print(fstr[1], vec[0], vec[1]);
}

} // namespace ftypes

const std::unordered_map<std::string_view, formatfunc_t<std::string_view>> ftable = {
    {"location", ftypes::location}, {"customer", ftypes::customer}};

void print(const std::string_view arg, const auto& vec)
{
        ftable.at(arg)(vec);
}
