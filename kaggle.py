#!/usr/bin/env python3

import argparse


def main(args):
    with open(args.tsv_file) as f:
        id = 0
        kaggle_file = open(args.output_file, 'w')
        print('Id,Category', file=kaggle_file)
        for line in f:
            inputs = line.rstrip().split('\t')
            label = inputs[2]
            print(str(id) + ',' + label, file=kaggle_file)
            id += 1
    kaggle_file.close()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('tsv_file',
            help='The input TSV generated by the AlleNLP predictor.')
    parser.add_argument('output_file',
            help='Where to output the Kaggle-ready CSV.')
    args = parser.parse_args()
    main(args)