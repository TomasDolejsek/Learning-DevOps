#!usr/bin/env/bash

echo "Basic math"
echo $(( 10*5+15 ))
echo $(( 40/6 ))

echo
echo "Using variables"
val1=$(( 10*3-15))
echo $val1
echo $(( val1 *= 3 ))


echo
echo "Using bc"
bc <<< "10 < 1"
bc <<< "10 != 11"
bc <<< "!5"
bc <<< "!0"

echo
echo "Using math library"
bc -l <<< "sqrt(9)"
bc -l <<< "l(45)"
bc -l <<< "scale=3; l(e(2))"

echo
echo "base conversions"
bc -l <<< "ibase=2; 101"
bc -l <<< "obase=2; 73"

