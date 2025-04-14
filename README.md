# LIS-4317 Module 12: R Markdown Documentation

## Overview

This repository contains my work for Module 12 of LIS-4317 R Programming for Data Science. The project involves creating an R Markdown file to document a data processing pipeline for my final project, including a blog post on R Markdown's benefits. The pipeline handles data loading, cleaning, transformation, analysis, and visualization.

## Key Features

- **Data Pipeline**: Functions to load, clean, transform, analyze, and visualize sample data (categories A, B, C with values).
- **R Markdown Documentation**: Detailed documentation of each function in `project_functions.Rmd`, rendered to `project_functions.html`.
- **Blog Post**: A section in the R Markdown file discussing R Markdown's role in reproducibility and sharing.
- **Sample Data**: Simple dataset with categories and values for testing the pipeline.

## Usage

1. **Prerequisites**: Ensure R and RStudio are installed, along with required packages (`knitr`, `rmarkdown`, `dplyr`, `ggplot2`).
2. **Run the Script**:
   - Clone this repository.
   - Open `LIS-4317-Week-12.R` in RStudio.
   - Run the script to execute the pipeline and generate the R Markdown output.
3. **View Documentation**:
   - Open `project_functions.html` in a browser to see the documented functions and blog post.
   - Alternatively, re-render `project_functions.Rmd` using `rmarkdown::render("project_functions.Rmd")`.

## Files

- `LIS-4317-Week-12.R`: Main R script with the data pipeline and Markdown generation.
- `project_functions.Rmd`: R Markdown source file documenting the functions and blog post.
- `project_functions.html`: Rendered HTML output of the documentation.

## Reflection

This project taught me the value of R Markdown for reproducible documentation. Debugging the pipeline improved my understanding of data flow in R, and using Markdown enhanced my ability to present code clearly. Future improvements could include testing with more complex datasets.

## Links

- **Course**: LIS-4317 R Programming for Data Science
- **GitHub Repository**: [https://github.com/StevenBarden/LIS-4317-Week-12](https://github.com/StevenBarden/LIS-4317-Week-12)
