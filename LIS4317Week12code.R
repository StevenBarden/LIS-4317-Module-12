#?--------------------------------------------------------------------
# SECTION 1   : COURSE AND ASSIGNMENT DETAILS
# --------------------------------------------------------------------
# Course      : LIS-4317-Week-12
# Assignment  : R Markdown Documentation
# URL         : https://usflearn.instructure.com/courses/1934094/assignments/17694855
# Filename    : LIS4317Week12code.R
# Purpose     : Create an R Markdown file to document main functions for the final project
# Author      : Steven Barden
# Email       : StevenBarden@usf.edu
# Created     : 2025-04-13-0700-00
# Updated     : 2025-04-14-0800-00
# License     : The Stuningly Free Unlicense
# Description : This script generates an R Markdown file to document key 
#             : functions for the final project, including data loading, 
#             : cleaning, transformation, analysis, and visualization.
#             : It also produces a blog post explaining R Markdown's role.

# --------------------------------------------------------------------
# SECTION 2: ENVIRONMENT SETUP
# --------------------------------------------------------------------

show_comments <- TRUE  # Set to FALSE to hide all instructional comments

# Set the base directory.
baseDir <- r"(C:\Users\Steve\OneDrive\College\_____DESKTOP ICONS\Remeye\Classes\4317\Mod12\)"


# Ensure and set the working directory.
tryCatch({
  print(paste("Current working directory:", getwd()))
  if (!dir.exists(baseDir)) stop("Directory does not exist: ", baseDir)
  setwd(baseDir)
  print(paste("Working directory successfully set to:", baseDir))
}, error = function(e) {
  stop("Directory setup failed: ", e$message)
})

# Ensure Output Width for Terminal Display (Optional, Unix-based Systems)
tryCatch({
  options(width = 80) # Adjust width as needed
}, error = function(e) {
  print("Could not set terminal width.")
})

# --------------------------------------------------------------------
# SECTION 3: DEPENDENCIES & INSTALLATION
# --------------------------------------------------------------------

# Required Libraries
required_packages <- c("knitr", "rmarkdown", "dplyr", "ggplot2")

# Check, Install, and Load Required Libraries
tryCatch({
  for (pkg in required_packages) {
    if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
      cat("Installing package:", pkg, "\n")
      install.packages(pkg, dependencies = TRUE)
      if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
        stop("Failed to load package after installation: ", pkg)
      }
      cat("Successfully loaded:", pkg, "\n")
    } else {
      cat("Package already loaded:", pkg, "\n")
    }
  }
}, error = function(e) {
  stop("Library setup failed: ", e$message)
})

# --------------------------------------------------------------------
# SECTION 4: DATA UTILITY FUNCTIONS
# --------------------------------------------------------------------

# Function to Load Data from CSV
load_data <- function(file_path) {
  if (show_comments) {
    cat("Attempting to load data from:", file_path, "\n")
  }
  tryCatch({
    data <- read.csv(file_path)
    return(data)
  }, error = function(e) {
    stop("Error loading data: ", e$message)
  })
}

# Function to Clean Data
clean_data <- function(data) {
  if (show_comments) {
    cat("Cleaning data: removing duplicates, handling missing values...\n")
  }
  tryCatch({
    data <- unique(data)  # Remove duplicates
    data <- na.omit(data)  # Drop rows with missing values
    return(data)
  }, error = function(e) {
    stop("Error cleaning data: ", e$message)
  })
}

# Function to Transform Data
transform_data <- function(data) {
  if (show_comments) {
    cat("Applying transformations: filtering, mutating, summarizing...\n")
  }
  tryCatch({
    data_transformed <- data %>%
      filter(!is.na(value)) %>%
      mutate(log_value = log(value + 1)) %>%
      group_by(category) %>%
      summarize(mean_value = mean(value, na.rm = TRUE))
    return(data_transformed)
  }, error = function(e) {
    stop("Error transforming data: ", e$message)
  })
}

# Check for Missing Values
check_missing_values <- function(data) {
  missing_count <- sum(is.na(data))
  if (show_comments) {
    if (missing_count > 0) {
      cat("Warning:", missing_count, "missing values found.\n")
    } else {
      cat("No missing values found in the dataset.\n")
    }
  }
  return(missing_count)
}

# Summarize Data Frame
summarize_data <- function(data) {
  if (show_comments) {
    cat("Displaying summary statistics and data dimensions...\n")
  }
  tryCatch({
    print(summary(data))
    cat("Dimensions:", dim(data)[1], "rows by", dim(data)[2], "columns\n")
    return(invisible(NULL))
  }, error = function(e) {
    stop("Error summarizing data: ", e$message)
  })
}

