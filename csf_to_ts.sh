#!/bin/bash                                                                                                                                            

# how to write it out: ./csf_to_ts.sh -n $SUBJECT -d $PROJPATH -s func_stc -r csf.nii.gz
# nina fultz may 2021

#gets displayed when -h or --help is put in
display_usage(){
    echo "***************************************************************************************
Script for CSF to ts
*************************************************************************************** "
    echo Usage: ./csf_to_ts.sh -n -d
       -n: Name of subject
       -d: Home directory
       -s: slice_time file.nii
       -r: ROI name
}

if [ $# -le 1 ]
then
    display_usage
    exit 1
fi

while getopts "n:d:s:r:" opts;
do
    case $opts in
        n) export SUBJECT_NAME=$OPTARG ;;
        d) export PROJ_PATH=$OPTARG ;;
        s) export ST_FILE=$OPTARG ;;
        r) export ROI_NAME=$OPTARG ;;
    esac
done

export TS=$PROJ_PATH/$SUBJECT_NAME/ts
mkdir $TS
echo $TS

export LABELS=$PROJ_PATH/$SUBJECT_NAME/labels
mkdir $LABELS
echo $LABELS

export SUBJECT_DIR=$PROJ_PATH/$SUBJECT_NAME
echo $SUBJECT_DIR


#csf timeseries

fslmeants -i $SUBJECT_DIR/stcfsl/${ST_FILE}.nii.gz -m $SUBJECT_DIR/ROIs/$ROI_NAME -o $SUBJECT_DIR/ts/${ST_FILE}_csf_ts.txt


CSF_TS=$SUBJECT_DIR/ts/${ST_FILE}_csf_ts.txt
if [ -f $CSF_TS ]; then
     echo "${CSF_TS##*/} already exists! "
  echo "${CSF_TS##*/} csf to txt done! All done, have a lovely day! "
else
  echo "${CSF_TS##*/} csf to txt failed! "
fi
