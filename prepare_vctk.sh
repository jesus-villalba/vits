#!/bin/bash

in_dir0=VCTK-Corpus/wav48
out_dir0=VCTK-Corpus/wav22

for in_dir in $(ls -d $in_dir0/*);
do
  out_dir=$(echo $in_dir | sed 's@'$in_dir0'@'$out_dir0'@')
  echo "$in_dir -> $out_dir"
  mkdir -p $out_dir
  for f in $(ls $in_dir | grep "wav$")
  do
    f_in=$in_dir/$f
    f_out=$out_dir/$f
    echo "----$f_in -> $f_out"
    sox $f_in -r 22050 $f_out
  done
done