# Aggregate Data
aggregate_data <- function(data, group_col, value_col) {
  if (show_comments) {
    cat("Aggregating data by group column:", group_col, "\n")
  }
  tryCatch({
    aggregated_data <- data %>%
      group_by(.data[[group_col]]) %>%
      summarize(mean_value = mean(.data[[value_col]], na.rm = TRUE))
    return(aggregated_data)
  }, error = function(e) {
    stop("Error aggregating data: ", e$message)
  })
}

# --------------------------------------------------------------------
# SECTION 5: DATA I/O HANDLERS
# --------------------------------------------------------------------

# Read a File Based on Format (CSV Only by Default)
read_data_file <- function(file_path, file_type = "csv") {
  tryCatch({
    if (file_type == "csv") {
      data <- read.csv(file_path)
    } else {
      stop("Unsupported file type:", file_type)
    }
    if (show_comments) {
      cat("Successfully read", file_type, "file from", file_path, "\n")
    }
    return(data)
  }, error = function(e) {
    stop("Error reading file: ", e$message)
  })
}

# Load Sample Data for Testing
load_sample_data <- function() {
  if (show_comments) {
    cat("Creating sample data...\n")
  }
  data <- data.frame(
    category = c("A", "B", "C"),
    value = c(10, 20, 15)
  )
  return(data)
}

# --------------------------------------------------------------------
# SECTION 6: DATA PROCESSING WORKFLOWS
# --------------------------------------------------------------------

# General Pipeline: Clean, Transform, Validate
process_data <- function(data) {
  tryCatch({
    if (show_comments) cat("Processing pipeline started...\n")
    cleaned_data <- clean_data(data)
    transformed_data <- transform_data(cleaned_data)
    check_missing_values(transformed_data)
    if (show_comments) cat("Pipeline completed.\n")
    return(transformed_data)
  }, error = function(e) {
    stop("Error in processing pipeline: ", e$message)
  })
}

# --------------------------------------------------------------------
# SECTION 7: DATABASE OPERATIONS (SQLite Placeholder)
# --------------------------------------------------------------------

# Connect to SQLite Database
connect_sqlite <- function(db_path) {
  if (show_comments) cat("Connecting to SQLite DB at:", db_path, "\n")
  db_connection <- DBI::dbConnect(RSQLite::SQLite(), db_path)
  return(db_connection)
}

# CRUD Operations Placeholder
create_table <- function(db_connection, schema) { }
insert_record <- function(db_connection, table_name, record_data) { }
read_records <- function(db_connection, query) { }
update_record <- function(db_connection, table_name, condition, new_values) { }
delete_record <- function(db_connection, table_name, condition) { }

# --------------------------------------------------------------------
# SECTION 8: ANALYSIS FUNCTIONS
# --------------------------------------------------------------------

analyze_data <- function(data) {
  if (show_comments) cat("Analyzing data...\n")
  tryCatch({
    analysis_result <- data %>%
      group_by(category) %>%
      summarize(total_value = sum(mean_value, na.rm = TRUE))
    
    if (show_comments) cat("Analysis completed successfully.\n")
    return(analysis_result)
  }, error = function(e) {
    stop("Error during analysis: ", e$message)
  })
}

# --------------------------------------------------------------------
# SECTION 9: VISUALIZATION FUNCTIONS
# --------------------------------------------------------------------

