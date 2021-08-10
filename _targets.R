library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/munge_nwis_data.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

p1_targets_list <- list(
  tar_target(site_data_01427207_csv, download_nwis_site_data('1_fetch/tmp/site_data_01427207.csv'), format = "file"),
  tar_target(site_data_01432160_csv, download_nwis_site_data('1_fetch/tmp/site_data_01432160.csv'), format = "file"),
  tar_target(site_data_01435000_csv, download_nwis_site_data('1_fetch/tmp/site_data_01435000.csv'), format = "file"),
  tar_target(site_data_01436690_csv, download_nwis_site_data('1_fetch/tmp/site_data_01436690.csv'), format = "file"),
  tar_target(site_data_01466500_csv, download_nwis_site_data('1_fetch/tmp/site_data_01466500.csv'), format = "file"),
  
  tar_target(site_data, 
             purrr::map_df(
               c(site_data_01427207_csv, site_data_01432160_csv, site_data_01435000_csv,
                 site_data_01436690_csv, site_data_01466500_csv),
               read_csv, col_types = 'ccTdcc')),
  
  tar_target(
    site_info_csv,
    nwis_site_info(fileout = "1_fetch/out/site_info.csv", site_data),
    format = "file"
  )
)

p2_targets_list <- list(
  tar_target(
    site_data_munged,
    munge_nwis_data(site_data, site_info_csv)
  )
)

p3_targets_list <- list(
  tar_target(
    figure_1_png,
    plot_nwis_timeseries(fileout = "3_visualize/out/figure_1.png", site_data_munged),
    format = "file"
  )
)

# Return the complete list of targets
c(p1_targets_list, p2_targets_list, p3_targets_list)
