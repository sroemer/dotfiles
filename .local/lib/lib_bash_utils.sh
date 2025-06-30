#!/bin/bash

###
# Logging to stdout via log() and stderr via error_log()
#
# Arguments:
#   error message
###
function info_log() {
  echo "INFO : $*"
}
function error_log() {
  echo -e "\e[1;31mERROR: $*\e[0m" >&2
}
function warn_log() {
  echo -e "\e[1;33mWARN : $*\e[0m"
}
function log() {
  info_log $*
}
