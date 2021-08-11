
source("1_fetch/src/get_nwis_data.R")

p1_targets_list <- list(
  tar_target(p1_site_data_01427207, download_nwis_site_data('01427207')),
  tar_target(p1_site_data_01432160, download_nwis_site_data('01432160')),
  tar_target(p1_site_data_01435000, download_nwis_site_data('01435000')),
  tar_target(p1_site_data_01436690, download_nwis_site_data('01436690')),
  tar_target(p1_site_data_01466500, download_nwis_site_data('01466500')),
  
  tar_target(p1_site_data_csv,
             {
               out_file <- "1_fetch/out/site_data.csv"
               list(p1_site_data_01427207, p1_site_data_01432160, p1_site_data_01435000,
                    p1_site_data_01436690, p1_site_data_01466500) %>% 
                 bind_rows() %>% 
                 write_csv(out_file)
               return(out_file)
             },
             format = "file"
  ),
  
  tar_target(
    p1_site_info,
    nwis_site_info(p1_site_data_csv)
  )
)
