#!/bin/bash

set -e

# check argument
if [[ -z $1 || ! $1 =~ [[:digit:]]x[[:digit:]] ]]; then
  echo "ERROR: This script requires 1 argument, \"input dimension\" of the YOLO model."
  echo "The input dimension should be {width}x{height}".
  exit 1
fi

if which python3 > /dev/null; then
  PYTHON=python3
else
  PYTHON=python
fi

echo "** Install requirements"
# "gdown" is for downloading files from GoogleDrive
pip3 install --user gdown > /dev/null
pip3 install --upgrade gdown > /dev/null

# make sure to download dataset files to "yolov4_crowdhuman/data/raw/"
mkdir -p $(dirname $0)/raw
pushd $(dirname $0)/raw > /dev/null

get_file()
{
  # do download only if the file does not exist
  if [[ -f $2 ]];  then
    echo Skipping $2
  else
    echo Downloading $2...
    python3 -m gdown.cli $1
  fi
}

echo "** Download dataset files"
# train set
gdown https://drive.google.com/uc?id=1YH6GRiicbvCmEzH1DJG9YDyI48QO66Vw
gdown https://drive.google.com/uc?id=1jpBn27IxgVFTWraIqeHddqHU_5Z_wWGj
gdown https://drive.google.com/uc?id=1UX0Q0-yhlKaCJkrpRbB5Fz7uAYAR-sej
# val set
gdown https://drive.google.com/uc?id=1oBIV33q9d2xg0XwSb6hRWYuVPFyMhCCr
# .odgt files
gdown https://drive.google.com/uc?id=1EvdshfVnj91NniHgAkCrNEBL9nm9XIKD
gdown https://drive.google.com/uc?id=1UFXXygn0yKbBrPvhbpcANS5O0SptAg8n

# unzip image files (ignore CrowdHuman_test.zip for now)
echo "** Unzip dataset files"
for f in CrowdHuman_train01.zip CrowdHuman_train02.zip CrowdHuman_train03.zip CrowdHuman_val.zip ; do
  unzip -n ${f}
done

echo "** Create the crowdhuman-$1/ subdirectory"
rm -rf ../crowdhuman-$1/
mkdir ../crowdhuman-$1/
ln Images/*.jpg ../crowdhuman-$1/

# the crowdhuman/ subdirectory now contains all train/val jpg images

echo "** Generate yolo txt files"
cd ..
${PYTHON} gen_txts.py $1

popd > /dev/null

echo "** Done."
