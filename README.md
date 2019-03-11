[![Build Status](https://travis-ci.org/kadekillary/brandindexr.svg?branch=master)](https://travis-ci.org/kadekillary/brandindexr)  

![brandindexr](https://i.imgur.com/1xMMvq1.png)

## Installation

Install from Github
```r
devtools::install_github('kadekillary/brandindexr')
```

#### Authentication

You need to authenticate yourself first, therefore run `bi_auth()` with your email and password. After that, you are free to start querying the API.
```r
bi_auth("your.email@company.com", "yourpassword")
```

#### Brand String Construction

The brand strings are at the heart of `multi_brand_timeline` functions. However, they can be quite long and complex to compose. Therefore, in order to ease the cognitive load. One of the two approaches should be taken.
```r
# using Base R -> paste0()
a <- 'us:12:12001:/bixdemo_stateresidence2.4'
b <- '&brand=us:12:12001:/bixdemo_stateresidence2.5'
c <- '&brand=us:12:12001:/bidenmo_stateresidence2.6'

final_string <- paste0(a, b, c)

# using library(glue)
a <- 'us:12:12001:/bixdemo_stateresidence2.4'
b <- '&brand=us:12:12001:/bixdemo_stateresidence2.5'
c <- '&brand=us:12:12001:/bidenmo_stateresidence2.6'

final_string <- glue::glue("{a}{b}{c}")

# passing final string to multi_brand
multi_brand_timeline(final_string, start_date = “2017-10-11”, end_date = “2017-11-11”, scoring = “total”)
```

#### Multi-Brand Timelines

In order to run multi-brand timelines you'll need to specify multiple brands in the call.
```r
multi_brand_timeline(“us:1023:1000575&brand=us:1023:1000564&brand=us:1023:1000562”, start_date = “2017-10-11”, end_date = “2017-11-11”, scoring = “total”)
```

#### Multiple Filters for Multi-Brand Timeline

The key is to place a `/` after the colon of each demographic filter, like below:
```r
multi_brand_timeline('us:12:12001:/bixdemo_top60dmas2.1&brand=us:12:12001:/bixdemo_top60dmas2.2&brand=us:12:12005&brand=us:12:12001:/bixdemo_top60dmas2.1&brand=us:12:12001:/bixdemo_top60dmas2.2','2017-01-01','2017-02-01', 'total','16')
```

#### Demographic Filters

To see all demographic filters in a region follow the recipe below:
```r
# getting filters for `us` region
filters <- demo_filters("us")

# view all of them in RStudio
View(filters)

# describe demo filter
values <- demo_filter_values("us", "nfl_interest_level")

> values$text
[1] "How interested, or not, are you in NFL (for example - watch on TV, listen to on radio, attend in-person, follow on internet or social media)?"
```
