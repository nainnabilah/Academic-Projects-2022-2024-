# 📊 Suicide Rates Overview: Data Analysis Project

This repository contains an extensive analysis of the Suicide Rates Overview dataset from Kaggle made as part of an academic project.
The project aims to explore, analyse, and visualise trends in global suicide rates from 1985 to 2021 using various statistical techniques in R.

## 📁 Project Structure

- **raw_code.R**: The R script containing all the code used in this project.
- **Code With Explanations.pdf**: A detailed document explaining the code, methodology, and insights gained from the analysis.

## 📝 Table of Contents

1. [Dataset Overview](#dataset-overview)
2. [Descriptive Analysis](#descriptive-analysis)
3. [Data Visualisation](#data-visualization)
4. [Exploratory Data Analysis](#exploratory-data-analysis)
5. [Statistical Tests](#statistical-tests)
6. [Case Study](#case-study)
7. [Bootstrapping Analysis](#bootstrapping-analysis)

## 📊 Dataset Overview

The dataset used for this analysis was taken from [Kaggle](https://www.kaggle.com/datasets/omkargowda/suicide-rates-overview-1985-to-2021). It consists of suicide rates from various countries between 1985 and 2021, along with associated socio-economic factors.

## 🔍 Descriptive Analysis

The project begins with a comprehensive descriptive analysis of the dataset, including:
- Summary statistics for numerical and categorical variables.
- Data type corrections and cleaning procedures.
- Descriptive statistics using functions from the `psych` and `SmartEDA` packages.

## 📈 Data Visualization

Next, the project visualises the data to identify trends and patterns:
- Bar charts, box plots, and scatter plots—used to visualise categorical and numerical data distributions.
- Time-series analysis of suicide rates over the years—segmented by factors like gender, age, and country.
- A world map visualisation to display global suicide rate distributions.

## 🧪 Exploratory Data Analysis

Exploratory Data Analysis (EDA) is conducted to understand the underlying trends and relationships in the dataset, using:
- Line charts to show trends over time.
- Analysis of variance (ANOVA) and other statistical methods to explore differences between groups.

## 🧬 Statistical Tests

Several statistical tests are applied to assess the quality and suitability of the dataset for further analysis:
- Normality tests, including QQ-plots and density plots, to evaluate data distribution.
- Non-parametric tests like Spearman's rank correlation to analyze the relationship between GDP per capita and suicide rates.

## 📊 Case Study

A short case study was also conducted to investigate the relationship between GDP per capita and suicide rates. 
The study uses Spearman's rank correlation to demonstrate a statistically significant but weak positive correlation between a country's wealth and its suicide rate.

## 🔄 Bootstrapping Analysis

Finally, the project also includes a bootstrapping analysis, where 50, 500, 2000, and 5000 bootstrap samples are generated to estimate the mean ratio of suicide rates between Japan and Mexico. The results are visualized using histograms with fitted normal distribution curves.

## 📜 License

This project is open-source and available under the MIT License. Feel free to modify and distribute it as you like.
