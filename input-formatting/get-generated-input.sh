#!/bin/sh

./a.out country < input/countries.in || exit
./a.out location < input/locations.in || exit
./a.out artist < input/artists.in || exit
./a.out group < input/groups.in || exit
./a.out group_member < input/group_members.in || exit
./a.out category < input/categories.in || exit
./a.out customer < input/customers.in || exit
./a.out job < input/jobs.in || exit
./a.out employee < input/employees.in || exit
./a.out subscription < input/subscriptions.in || exit
./a.out album < input/albums.in || exit
./a.out track < input/tracks.in || exit
./a.out copy < input/copies.in || exit
