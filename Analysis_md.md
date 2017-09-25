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

-   histogram of IFD (the echo= false ) still produces some output code.

The histogram appears normally distributed, but with a slight right tail.

#### range and distribution of IFD measures.

The following plots display the ranges of IFDs, the min and max distances between two foci. Figure out how to assess these relationships with the proportion of object classes. For example test hypothesis that smaller range has a smaller proportion of 3COs.

How could variation in min IFD values, play a role in regulation of IFD.

-There doesn't seem to be any relationship between min values and the range. There might be a relationship with the number of measurements.

![](Analysis_md_files/figure-markdown_github-ascii_identifiers/IFD%20plots-1.png)![](Analysis_md_files/figure-markdown_github-ascii_identifiers/IFD%20plots-2.png)
