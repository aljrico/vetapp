#' An S4 class to represent an owner file.
#' 
#' @slot first_name First Name of the owner
#' @slot last_name Last Name of the owner
#' @slot street_name Street Name of the owner's address
#' @slot post_code Post Code of the owner's address
#' @slot email email address the owner wishes to be contacted with
#' @slot phone_number Phone Number the owner wises to be contacted from
setClass(
  Class = "owner_data",
  slots = list(
    first_name = "character",
    last_name = "character",
    street_name = "character",
    post_code = "character",
    email = "character",
    phone_number = "character"
  )
)


#' An S4 generic to update existing data of some specific class
#' 
#' @param owner_data A data.frame, the existing file of Owners' Data
setGeneric(
  "updateData",
  function(owner_data) standardGeneric("updateData"),
  signature = "owner_data"
)


#' An S4 method to update the existing data of class 'owner_data'
#' 
#' @param owner_data An S4 object of class 'owner_data'
setMethod(
  "updateData",
  "owner_data",
  function(owner_data) {
    file_name <- "owner_files.csv"
    new_log   <- slotApply(owner_data, function(x) x)
    
    google_app <- httr::oauth_app(
      appname = "vetApp",
      key = "251575276543-m3emm4p2f5c530v183ddgmldget197d5.apps.googleusercontent.com",
      secret = "uYHgPvfwZxIOQYZ0XNSdI--t"
    )
    
    google_key = "AIzaSyBi9XD393GH83TTPDvBdYmsOf_-JTczEPQ"
    
    googledrive::drive_auth_configure(app = google_app, api_key = google_key)
    
    tmp <- tempfile(fileext = ".csv")
    googledrive::drive_download(file = 'vetApp/owner_files.csv', path = tmp)
    existing_file <- as.data.frame(data.table::fread(tmp))
    updated_file <- dplyr::bind_rows(existing_file, new_log)
# 
#     if (file.exists(file_name)) {
#       old_file     <- data.table::fread(file_name)
#       new_file     <- as.data.frame(new_log)
#       updated_file <- dplyr::bind_rows(new_file, old_file)
#     } else {
#       updated_file <- as.data.frame(new_log)
#     }
    
    googledrive::drive_upload('data-raw/owner_files.csv', path = 'vetApp/')

    # data.table::fwrite(updated_file, file_name)
    message("Owner details successfully updated")
  }
)