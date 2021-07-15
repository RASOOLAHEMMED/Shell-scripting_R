#!/usr/bin/env bash

a=10
echo A=$a

## command subs
NO_OF_USERS=$(who | wc -l)
echo Number of users = $NO_OF_USERS