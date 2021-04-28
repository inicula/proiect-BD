#pragma once
#include <vector>
#include <string_view>

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
