library(targets)
source("1_fetch/src/get_nwis_data.R")
source("2_process/src/munge_nwis_data.R")
source("3_visualize/src/plot_timeseries.R")

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "dataRetrieval")) # Loading tidyverse because we need dplyr, ggplot2, readr, stringr, and purrr

p1_targets_list <- list(
  tar_target(site_data_01427207, download_nwis_site_data('01427207')),
  tar_target(site_data_01432160, download_nwis_site_data('01432160')),
  tar_target(site_data_01435000, download_nwis_site_data('01435000')),
  tar_target(site_data_01436690, download_nwis_site_data('01436690')),
  tar_target(site_data_01466500, download_nwis_site_data('01466500')),
  
  tar_target(site_data, 
             list(site_data_01427207, site_data_01432160, site_data_01435000,
                  site_data_01436690, site_data_01466500) %>% 
               bind_rows()
  ),
  
  tar_target(
    site_info,
    nwis_site_info(site_data)
  )
)

p2_targets_list <- list(
  tar_target(
    site_data_munged,
    munge_nwis_data(site_data, site_info)
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
