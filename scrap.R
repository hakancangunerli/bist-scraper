---
title: "scrap"
output: html_document
date: "2023-05-07"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
# download the file
#url <- "https://www.borsaistanbul.com/datum/PayEndeksleri.zip"
#dest_file <- "PayEndeksleri.zip"

# download the file, but we're not downloading as jl, py have done that already.
#download.file(url, destfile, mode = "wb") # nolint

df <- read.csv("./outputs/FiyatEndeksleri_PriceIndices.csv", sep=";")

head(df,5)
```



```{r}
# rename columns to rename columns to ORDER	INDEX CODE	INDEX NAMES IN TURKISH	INDICES	CURRENCY TYPE	DATE	CLOSING VALUE	OPEN VALUE	LOWEST VALUE	HIGHEST VALUE

colnames(df) <- c("ORDER", "INDEX_CODE", "INDEX_NAMES_TR", "INDICES", "CURRENCY_TYPE", "DATE", "CLOSING_VALUE", "OPEN_VALUE", "LOWEST_VALUE", "HIGHEST_VALUE")
# drop first row
df <- df[-1,]
head(df)

```
```{r}
# convert closing_value, open_value, lowest_value, highest_value to Float64

df$CLOSING_VALUE <- as.numeric(df$CLOSING_VALUE)

df$OPEN_VALUE <- as.numeric(df$OPEN_VALUE)

df$LOWEST_VALUE <- as.numeric(df$LOWEST_VALUE)

df$HIGHEST_VALUE <- as.numeric(df$HIGHEST_VALUE)

head(df,5)
```


```{r}


x <- quantile(df$OPEN_VALUE)



vals <- df$OPEN_VALUE[df$OPEN_VALUE > x[2] & df$OPEN_VALUE < x[4]]




```


```{r}

boxplot(vals, horizontal=T)

```

