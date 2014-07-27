library(shiny)

#Show a fluidpage with title, sidebarpanel and main panel
shinyUI(fluidPage(
        titlePanel("Miles Per Gallon: exploring dataset"),
        sidebarLayout(            
                sidebarPanel(
                        img(src = "car2.jpg", height = 150, width = 220),
                        selectInput("numeric", "Dependent variable:",
                                    c("Miles/gallon" = "mpg",
                                      "Weight" = "wt")),
                        selectInput("variable", "Feature:",
                                    c("Cylinders" = "cyl",
                                      "Transmission" = "am",
                                      "Gears" = "gear")),
                        checkboxInput("showresults", "Show regression results", FALSE),
                        checkboxInput("showdiag", "Show diagnostics", FALSE),
                        checkboxInput("showresid", "Show residual density", FALSE),
                        img(src = "motortrend.jpg", height = 150, width = 220),
                        
                        helpText(a(href = "http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "Data description")),
                        helpText(a(href = "https://github.com/istvanilyes/Project-App", "Github repo")),
                        helpText("This app helps you to discover the basic buit-in R dataset mtcars.
                                 Above it is possible to choose which dependant variable and which factor to use.
                                 By default, you will see a boxplot with the chosen variables.
                                 After checking the Show regression results box, one can make the single variable regression results appear for the same variables as in the boxplot.
                                 It is also possible to call some diagnostics in table format.
                                 Plus one can call the density plot for the regression's residuals.
                                 Good discovering!")
                ),
                
                #Show: caption, boxplot, diagnostics, regression results and residual density on the main panel
                mainPanel(
                        
                        h3(textOutput("caption")),
                        plotOutput("mpgPlot"),
                        tableOutput("diagnostics"),
                        tableOutput("regresults"),
                        plotOutput("residPlot")
                )
        )
))
