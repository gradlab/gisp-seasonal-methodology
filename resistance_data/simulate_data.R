#! /usr/bin/env Rscript

library(dplyr)
library(stringr)
library(purrr)
library(readr)

# parameters ------------------------------------------------------------------
n_clinics = 40 # number of clinics
n_years = 10 # number of data years

# name the clinics "clinic01", ..., "clinic40"
clinic_names = 1:n_clinics %>%
  as.character() %>%
  str_pad(width = max(str_length(.)), pad = '0') %>%
  str_c('clinic', .)

p_clinic_has_break = 0.5 # probability the clinic doesn't have complete data
p_data_before_break = 0.5 # is the data missing before or after the break?
p_clinic_has_discontinuity = 0.3 # prob. the clinic had a methodological change
max_abs_discontinuity = 2.0 # size of the discontinuity

smoothing_par = 0.5 # 0 = no smoothing, 1 = lots of smoothing

# parameters for monthly isolates
monthly_mean_min = 3.0 # lower bound of uniform distribution
monthly_mean_max = 25.0
max_monthly_isolates = 25L

# parameters to generate the random walk
random_walk_mean = 5e-3
random_walk_sd = 0.2

# seasonality parameters
amplitude = 0.1
phase = 1.0
omega = 2 * pi / 12 # in month

# noise in the collected isolates around the true value
isolate_dilution_sd = 0.1

# functions -------------------------------------------------------------------

# pick TRUE with probability p; else FALSE
yn = function(p_yes) as.logical(rbinom(1, 1, p_yes))
# leave off last item in vector
drop_last = function(x) head(x, -1)

# function to simulate the random timecourse for a clinic
time_f = function(n_years) {
  # t is months since start of timecourse
  # y_walk is the random walk
  # y_smooth_walk is the smoothed random walk
  # y_season is the seasonal variation
  time = crossing(year = 1:n_years, month = 0:11) %>%
    mutate(t = year * 12 + month,
           y_walk = cumsum(rnorm(n(), random_walk_mean, random_walk_sd)),
           y_smooth_walk = predict(smooth.spline(t, y_walk, spar = smoothing_par), t)$y,
           y_season = amplitude * sin(omega * (month - phase)),
           y_true = y_smooth_walk + y_season)

  # does the data have a break?
  if (yn(p_clinic_has_break)) {
    # when is the break?
    years = unique(time$year) %>% drop_last()
    break_after = sample(years, 1)
    # is there data before or after the break?
    if (yn(p_data_before_break)) {
      time %<>% filter(year <= break_after)
    } else {
      time %<>% filter(year > break_after)
    }
  }

  # does the data have a discontinuity?
  # only allow if there's more than one data year
  years = unique(time$year) %>% drop_last()
  if (length(years) > 1 && yn(p_clinic_has_discontinuity)) {
    # when is the discontinuity?
    discon_after = sample(years, 1)
    # how big is the discontinuity?
    discon_magnitude = runif(1, -max_abs_discontinuity, max_abs_discontinuity)

    # add the discontinuity magnitude to data points after the discontinuity
    time %<>%
      mutate(y_true = if_else(year <= discon_after,
                              y_true, y_true + discon_magnitude))
  }

  time
}

# simulate the data -----------------------------------------------------------
dat = data_frame(clinic = clinic_names,
                 monthly_mean = runif(n_clinics, monthly_mean_min, monthly_mean_max)) %>%
  mutate(time = replicate(n_clinics, time_f(n_years), simplify = FALSE),
         n_isolates = map2(time, monthly_mean, ~ pmin(max_monthly_isolates, rpois(nrow(.x), .y)))) %>%
  unnest() %>%
  mutate(y = map2(n_isolates, y_true, ~ as.integer(ceiling(rnorm(.x, .y, sd = isolate_dilution_sd))))) %>%
  unnest() %>%
  mutate(isolate_id = 1:n()) %>%
  select(isolate_id, clinic, year, month, y)

write_tsv(dat, 'simulated_gisp_data.tsv')
