% Antibiotic use data

Macrolide antibiotic use (azithromycin, clarithromycin, and erythromycin) was
measured with the [Truven Health MarketScan Research
Database](https://marketscan.truvenhealth.com/marketscanportal/). Individuals
in the database aged 10-59 who were on an insurance plan for all 12 months of
any year 2011 through 2015 were included.

Antibiotic use data shown, stratified three ways. In each file, there are
common columns:

- `year`: data year
- `fill_month`: 0 = January, 11 = December
- `claims_per_1k_member`: Macrolide claims per 1,000 insurance plan members

The three files are:

- `use_by_age.tsv`: which includes `age_group`
- `use_by_region.tsv`: which includes US Census region `region`
- `use_by_year.tsv`: which has no grouping other than `year`
