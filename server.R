if (!("shiny" %in% names(installed.packages()[,"Package"]))) {install.packages("shiny")}
suppressMessages(library(shiny, quietly = TRUE))
library(datasets)
data(mtcars)

mtcars$am = factor(mtcars$am, levels=c(0, 1), labels=c("automatic", "manual"))
mtcars$cyl = factor(mtcars$cyl, levels=c(4, 6, 8),labels=c("4 cylinders", "6 cylinders", "8 cylinders"))
mtcars$gear = factor(mtcars$gear, levels=c(3, 4, 5), labels=c("3 forward gears", "4 forward gears","5 forward gears" ))

shinyServer(function(input, output) {
        
        formulaText <- reactive({
                paste(input$numeric, "~",input$variable)
        })
        
        linReg <- reactive({
                lm(as.formula(formulaText()), data=mtcars)
        })
        
        residuals <- reactive({
                resid(linReg())
        })
        
        # Print caption
        output$caption <- renderText({
                paste("Relationship between: ", formulaText())
        })
        
        # Descriptive boxplot
        output$mpgPlot <- renderPlot({
                boxplot(as.formula(formulaText()), 
                        data = mtcars,
                        varwidth = TRUE,
                        col = "red")
        })
        
        #regression results
        output$regresults <- renderTable({
                if (input$showresults) summary(linReg())
        })
        
        #diagnostics
        output$diagnostics <- renderTable({
                results <- summary(linReg())
                if (input$showdiag)
                data.frame(R2=results$r.squared,
                           adj.R2=results$adj.r.squared,
                           f.stat=results$fstatistic[3],
                           p=1-pf(results$fstatistic[1],
                                  results$fstatistic[2],
                                  results$fstatistic[3]))
        })
        
        #density plot for residuals
        output$residPlot <- renderPlot({
                dens<- density(residuals())
                if (input$showresid)
                plot(dens,
                     main="Density plot of residuals",
                     col="red",
                     lwd=2)
        })
        
})

