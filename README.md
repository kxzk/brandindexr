[![Build Status](https://travis-ci.org/beigebrucewayne/brandindexr.svg?branch=master)](https://travis-ci.org/beigebrucewayne/brandindexr)
![brandindexr](https://i.imgur.com/1xMMvq1.png)

## Installation

Install from Github
```r
devtools::install_github('beigebrucewayne/brandindexr')
```

## Workflow

You need to authenticate yourself first, therefore run `bi_auth()` with your email and password. After that, you are free to start querying the API.
```r
bi_auth("your.email@company.com", "yourpassword")
```

#### Multi-Brand Timelines

In order to run multi-brand timelines you'll need to specify multiple brands in the call.
```r
multi_brand_timeline(“us:1023:1000575&brand=us:1023:1000564&brand=us:1023:1000562”, start_date = “2017-10-11”, end_date = “2017-11-11”, scoring = “total”)
```

#### Viewing All Demographic Filters

To see all demographic filters in a region follow the recipe below:
```r
# getting filters for `us` region
filters <- demo_filters("us")

# view all of them in RStudio
View(filters)
```
