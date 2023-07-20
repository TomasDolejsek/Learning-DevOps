#!/usr/bin/env/bash

set -euo pipefail

function add() {
	echo $(( $1 + $2 ))
}

add $1 $2
