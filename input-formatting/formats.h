#include <fmt/core.h>
#include "helper.h"
#include <unordered_map>
#include <random>

std::string generate_serial_number()
{
        static constexpr char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        static constexpr unsigned serial_size = 8;
        static std::random_device rd;
        static std::mt19937 gen(rd());
        static std::uniform_int_distribution<unsigned> distrib(0, std::size(charset) - 2);

        std::string serial_number;
        serial_number.reserve(serial_size);
        for(unsigned i = 0; i < serial_size; ++i)
        {
                serial_number.push_back(charset[distrib(gen)]);
        }

        return serial_number;
}

template<typename T>
using formatfunc_t = void (*)(const std::vector<T>&);

constexpr const char* fstr[] = {
    "insert into locations\nvalues ({}, '{}', {});\n\n",
    "insert into customers\nvalues ({}, '{}', '{}', '{}');\n\n",
    "insert into copies\nvalues ({}, {}, '{}', {}, {});\n\n",
    "insert into categories\nvalues ({}, '{}');\n\n",
    "insert into groups\nvalues ({}, '{}');\n\n",
    "insert into tracks\nvalues ({}, {}, '{}', {});\n\n",
    "insert into jobs\nvalues ({}, '{}', {}, {});\n\n",
    "insert into employees\nvalues ({}, '{}', '{}', {}, '{}', {});\n\n",
    "insert into artists\nvalues (seq_artist_id.nextval, '{}', '{}', '{}', '{}', {});\n\n",
    "insert into albums\nvalues ({}, '{}', '{}', {}, {});\n\n",
    "insert into subscriptions\nvalues ({}, {}, {}, '{}');\n\n",
    "insert into group_members\nvalues ({}, {}, '{}');\n\n",
    "insert into countries\nvalues ({}, '{}');\n\n"

};

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
        print(fstr[1], vec[0], vec[1], vec[2], vec[3]);
}

void copy(const auto& vec)
{
        print(fstr[2], vec[0], vec[1], generate_serial_number(), vec[2], vec[3]);
}

void category(const auto& vec)
{
        print(fstr[3], vec[0], vec[1]);
}

void group(const auto& vec)
{
        print(fstr[4], vec[0], vec[1]);
}

void track(const auto& vec)
{
        print(fstr[5], vec[0], vec[1], vec[2], vec[3], vec[4]);
}

void job(const auto& vec)
{
        print(fstr[6], vec[0], vec[1], vec[2], vec[3]);
}

void employee(const auto& vec)
{
        print(fstr[7], vec[0], vec[1], vec[2], vec[3], vec[4], vec[5]);
}

void artist(const auto& vec)
{
        print(fstr[8], vec[0], vec[1], vec[2], vec[3], vec[4]);
}

void album(const auto& vec)
{
        print(fstr[9], vec[0], vec[1], vec[2], vec[3], vec[4]);
}

void subscription(const auto& vec)
{
        print(fstr[10], vec[0], vec[1], vec[2], vec[3], vec[4]);
}

void group_member(const auto& vec)
{
        print(fstr[11], vec[0], vec[1], vec[2]);
}

void country(const auto& vec)
{
        print(fstr[12], vec[0], vec[1]);
}

} // namespace ftypes

const std::unordered_map<std::string_view, formatfunc_t<std::string_view>> ftable = {
    {"location",     ftypes::location},
    {"customer",     ftypes::customer},
    {"copy",         ftypes::copy},
    {"category",     ftypes::category},
    {"group",        ftypes::group},
    {"track",        ftypes::track},
    {"job",          ftypes::job},
    {"employee",     ftypes::employee},
    {"artist",       ftypes::artist},
    {"album",        ftypes::album},
    {"subscription", ftypes::subscription},
    {"group_member", ftypes::group_member},
    {"country",      ftypes::country}
};

void print_avail()
{
        fmt::print(stderr, "Available formats:\n");

        unsigned k = 1;
        for(const auto& [type, fptr] : ftable)
        {
                fmt::print(stderr, "{}. {}\n", k++, type);
        }
}