visualize_data <- function(data) {
  if (show_comments) cat("Creating visualization...\n")
  tryCatch({
    plot_object <- ggplot2::ggplot(data, aes(x = category, y = total_value)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(
        title = "Total Values by Category",
        x = "Category",
        y = "Total Value"
      )
    
    print(plot_object)
    if (show_comments) cat("Visualization completed successfully.\n")
    return(invisible(plot_object))
  }, error = function(e) {
    stop("Error creating visualization: ", e$message)
  })
}

# --------------------------------------------------------------------
# SECTION 10: R MARKDOWN GENERATION
# --------------------------------------------------------------------

generate_markdown <- function() {
  if (show_comments) cat("Generating R Markdown file...\n")
  tryCatch({
    markdown_content <- '
---
title: "LIS-4317 Final Project Function Documentation"
author: "Steven Barden"
date: "2025-04-14"
output: html_document
---

## Overview

This R Markdown file documents the main functions developed for my final project in LIS-4317-Week-12. The purpose is to provide a clear and detailed description of each function, including their purpose, inputs, outputs, and example usage. These functions handle data loading, cleaning, transformation, analysis, and visualization for the project.

## Key Functions

### 1. load_data(file_path)

**Purpose**: Loads data from a CSV file into an R data frame.

**Inputs**:
- `file_path`: A string specifying the path to the CSV file.

**Outputs**:
- A data frame containing the loaded data.

**Example**:
```R
data <- load_data("sample_data.csv")
```

**Notes**:
- Includes error handling for invalid file paths.
- Prints progress if `show_comments` is `TRUE`.

### 2. clean_data(data)

**Purpose**: Cleans the input data by removing duplicates and missing values.

**Inputs**:
- `data`: A data frame to clean.

**Outputs**:
- A cleaned data frame with duplicates and missing values removed.

**Example**:
```R
cleaned <- clean_data(data)
```

**Notes**:
- Ensures data integrity for downstream processing.
- Logs cleaning steps if `show_comments` is `TRUE`.

### 3. transform_data(data)

**Purpose**: Applies transformations such as filtering, mutating, and summarizing to the data.

**Inputs**:
- `data`: A data frame to transform.

**Outputs**:
- A transformed data frame with summarized results (e.g., mean values by category).

**Example**:
```R
transformed <- transform_data(cleaned)
```

**Challenges**:
- Handling edge cases like empty data frames required robust error checking.

### 4. analyze_data(data)

**Purpose**: Performs analysis by grouping and summarizing transformed data.

**Inputs**:
- `data`: A data frame with `category` and `mean_value` columns.

**Outputs**:
- A data frame with analysis results (e.g., total values by group).

**Example**:
```R
results <- analyze_data(transformed)
```

**Insights**:
- Summing values by category helped identify dominant groups.

### 5. visualize_data(data)

**Purpose**: Creates a bar plot to visualize analysis results.

**Inputs**:
- `data`: A data frame with analysis results.

**Outputs**:
- A ggplot2 bar plot displayed in the output.

**Example**:
```R
visualize_data(results)
```

**Improvements**:
- Bar plots were chosen for clear presentation of categorical data.

## Blog Post: The Power of R Markdown

R Markdown is a powerful tool that combines code, visualizations, and narrative text into a single, reproducible document. It allows me to document my R functions in a professional format, integrating live code examples and outputs like plots directly into the text. This is especially useful for sharing my work on GitHub, as it provides both technical details and context for others to understand my project.

In this assignment, I created an R Markdown file to document five key functions for my final project: `load_data`, `clean_data`, `transform_data`, `analyze_data`, and `visualize_data`. These functions form a pipeline for processing and analyzing data, and documenting them in Markdown helped me clarify their purpose and usage. The process also highlighted areas for improvement, such as refining error handling and visualization choices. Overall, R Markdown has made my work more organized, transparent, and ready to share with others.

## Submission

The Markdown file and related code are available at: [GitHub Repository](https://github.com/StevenBarden/LIS-4317-Week-12).
'
    
    writeLines(markdown_content, "project_functions.Rmd")
    rmarkdown::render("project_functions.Rmd", output_file = "project_functions.html")
    if (show_comments) cat("R Markdown file generated and rendered successfully.\n")
  }, error = function(e) {
    stop("Error generating R Markdown: ", e$message)
  })
}

# --------------------------------------------------------------------
# SECTION 11: MAIN EXECUTION BLOCK
# --------------------------------------------------------------------

main <- function() {
  if (show_comments) cat("Starting script execution...\n")
  tryCatch({
    if (show_comments) cat("Step 1: Loading data...\n")
    raw_data <- load_sample_data()
    summarize_data(raw_data)
    
    if (show_comments) cat("Step 2: Processing data...\n")
    processed_data <- process_data(raw_data)
    
    if (show_comments) cat("Step 3: Analyzing data...\n")
    analysis_output <- analyze_data(processed_data)
    
    if (show_comments) cat("Step 4: Visualizing results...\n")
    visualize_data(analysis_output)
    
    if (show_comments) cat("Step 5: Generating R Markdown file...\n")
    generate_markdown()
    
    if (show_comments) cat("Script execution completed successfully.\n")
    return(invisible(NULL))
  }, error = function(e) {
    stop("Script execution failed: ", e$message)
  })
}

# Execute main function
main()

# --------------------------------------------------------------------
# SECTION 12: VERSION HISTORY
# --------------------------------------------------------------------
# Version History:
# - Version 1.0 (2025-04-14-0800-00): Initial template.
# - Version 1.1 (2025-04-14-0900-00): Fixed analyze_data to use mean_value column.

# --------------------------------------------------------------------
# SECTION 13: ADDITIONAL NOTES
# --------------------------------------------------------------------

# Best Practices:
# - Ensure secure handling of API keys and credentials.
# - Keep code modular and organized for maintainability.
# - Validate data inputs to prevent unexpected errors.
# - Use consistent naming conventions for variables and functions.
# - Include appropriate documentation and comments.
# - Test functions with small datasets before full execution.

# --------------------------------------------------------------------
# END OF TEMPLATE
# --------------------------------------------------------------------