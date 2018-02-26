# NaiveBayesClassification
A MATLAB implementation of Naive Bayes for classification problem. 

## Introduction
Naive Bayes is one of the most basic machine learning algorithms, and it has been widely used in many commercial applications. Most of existing machine learning toolkits such as scikit-learn, OpenCV/ml, Weka have provided excellent APIs for Naive Bayes. This MATLAB implementation aims to fulfill Naive Bayes algorithm as introduced by the Chinese book [The Method of Statistical Learning](https://book.douban.com/subject/10590856/) written by Hang Li. The code provides a convenient API and supports for both Maximum Likelihood Estimation based Naive Bayes and Bayesian Estimation based Naive Bayes. An application usage on problem of hyperspectral image classification is presented in the demo code. Here are the results of the demo with two different implemetations.

![image](./img/image.jpg)

Although the results are not very well, this code gives an example to implement Naive Bayes algorithm into practical classification problems. 

## Usage
To run the demo provided by the code, directly run the MATLAB script NBA_demo.m. If you want to use your own data, please prepare your data with the format required by the function run_classification.m.


