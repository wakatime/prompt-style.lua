#!/usr/bin/env bash
set -e
cd "$(dirname "$(dirname "$(readlink -f "$0")")")"

. ./lua51/bin/activate &&
  luarocks install ldoc &&
  ldoc .
