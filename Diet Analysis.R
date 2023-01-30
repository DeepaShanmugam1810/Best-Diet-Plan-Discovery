
#Importing dataset
dietR<-read.csv("D:/Data Science/others/Diet Analysis/Diet.csv",header=T,na.strings=c("","NA"))

#attaching the dataset
attach(dietR)

#Calculating weightloss
dietR$weightlost<-pre.weight-weight6weeks

#re-attaching the dataset
attach(dietR)

#splitting dataset into subsets
dietR.female = subset(dietR, gender==0)
dietR.male = subset(dietR, gender==1)

#one-way anova for female datset
anovaFemale = aov(weightlost~Diet, data = dietR.female)
summary(anovaFemale)

#one-way anova for male datset
anovaMale = aov(weightlost~Diet, data = dietR.male)
summary(anovaMale)

#two-way anova model
anova2<-aov(weightlost~as.factor(gender)*as.factor(Diet),data=dietR)


#(difference between each individual and 
#their diet/gender combination mean
res<-anova2$residuals

#Histogram of residuals - check normality
hist(res,main="Histogram of residuals",xlab="Residuals")

#Levene Test - compare equality of variance
library(carData)
leveneTest(weightlost~as.factor(gender)*as.factor(Diet),data=dietR)

#Summarizing the two-way anova
summary(anova2)

#Interaction plot
interaction.plot(Diet, dietR$gender,weightlost,main="Mean weight lost by diet and gender",ylab = "mean
of weightlost",xlab = "Type of Diet")

#tukey post hoc test
TukeyHSD(anova2)

#visualizing two tukey post hoc test
library(gplots)
plotmeans(weightlost~Diet, data = dietR.female)
plotmeans(weightlost~Diet, data = dietR.male)

#non-parametric test
#hypothesis : no significance difference in weight loss
kruskal.test(weightlost~Diet, data = dietR.female)
kruskal.test(weightlost~Diet, data = dietR.male)

#Pearson's chi-squared test
chisq.test(gender,weightlost)

#Mann-whitney test
dietR.type2 = subset(dietR, Diet==2)
dietR.type3 = subset(dietR, Diet==3)
wilcox.test(weightlost~gender, data=dietR)
wilcox.test(Diet~gender,data=dietR)

#Wilcoxon signed rank test
wilcox.test(weightlost,Diet,data=dietR.female, paired=TRUE)

#boxplot for weightloss vs diet type
boxplot(weightlost~Diet,data=dietR,col="light gray",
        ylab = "Weight loss (kg)", xlab = "Diet type")
abline(h=0,col="blue")

#QUALITY CONTROL CHART :

#calculating defects for control chart
weight_gain=weightlost*(-1)
defects=aggregate(weight_gain, by=list(Diet=Diet), FUN=sum)

#calculating sample-size for control chart
sample_size=aggregate(weight_gain, by=list(Diet=Diet), FUN=length)

#Creating dataframe for defects and sample size
df1 <- data.frame(defects, sample_size)
df2<- data.frame(defects, sample_size)

#p-chart
library("qcc")
p_chart <- with(df1, qcc(df1$defects, df1$sample_size, type = "p", data.name = "defects"))

#c-chart
library("ggplot2")
library("ggQC")
c_base <- ggplot(df2, aes(x=diet_type, y = defects))
c_Chart <- c_base + geom_point() + geom_line() +stat_QC(method = "c", auto.label = T, label.digits = 2)
