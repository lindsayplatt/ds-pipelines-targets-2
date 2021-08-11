
source("2_process/src/munge_nwis_data.R")

p2_targets_list <- list(
  tar_target(
    p2_site_data_munged,
    munge_nwis_data(p1_site_data_csv, p1_site_info)
  )
)
