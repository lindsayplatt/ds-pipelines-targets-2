munge_nwis_data <- function(nwis_data_filepath, site_info) {
  
  read_csv(nwis_data_filepath, col_types = 'ccTdccdc') %>% 
    rename(water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, -tz_cd) %>% 
    left_join(site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, 
           water_temperature, latitude = dec_lat_va, longitude = dec_long_va) %>% 
    mutate(station_name = as.factor(station_name))
  
}
