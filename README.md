Implementation of No-Reference (NR) Point Cloud Quality Assessment Method [1].

# How to use

## Dataset download

This repository does not provide a dataset. 
When you test this sourcecode with the BASICS (Broad Quality Assessment of Static Point Clouds in a Compression Scenario) dataset [2], the point clouds can be downloaded from the URL: https://zenodo.org/records/10533088.

## Calculation of 9 types of features

9 types of features must be calculated before training and evaluation as follows: 

```bash
Run FeatureCalc_BASICStraining.m 
Run FeatureCalc_BASICStest.m
```

After the calculation, "Feature_BASICStraining.csv" and "Feature_BASICStest.csv" are output in "Feature" folder (These csv files have already been prepared by authors in this repository). 

## Training and test by support vector regression

After calculating the scores, training a support vector regression model and the evaluation are carried out by the following code.

```bash
Run TrainingSVRModel.m
```

# Reference

[1] R. Watanabe, S. N. Sridhara, H. Hong, E. Pavez and A. Ortega, "ICIP 2023 Challenge: Full-Reference and Non-Reference Point Cloud Quality Assessment Methods with Support Vector Regression," 2023 IEEE International Conference on Image Processing Challenges and Workshops (ICIPCW), 2023, pp. 3654-3658.

[2] A. Ak, E. Zerman, M. Quach, A. Chetouani, A. Smolic, G. Valenzise, and P. L. Callet, “Basics: Broad quality assessment of static point clouds in a compression scenario,” IEEE Transactions on Multimedia, pp. 1–13, 2024.

