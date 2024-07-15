#!/bin/sh
tofi-run "$@" | ${SHELL:-"/bin/sh"} &
