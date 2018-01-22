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
