Analysis
================
April
September 7, 2017

This is a practice document for gitmd for the IFD repo. TODO Link this with the Setup data environment to create plots/figures to put in this rm file. Change to gitmd output

### Summary of Interfocal Distances from a F2 Cross

discription of the data and purpose of Analysis. BD data of MLH1 measures in meiotice cells. HVR measures of inter-focal distances of foci on the same bivalent.

#### Patterns to look at

-   proportion of CO classes (per mouse)
-   range of proportion classes
-   mean and variation of IFD
-   min value per F2 mouse
-   normalized IFD \*\*
-   relationsihp of total SC and CO number

These F2's were genrated to compared the average CO number per cell across two HM subspecies. Comparing the the average propotions of bivalent types (1CO, 2CO ect) per cell breaks down that phenotype one more level. Approach; BD data, She filled out the proportions.

Since measuring the proportion of object classes from HVR's data would require the assumption that there are no 0COs, (which is not true), Useing BD's data will be more acurate. But the general approach of quantifying CO proportions from HVR data would be something like... 19 - ( length(IFD) - n3CO\*2).

#### Initial Stats

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

(Not all of the PWD from HVR data overlap with the PWD in BD data set.)

![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/histIFD-2.png)

The histogram appears normally distributed, but with a slight right tail.

#### Bivalent Class proportions table

BD's table has columns for the number of X0, 1X0, 2XO and 3XO. This can be used to calculate the average proportion of each object class.

    ##   ANIMAL_ID nChr nCells    biv0CO    biv1CO    biv2CO     biv3CO
    ## 1      2393   20     21 0.2494331 0.3129252 0.6666667 0.09523810
    ## 2      2394   20     18 0.2932099 0.3734568 0.7592593 0.11419753
    ## 3      2395   20     23 0.2419660 0.3175803 0.5255198 0.08695652
    ## 4      2396   20     21 0.2426304 0.2335601 0.7573696 0.10430839
    ## 5      2397   20     20 0.2500000 0.3200000 0.6900000 0.10000000
    ## 6      2400   20     19 0.3074792 0.4072022 0.6288089 0.10526316

    ##     ANIMAL_ID nChr nCells    biv0CO    biv1CO    biv2CO     biv3CO
    ## 292      3208   20     22 0.2148760 0.3533058 0.6797521 0.10330579
    ## 293      3209   20     22 0.1962810 0.6404959 0.4938017 0.10123967
    ## 294      3210   20     21 0.1678005 0.3151927 0.7256236 0.09750567
    ## 295     CAST1   20     37 0.1402484 0.2118335 0.3184806 0.05405405
    ## 296     CAST2   20     29 0.1640904 0.2722949 0.3888228 0.06896552
    ## 297     CAST3   20     25 0.1808000 0.3312000 0.4400000 0.08000000

#### visualizing proportions (under construction)

I want the 4 average proportions for each class inked in some way. scatter plot, line\_range with points for each class, (examining acverage proportion of 0CO and average SC could provid a proxy for estimating CO maturity)

![](Analysis_md_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

black 0CO, blue 1CO, red 2CO, 3CO orange. Points should follow the same vertical line for each mouse.

This plot displays a general pattern of 3CO bivs being rarer than 0CO bivs. 2COs are usually at a higher proportion than 1COs (F2s). Without linking all the proportions per mouse, this figure is not that useful.

#### Range and Minimums of IFD measures.

The following plots display the ranges of IFDs, the min and max distances between two foci. Check effects of 3COs. These data could skew the min IFD values. The current data frame, has a column with a counter of 3CO per cell.

How could variation in min IFD values, play a role in regulation of IFD.

There doesn't seem to be any relationship between min values and the range. There might be a relationship with the number of measurements.

![](Analysis_md_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-2.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-3.png)

Parental versions ![](Analysis_md_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png)
