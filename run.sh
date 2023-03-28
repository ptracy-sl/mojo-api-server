#!/bin/sh
set -eux

exec /usr/bin/env perl -I. -Ilib ft_api.pl daemon -l http://\*:8080
