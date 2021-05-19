#!/bin/bash

declare -a arr=("first_name", "last_name", "date_birth",
                "date_death", "birth_location_id", "group_id",
                "member_id", "left_group_date", "release_date",
                "category_id", "album_id")

for i in "${arr[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
done
