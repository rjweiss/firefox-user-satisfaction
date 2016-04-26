library(ggplot2)
library(plyr)
library(dplyr)
library(reshape2)
library(readr)
library(car)
library(GGally)
library(lubridate)
library(ggthemes)
library(pander)
library(MASS)

data = read_csv(url)
###
# Recoding
###

data = plyr::rename(data, c(
  "Thinking about the last few times you used Firefox, did it get better, get worse, or stay about the same?" = "retrospective", 
  "How likely or unlikely are you to use Firefox again within the next few days?" = "prospective",
  "How strongly do you agree or disagree with the following statement: \"Firefox helps me feel in control of my online experience\"?" = "control",
  "How strongly do you agree or disagree with the following statement: \"I believe that Internet companies know too much about me\"?"='paranoia',
  "How strongly do you agree or disagree with the following statement: \"Firefox allows me to perform tasks on the Internet in a way that meets my expectations\"?" = 'expectations1',
  "How strongly do you agree or disagree with the following statement: \"Firefox allows me to accomplish my goals on the Internet in a way that meets my expectations\"?" = 'expectations2',
  "How strongly do you agree or disagree with the following statement: \"Firefox allows me to complete tasks on the Internet in a way that works as I expect\"?" = 'expectations3',
  "Date Submitted" = 'date',
  "Country" = 'country',
  "State/Region" = 'state',
  "Postal" = 'postal',
  "URL Variable: flowid" = 'flowid',                                                                                                                                             
  "URL Variable: fxversion" = 'fxversion',                                                                                                                                     
  "URL Variable: score" = 'score',                                                                                                                               
  "URL Variable: type" = 'type',                                                                                                                                       
  "URL Variable: updatechannel"  = 'updatechannel',
  "Firefox crashes a lot:Why are you not likely to use Firefox in the next few days?" = 'crashes',
  "Firefox seems slow:Why are you not likely to use Firefox in the next few days?" = 'slow',
  "Firefox doesn’t work with my websites:Why are you not likely to use Firefox in the next few days?" = 'websites',
  "I’m not a regular Firefox user:Why are you not likely to use Firefox in the next few days?" = 'irregular',
  "Another browser seems better:Why are you not likely to use Firefox in the next few days?" = 'competitor'))

# eliminate duplicate columns
data = data[, !duplicated(colnames(data))] 

data$score = as.numeric(data$score)

data$retrospective = as.numeric(car::recode(data$retrospective,
  "'It got worse'=-1;
  'It stayed the same'=0;
  'It got better'=1;
  else=NA"
))

data$prospective = as.numeric(car::recode(data$prospective,
  "'Extremely Unlikely' = -2;
  'Unlikely' = -1;
  'Neutral' = 0;
  'Likely' = 1;
  'Extremely Likely' = 2;
  else=NA"))
  
data$paranoia = as.numeric(car::recode(data$paranoia,
 "'Strongly Disagree'=-2;
  'Disagree'=-1;
  'Neither agree nor disagree'=0;
  'Agree'=1;
  'Strongly Agree'=2;
  else=NA"))

data$control = as.numeric(car::recode(
  data$control,
  "'Strongly Disagree'=-2;
  'Disagree'=-1;
  'Neither agree nor disagree'=0;
  'Agree'=1;
  'Strongly Agree'=2;
  else=NA"))

# Experimental questions

data$expectations1 = as.numeric(car::recode(
  data$expectations1,
  "'Strongly Disagree'=-2;
  'Disagree'=-1;
  'Neither agree nor disagree'=0;
  'Agree'=1;
  'Strongly Agree'=2;
  else=NA"))

data$expectations2 = as.numeric(car::recode(
  data$expectations2,
  "'Strongly Disagree'=-2;
  'Disagree'=-1;
  'Neither agree nor disagree'=0;
  'Agree'=1;
  'Strongly Agree'=2;
  else=NA"))

data$expectations3 = as.numeric(car::recode(
  data$expectations3,
  "'Strongly Disagree'=-2;
  'Disagree'=-1;
  'Neither agree nor disagree'=0;
  'Agree'=1;
  'Strongly Agree'=2;
  else=NA"))
