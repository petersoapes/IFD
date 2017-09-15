Analysis
================
April
September 7, 2017

This is a practice document for gitmd for the IFD repo. TODO Link this with the Setup data environment to create plots/figures to put in this rm file. Change to gitmd output

### load data

### Header1, Summary of Interfocal Distances from a F2 Cross

#### Initial Stats

-   number of mice used

-   mean and variance of MLH1 for each category (boxplots)

-   mean and variance of IFD for each category

mouse specific tables to be used in plots. I should be able to add BD's data.

``` r
#mice used in each category (HVR and BD)
BD_mice_num <- ddply(BD_data, .(Cross), summarize,
                        N_mice = length(unique(ANIMAL_ID)), 
                     num_cells = length(nMLH1_foci)
)
  
HVR_mice_num <- ddply(data_HVR_full, .(Cross), summarize,
                        N_mice = length(unique(Animal.ID)), 
                     num_cells = length(IFD)
)
HVR_mice_num
```

    ##   Cross N_mice num_cells
    ## 1  CAST      3       220
    ## 2 CXPF2     72      7682
    ## 3   PWD      3       573
    ## 4            1       125
    ## 5 CxPF1      2       231

``` r
BD_mice_num
```

    ##    Cross N_mice num_cells
    ## 1   CAST      3        91
    ## 2  CxPF2    269      5509
    ## 3 CZECHI      7       156
    ## 4    PWD     10       192
    ## 5  PxCF1      1        40
    ## 6  PxCF2      7       127

-   histogram of IFD ![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-2.png)

<!-- -->

    ## $breaks
    ##  [1]   0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 160
    ## [18] 170 180
    ## 
    ## $counts
    ##  [1]   55  149  217  553 1188 1712 1541  972  553  279  146   34   20   18
    ## [15]    1    4    2    3
    ## 
    ## $density
    ##  [1] 7.385524e-04 2.000806e-03 2.913925e-03 7.425809e-03 1.595273e-02
    ##  [6] 2.298912e-02 2.069290e-02 1.305224e-02 7.425809e-03 3.746475e-03
    ## [11] 1.960521e-03 4.565597e-04 2.685645e-04 2.417081e-04 1.342823e-05
    ## [16] 5.371290e-05 2.685645e-05 4.028468e-05
    ## 
    ## $mids
    ##  [1]   5  15  25  35  45  55  65  75  85  95 105 115 125 135 145 155 165
    ## [18] 175
    ## 
    ## $xname
    ## [1] "IFD_nMLH1$IFD"
    ## 
    ## $equidist
    ## [1] TRUE
    ## 
    ## attr(,"class")
    ## [1] "histogram"

    ## $breaks
    ##  [1] 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37
    ## 
    ## $counts
    ##  [1]  14  61 215 336 552 571 619 695 770 804 709 693 642 319 241 130  43
    ## [18]  16  17
    ## 
    ## $density
    ##  [1] 0.001879952 0.008191218 0.028870686 0.045118840 0.074123808
    ##  [6] 0.076675171 0.083120720 0.093326172 0.103397341 0.107962938
    ## [11] 0.095206123 0.093057607 0.086209212 0.042836041 0.032362025
    ## [16] 0.017456694 0.005774137 0.002148516 0.002282798
    ## 
    ## $mids
    ##  [1] 18.5 19.5 20.5 21.5 22.5 23.5 24.5 25.5 26.5 27.5 28.5 29.5 30.5 31.5
    ## [15] 32.5 33.5 34.5 35.5 36.5
    ## 
    ## $xname
    ## [1] "IFD_nMLH1$nMLH1_foci"
    ## 
    ## $equidist
    ## [1] TRUE
    ## 
    ## attr(,"class")
    ## [1] "histogram"

The histogram appears normally distributed, but with a slight right tail.

#### Things to look at

-   proportion of CO classes (per mouse)
-   range of proportion classes
-   mean and variation of IFD

-   min value per F2 mouse
-   normalized IFD \*\*
-   relationsihp of total SC and CO number
