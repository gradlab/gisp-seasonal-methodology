% Simulating the data

# Motivation

The GISP data have fairly complex temporal behavior. To help readers understand
why we chose the fitting and de-trending methodology presented in the paper, we
tried to generated simulated data that has some of the features of the original
dataset, which we couldn't release with the publication.

# Summary of the generation methodology

The data consists of isolates. Each isolate is a record. There are multiple
clinics, each of which collects isolates every month, but only up to some
maximum number (25). Different clinics collected isolates for different spans
of the data, and different clinics collected different numbers of isolates on
average.

The mean isolate resistance observed in each clinic also varies through time.
To simulate this behavior, we simulated each clinic's true, hidden mean
resistance by generating a random walk, partially smoothing that walk with a
spline function, and finally adding the signal of interest, the seasonal
fluctuation.

To simulate the fact that not all clinics contributed isolates in all data
years, a random subset of the clinics had their time series truncated left or
right. An independent random subset was also selected to have a simulated
methodological change at some point during the time series, creating a
discontinuity in their true mean resistance through time.

Each clinic was assigned a random mean monthly number of isolates, and the true
number of isolates was drawn from a Poisson distribution, capped at 25. The
resistance of each isolate was drawn from a normal distributed centered around
that clinic's true mean for that month, and then rounded up to the nearest
integer. The idea is that each isolate has a true MIC, but we only measure the
2-fold dilutions.
