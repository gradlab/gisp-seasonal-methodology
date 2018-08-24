% Computational methods for seasonal *N. gonorrhoeae* resistance analysis

# Methodology

We couldn't publish the underlying data set with the publication, so the
`data/` folder includes a simulated data set, designed to have some of the
features of the original data.

The analysis script shows the method used in the paper to fit the sinusoidal
function with simultaneous de-trending.

Note that the data shown in the analysis script is *not* intended to reflect
the actual values in the GISP data. They are only for demonstration of the
methods; *not* for showing how the precise results of the paper came about.

# Files

- `README.md`: this file
- `gisp_analysis.Rmd`: the analysis R Markdown file
- `gisp_analysis.html`: results of the analysis
- `data/`
    - `README.md`: an explanation of how the simulated data were generated
    - `simulate_data.R`: R script to generate the data included in this repo
    - `simulated_gisp_data.tsv`: the simulated data. The `y` column are 2-fold dilutions.

# Author

Scott Olesen <olesen@hsph.harvard.edu>
