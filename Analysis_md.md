Analysis
================
April
September 7, 2017

This is a practice document for gitmd for the IFD repo. TODO Link this with the Setup data environment to create plots/figures to put in this rm file. Change to gitmd output

### Summary of Interfocal Distances from a F2 Cross

discription of the data and purpose of Analysis. BD data of MLH1 measures in meiotice cells. HVR measures of inter-focal distances of foci on the same bivalent.

#### Initial Stats

-   number of mice used

-   mean and variance of MLH1 for each category (boxplots)

-   mean and variance of IFD for each category

mouse specific tables to be used in plots. I should be able to add BD's data.

    ##   Cross N_mice num_IFD
    ## 1  CAST      3     220
    ## 2 CXPF2     72    7682
    ## 3   PWD      3     573
    ## 4            1     125
    ## 5 CxPF1      2     231

    ##    Cross N_mice num_cells
    ## 1   CAST      3        91
    ## 2  CxPF2    269      5509
    ## 3 CZECHI      7       156
    ## 4    PWD     10       192
    ## 5  PxCF1      1        40
    ## 6  PxCF2      7       127

Not all of the PWD from HVR data overlap with the PWD in BD data set.

-   histogram of IFD (the echo= false ) still produces some output code. ![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-2.png)

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

These F2's were genrated to compared the average CO number per cell across two HM subspecies. Comparing the the average propotions of bivalent types (1CO, 2CO ect) per cell breaks down that phenotype one more level. Approach; BD data, She filled out the proportions.

Since measuring the proportion of object classes from HVR's data would require the assumption that there are no 0COs, (which is not true), Useing BD's data will be more acurate. But the general approach of quantifying CO proportions from HVR data would be something like... 19 - ( length(IFD) - n3CO\*2).

``` r
BDmouseBivClass_proportions <- ddply(BD_data, .(ANIMAL_ID), summarize,
                   #  Cross = as.factor(Cross),
                    nChr = mean(nChr),
                   nCells = length(nMLH1_foci),
                     biv0CO =  mean( (as.numeric(nChrWithoutXO) ) ) / nCells,
                     biv1CO =  mean( (as.numeric(nChrWith1XO) ) ) / nCells , 
                     biv2CO =  mean( (as.numeric(nChrWith2XO) ) ) / nCells ,
                     biv3CO =  mean( (as.numeric(nChrWith3.XO) ) )/ nCells 
)
#increase the denominator to nCells * 19
# should the proportions be compared to the MLH1 number?

# match these mice to the mice in IFD_MLH1, 
```

#### range and distribution of IFD measures.

``` r
IFD_bxplt <- boxplot((IFD_nMLH1$ANIMAL_ID), IFD_nMLH1$IFD, main= "IFD distributions")
```

![](Analysis_md_files/figure-markdown_github-ascii_identifiers/IFD%20plots-1.png)

``` r
#use ggplot

IFD_bxplt
```

    ## $stats
    ##      [,1]    [,2]
    ## [1,]   81  12.806
    ## [2,]  185  47.873
    ## [3,]  336  59.161
    ## [4,]  359  71.266
    ## [5,]  406 106.302
    ## 
    ## $n
    ## [1] 7447 7447
    ## 
    ## $conf
    ##          [,1]    [,2]
    ## [1,] 332.8142 58.7327
    ## [2,] 339.1858 59.5893
    ## 
    ## $out
    ##   [1] 109.8670 110.8250 128.0250  12.0410 132.7880 132.2340 116.1870
    ##   [8]  12.2060   9.2190 109.8400 115.0680 107.2870  12.1360 108.7080
    ##  [15] 115.5410 130.5300 110.0240 107.3340 132.7520 135.1846 122.4180
    ##  [22] 110.8720 149.4030 122.9340 107.2870 129.6090 118.2510 108.1050
    ##  [29] 118.9500 152.6650 173.7480   8.0620   7.2110 128.8370   7.0000
    ##  [36] 113.3070 122.1190 161.0070 107.6790 111.6100 164.0840 116.6500
    ##  [43] 131.4820 155.9280 128.5960 131.5790 118.5930 107.7790  10.8160
    ##  [50] 108.6680 118.3780 127.9000 132.1470  12.0410 113.2640 154.4900
    ##  [57] 110.7160 109.8240  10.0490  12.3650  12.0830  10.7700   8.0620
    ##  [64] 111.2030 106.6740 136.3350 130.2500   9.4860   7.0710 120.5300
    ##  [71]   6.0000   7.0710 106.4520  12.6490 107.9640  10.7700   9.4330
    ##  [78]  12.5240 107.4150 113.7980  12.5290 107.5800  11.0000   9.8990
    ##  [85] 176.1000 131.6890 108.7460   9.0550 107.2740   8.0620 107.2870
    ##  [92] 122.9850 150.4880 108.3740 116.9690 119.1160 114.4670 122.3020
    ##  [99]  10.7700   9.5440 107.0170 107.1350 122.0410 120.6090 111.7040
    ## [106] 139.3720 107.3990 108.2100   7.0000  11.6830 128.2540   9.2190
    ## [113] 119.0820   5.0000 126.5430  10.1980 118.6660 113.7000   8.2460
    ## [120]   9.4860   7.0710  12.3690  11.1800  12.7270  12.1650 119.0080
    ## [127]   5.0000   6.3240   7.0710  12.0410  10.7700   9.2190   7.6150
    ## [134] 179.3020   9.2190   7.0710 108.1640 119.2010  11.3130 137.3120
    ## [141]  12.7270 124.5450   8.4850  12.6490 115.5170 127.8460  12.0410
    ## [148]  11.1800   9.4330  12.0000   9.2190  10.4400   8.0000  10.4400
    ## [155]   8.0620 111.4110  10.1980 106.5890 131.0500 109.2410 135.3000
    ## [162]   9.4860 132.6760 130.2800 116.6790  12.7270 117.0960 107.1930
    ## [169] 107.3270 119.5640   7.0000 111.2600   8.6020   9.0550 123.6590
    ## [176] 128.1800 119.0350   7.0710  10.2950  10.1980   8.9440   7.2110
    ## [183] 109.7840   8.0620   9.2190  12.0830  11.0450  11.4010   8.5440
    ## [190]  12.1650   8.6020   7.0710   7.2110   9.2190   8.5440 106.7810
    ## [197] 115.4150 121.7700  11.0450   9.2190 133.4540   7.8100   7.2110
    ## [204]   6.0820   5.0000   8.5440   9.4720   6.7080  10.1980  10.6300
    ## 
    ## $group
    ##   [1] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ##  [36] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ##  [71] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ## [106] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ## [141] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ## [176] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
    ## 
    ## $names
    ## [1] "" ""
