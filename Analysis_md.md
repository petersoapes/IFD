Analysis
================
April
September 7, 2017

This is a practice document for gitmd for the IFD repo. TODO Link this with the Setup data environment to create plots/figures to put in this rm file. Change to gitmd output

### load data

### Header1, Summary of Interfocal Distances from a F2 Cross

#### Initial Stats

mouse specific tables to be used in plots. I should be able to add BD's data.

``` r
#mouse summary stats observations for each class
image_data <- ddply(new.data, .(file_name), summarize,
                        N_IFD = length(IFD),
                        ncells = max(Cell.Count),
                        prcnt_2CO = N_IFD / (ncells*19)
            #number of cells / number of IFDs = proxy for proportion of 2COs            
                        
)

mouse_data <- ddply(new.data, .(Animal.ID), summarize,
                        N_IFD = length(IFD),
                        ncells = max(Cell.Count),
                        prcnt_2CO = N_IFD / (ncells*19)
            #number of cells / number of IFDs = proxy for proportion of 2COs            
                        
)
#mouse_data the mouse data is displayed in a very long table
```

-   histogram of IFD ![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-2.png)

<!-- -->

    ## $breaks
    ##  [1]   0  10  20  30  40  50  60  70  80  90 100 110 120 130 140 150 160
    ## [18] 170 180
    ## 
    ## $counts
    ##  [1]   55  147  215  536 1147 1667 1497  942  539  271  142   33   19   18
    ## [15]    1    4    2    3
    ## 
    ## $density
    ##  [1] 7.598784e-04 2.030948e-03 2.970434e-03 7.405361e-03 1.584692e-02
    ##  [6] 2.303122e-02 2.068251e-02 1.301464e-02 7.446809e-03 3.744128e-03
    ## [11] 1.961868e-03 4.559271e-04 2.625035e-04 2.486875e-04 1.381597e-05
    ## [16] 5.526389e-05 2.763194e-05 4.144791e-05
    ## 
    ## $mids
    ##  [1]   5  15  25  35  45  55  65  75  85  95 105 115 125 135 145 155 165
    ## [18] 175
    ## 
    ## $xname
    ## [1] "new.data$IFD"
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
    ##  [1]  14  60 215 336 530 541 612 674 741 778 692 675 629 294 241 130  43
    ## [18]  16  17
    ## 
    ## $density
    ##  [1] 0.001934236 0.008289583 0.029704338 0.046421663 0.073224648
    ##  [6] 0.074744405 0.084553744 0.093119646 0.102376347 0.107488256
    ## [11] 0.095606521 0.093257806 0.086902459 0.040618956 0.033296491
    ## [16] 0.017960763 0.005940868 0.002210555 0.002348715
    ## 
    ## $mids
    ##  [1] 18.5 19.5 20.5 21.5 22.5 23.5 24.5 25.5 26.5 27.5 28.5 29.5 30.5 31.5
    ## [15] 32.5 33.5 34.5 35.5 36.5
    ## 
    ## $xname
    ## [1] "new.data$nMLH1_foci"
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
