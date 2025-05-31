# Satellite Image Processing: Statistical Equalization Methods

## Claim
Lab work from Jerome IDIER researcher at CNRS, given during the 'Inverse Imaging' lesson at Ecole Centrale de Nantes, Engineering School.

## Introduction

![SatImageAvg](https://github.com/user-attachments/assets/46bbc4f4-7a3b-4b7b-b18e-e64785138c1e)

*This project explores various statistical methods to enhance the quality of satellite images affected by systematic variations, such as columnar effects. The goal is to estimate and correct the gains to reconstruct the images optimally.*

We study blurred satellite images and aim to improve their quality using statistical equalization methods. The objective is to correct biases or systematic variations based on statistical properties of the observed data. We adjust the gains \( g_n \) (or more precisely, the log of these gains noted as \( f_n \)) to eliminate columnar effects or "pyjama" effects, assuming the image \( Z_{m,n} \) follows a Markov field.

## Method 1: Empirical Mean

### Mathematical Preliminaries

The simplest approach is to use the empirical mean of each column to estimate the gains. According to the strong law of large numbers, the first estimator \( \hat{f_n^1} \) is the mean over each column \( n \) of \( V_{m,n} \), up to a constant.

### Results Interpretation

The empirical mean method relies on the simplified assumption of image homogeneity, implying that the mean contributions cancel out. However, noise and systematic variations in the image can introduce biases in the gain estimates.

## Method 2: Median

### Mathematical Preliminaries

Assuming the pixel intensities follow a Markov field, the probability distribution of \( Y \) depends only on neighboring pixel relationships. We consider a Laplacian distribution for the differences between neighboring pixels, leading to a cost function that is linear.

### Maximum Likelihood Estimation (MLE)

Maximizing the likelihood \( p(V|f) \) involves finding the \( f_n \) that align the observed differences \( \delta V_{m,n} \) with the expected statistical structure of \( Y \). The median minimizes the absolute deviations, making this method robust to outliers.

![method12](https://github.com/user-attachments/assets/ef9e5d04-edc3-4892-b9a8-054b21e92042)

### Results Interpretation

This method does not significantly improve gain estimation compared to the empirical mean method. The estimator remains sensitive to outliers, necessitating further refinement.

## Method 3: Maximum a Posteriori (MAP) with Gaussian Distribution

### Mathematical Preliminaries

We introduce the Maximum a Posteriori (MAP) approach, which incorporates a prior probability \( p(f) \) to impose constraints on \( f_n \). The MAP criterion is quadratic and can be solved analytically, leading to a linear system.

### Results Interpretation

The quadratic regularization favors smooth and stable solutions for \( f \), avoiding abrupt variations. This method yields more satisfactory results compared to previous estimators.

## Method 4: MAP with Laplacian Distribution

### Mathematical Preliminaries

In this method, we consider a Laplacian distribution for the observed differences, leading to a cost function \( \phi(x) = \frac{1}{T}|x| \). This approach is more robust to outliers but results in a non-differentiable optimization problem.

![methode4](https://github.com/user-attachments/assets/7b8604f0-bae9-4384-b0ae-ad49f7ba3997)

### Results Interpretation

There is no significant improvement compared to using the \( L_2 \) norm (Method 3). However, for other problems, this method might be preferred, especially when dealing with noisy or irregular data.

## Conclusion

![err123](https://github.com/user-attachments/assets/33cb6e03-a384-435c-8a94-442b5fb85c29)

This project explored various statistical approaches to estimate the gains necessary for correcting satellite images affected by systematic variations. Key points of this study include:

- **Empirical Mean:** Intuitive and easy to implement but limited by its inability to account for spatial correlations or landscape variations.
- **Median:** More robust to outliers but still limited without regularization or global consideration of column interactions.
- **Maximum Likelihood:** Models differences between neighboring pixels explicitly and integrates quadratic regularization, leading to an effective analytical solution but sensitive to outliers.
- **Maximum a Posteriori (MAP):** Offers increased robustness to data anomalies. Although more complex to solve, it is particularly effective for noisy or irregular data.
