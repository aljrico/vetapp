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

    if (file.exists(file_name)) {
      old_file     <- data.table::fread(file_name)
      new_file     <- as.data.frame(new_log)
      updated_file <- dplyr::bind_rows(new_file, old_file)
    } else {
      updated_file <- as.data.frame(new_log)
    }
    data.table::fwrite(updated_file, file_name)
    message("Owner details successfully updated")
  }
)