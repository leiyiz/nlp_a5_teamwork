#!/bin/bash
cd mt_classifier
if [[ -f mt_classifier.py && -f mt_classifier_predictor.py && -f mt_classifier_dataset_reader.py && -f ../mt_classifier_config.jsonnet && -f ../A5.pdf ]]
then
    echo "all expected files are found, start tar"
    cd ..
    tar -czvf A5.tgz mt_classifier/ A5.pdf mt_classifier_config.jsonnet
    echo "finish tar, saved to A5.tgz"
else
    echo "missing file/incorrect naming"
fi
