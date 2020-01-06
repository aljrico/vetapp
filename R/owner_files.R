class_owner_files <-
  R6::R6Class(
    public = list(
      data = NULL,

      files = list(
        local_file = "tmp/owner_files.feather",
        remote_file = "vetApp/owner_files.feather",
        remote_directory = "vetApp/",
        token_key = NULL
      ),

      initialize = function() {
        self$files$token_key <- readRDS("token.rds")
        rdrop2::drop_download(
          path = self$files$remote_file, 
          local_path = self$files$local_file, 
          dtoken = self$files$token_key,
          overwrite = TRUE)
        
        owner_data <- feather::read_feather(self$files$local_file)

        self$data <- tibble::tibble(
          first_name = owner_data[["first_name"]],
          last_name = owner_data[["last_name"]],
          street_name = owner_data[["street_name"]],
          post_code = owner_data[["post_code"]],
          email = owner_data[["email"]],
          phone_number = owner_data[["phone_number"]] %>% as.character()
        )
      },
      add_log = function(new_log) {
        self$data <- suppressWarnings(dplyr::bind_rows(self$data, new_log))
      },

      upload_data = function() {
        feather::write_feather(self$data, self$files$local_file)
        rdrop2::drop_upload(
          file = self$files$local_file, 
          path = self$files$remote_directory, 
          dtoken = self$files$token_key, 
          mode = "overwrite")
      }
    )
  )
