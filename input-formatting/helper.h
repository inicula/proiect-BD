#pragma once
#include <vector>
#include <string>
#include <string_view>
#include <algorithm>

inline void ltrim(std::string& str)
{
        str.erase(str.begin(), std::find_if(str.begin(), str.end(),
                                            [](char c)
                                            {
                                                    return !std::isspace(c);
                                            }));
}

inline void rtrim(std::string& str)
{
        str.erase(std::find_if(str.rbegin(), str.rend(),
                               [](char c)
                               {
                                       return !std::isspace(c);
                               })
                      .base(),
                  str.end());
}

inline void trim(std::string& str)
{
        ltrim(str);
        rtrim(str);
}

template<typename Container>
inline std::enable_if_t<std::is_same_v<typename Container::value_type, std::string>>
trim(Container& c)
{
        for(auto& str : c)
        {
                trim(str);
        }
}

inline bool strcontains(std::string_view str, std::string_view target)
{
        return str.find(target) != std::string_view::npos;
}

inline bool strcontains(std::string_view str, char target)
{
        return str.find(target) != std::string_view::npos;
}

inline std::vector<std::string_view> split(const std::string_view s, const char delim = ' ')
{
        if(s.empty())
        {
                return {};
        }
        auto start = s.begin();
        std::vector<std::string_view> res;

        for(auto it = s.begin(); it != s.end(); ++it)
        {
                if(*it == delim)
                {
                        res.emplace_back(start, it);
                        start = it + 1;
                }
        }
        res.emplace_back(start, s.end());

        return res;
}
