library(foreign)
library(lme4)

setwd("C:/Users/isagarzazu/Dropbox/CCAP/Workshop/DuchArmstrongWorkshop/")
data<-read.dta("replicationData_clean.dta")

summary(data) 

###### TABLE 7.1

table_7.1_Model1 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))
	
table_7.1_Model2 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ polcon + polcon_better + polcon_worse 
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))
	
table_7.1_Model3 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ tradeopen + tradeopen_better + tradeopen_worse
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))

table_7.1_Model4 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ combined + combined_better + combined_worse 
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))

###### TABLE 9.8	
	
table_9.8_Model1 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ vectdist2 + vectdist2_better + vectdist2_worse
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))

###### TABLE 10.8	
	
table_10.8_Model1 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ enpm60 + enpm60_better + enpm60_worse
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))

##### TABLE 11.1
	
	
table_11.1_Model1 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ combined + combined_better + combined_worse # Open Economy/Extensive State Sector
	+ vectdist2 + vectdist2_better + vectdist2_worse # Concentration of Exec Resp.
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))

	
table_11.1_Model2 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ combined + combined_better + combined_worse # Open Economy/Extensive State Sector
	+ enpm60 + enpm60_better + enpm60_worse # PM Contenders
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))
	
	
table_11.1_Model3 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ vectdist2 + vectdist2_better + vectdist2_worse # Concentration of Exec Resp.
	+ enpm60 + enpm60_better + enpm60_worse # PM Contenders
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))
	
table_11.1_Model4 <- lmer( pm ~ lrself + leftpm + lrself_leftpm + retnat_better + retnat_worse 
	+ combined + combined_better + combined_worse # Open Economy/Extensive State Sector
	+ vectdist2 + vectdist2_better + vectdist2_worse # Concentration of Exec Resp.
	+ enpm60 + enpm60_better + enpm60_worse # PM Contenders
	+ size + age + male + (1|cnumb) + (1|studyno)
	,data, binomial(link = "logit"))



