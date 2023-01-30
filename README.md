# Diet-Analysis
**Introduction:**
The focus of this tutorial is analysis of variance (ANOVA). ANOVA is a statistical approach to compare means of an outcome variable of interest across different groups.Perform parametric and non-parametric tests to find which of the diet types is very benificial.

**Dataset Description:**

The data set we use for the illustration is the diet data, which is a small survey of several male and female adults who take on three different diet plans. And the focus of the survey is people’s body weight changes during a six-week time period.

**Data Processing:**

First we want to load the dataset into R and omit any missing values using read.csv() and na.omit().And encode The gender columns and do all the steps to clean and process the data for analysis.

**Parametric ANOVA**

**Parametric One-Way ANOVA**

To create our ANOVA model we use ‘Diet’ as the grouping variable and use aov() to create our parametric one-way ANOVA model for the female dataset. We can then use summary() to analyze this model.

From the above output of the parametric one-way ANOVA for the female dataset, we can see that the p-value is much smaller than 0.05 so we conclude that there is at least one group that is statistically different from the other groups in the female dataset.

**Tukey Test:**

In order to check which group is statistically different, we run the Tukey post hoc test for pairwise comparison following a one-way ANOVA using TukeyHSD().

From the above result we can see that there is a statistically significant difference in weight loss between the ‘Diet 3’ group and the ‘Diet 1’ group and between the ‘Diet 3’ group and the ‘Diet 2’ group. Because of this we can determine that the ‘Diet 3’ group is statistically different from the other two groups.

**Similarly do for males also repeat the same:**

 There is no statistically significant difference between the three groups in the male dataset.

**Parametric Two-Way ANOVA:**

A similar way we could analysis this data is to do parametric two-way ANOVA for the whole dataset. For this we still use aov() but now we regard ‘gender’ and ’Diet as two grouping variables. And to analysis the model we will use Anova() and we want it to be a Type III Sums of Squares ANOVA.

The gender:Diet interaction is statistically significant at the p = 0.04884 level. There was no statistically significant difference in weight loss between gender (p = 0.77854), but there were statistically significant differences between Diet groups (p = 0.01304).

**Nonparametric ANOVA: Kruskal-Wallis Test:**
Now let’s look at Nonparametric ANOVA using the Kruskal-Wallis Test. We regard ‘Diet’ as the grouping variable and use kruskal.test() to do nonparametric one-way ANOVA, i.e. Kruskal-Wallis test for the female data.

We get a p-value that is much smaller than 0.05 so we can reject the null hypothesis and conclude that there is at least one group statistically different from the other groups in the female dataset. This is the same conclusion we got in the parametric one-way ANOVA for the female data.

We get a p-value that is larger than 0.05 so there is no statistically significant difference in weight loss between the three groups in the male dataset. This is the same result we got from the parametric one-way ANOVA for the male data.

**Conclusion:**

Finally, after all of this analysis we can conclude that for this dataset that you can either analyze the data using either parametric or nonparametric ANOVA and receive the same results. Our conclusion is that one group, the Diet 3 group, had a significant difference in weight loss compared to the other groups in the female dataset. However, for the male dataset there was no significant difference in weight loss between the different Diet groups.
