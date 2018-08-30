% Computational methods for seasonal *N. gonorrhoeae* resistance analysis

# Resistance data are simulated

We couldn't publish the underlying resistance data set with the publication, so
the `resistance_data/` folder includes a simulated data set, designed to have
some of the features of the original data.

The analysis script shows the method used in the paper to fit the sinusoidal
function with simultaneous de-trending.

Note that the resistance data shown in the analysis script is *not* intended to
reflect the actual values in the GISP data. They are only for demonstration of
the methods; *not* for showing how the precise results of the paper came about.

# Files

- `README.md`: this file
- `seasonal_analysis.Rmd`: the analysis R Markdown file
- `seasonal_analysis.pdf`: results of the analysis
- `use_data/`
    - `README.md`: an explanation of the individual data files
    - `use_by_age.tsv`
    - `use_by_region.tsv`
    - `use_by_year.tsv`
- `resistance_data/`
    - `README.md`: an explanation of how the simulated data were generated
    - `simulate_data.R`: R script to generate the data included in this repo
    - `simulated_gisp_data.tsv`: the simulated data. The `y` column are 2-fold dilutions.

# Author

Scott Olesen <olesen@hsph.harvard.edu>
