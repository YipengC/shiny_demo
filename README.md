# Setup

To follow along with the demo, you can clone this repository and open the project 
in RStudio (File -> Open Project in New Session... -> navigate to shiny_demo.Rproj)


## Installing required packages into an renv environment
- RStudio should automatically create an renv environment with renv version 0.14.0
upon loading the project. If not, you 
can install renv using `install.packages("renv")`
- You can then install the required packages by calling `renv::restore()` in the 
RStudio console
- Note for Windows users: you may need to install Rtools (build tools) for the 
package installations. You can find the corresponding download for your R version here:
https://cran.r-project.org/bin/windows/Rtools/

## Running an app
The demo apps are located in the subfolders of `src`. You can launch them by opening
the `app.R` file in RStudio and clicking `Run App`, or by calling 
`shiny::runApp("<path/to/app.R>")` in the console.