shinyServer(
  function(input, output) {
    
    # outputting user defined parameters
    output$IC50 <- renderText({input$IC50})
    output$user_EC50 <- renderText({input$user_EC50})
    output$ligand <- renderText({input$ligand})
    output$antagonist <- renderText({input$antagonist})
    output$KB <- renderText({input$KB})
        
    #outputting receptor occupancy value based on ligand concentration and Ligand Kd which is user_EC50
      output$rocc <- renderText({
      #input$goButton
      calc <- (input$ligand/(input$ligand + input$user_EC50))
      paste(round(calc,2)*100)
    })
    
      #preparing reactive plot for outputting plot of Ki/IC50 vs Ligand/EC50
      output$Ki_ligand_plot <- renderPlot({
      library(ggplot2)
      EC50 <- seq(from = 1, to = 500, by = 5)
      x_axis <- log10((input$ligand/EC50))
      y_axis <- ((input$IC50/(1+(input$ligand/EC50)))/input$IC50)
      mu <- log(input$ligand/input$user_EC50)
        
      #plot(x_axis, y_axis, type='l',lwd=1, lxlab='Log{[ligand/EC50]}', ylab = 'Ki/IC50', col='blue',main='Relationship between compound Ki and Ligand EC50')
      qplot(x_axis, y_axis, geom = "smooth", xlab='Log{[ligand/EC50]}', ylab = 'Ki/IC50', color='red',main='Relationship between compound Ki and Ligand/EC50') + geom_vline(xintercept = mu, col = "dodgerblue3", lty="dotdash") + geom_text(aes(x=mu+0.05, label="Log{[Ligand/EC50]}", y=0.65), colour="blue", angle=90, text=element_text(size=11))
    })
    
    
    #preparing reactive plot for outputting plot of fractional occupancy vs Ligand
    output$KB_plot <- renderPlot({
      library(ggplot2)
      
      drug <- seq(from = 1, to = 500, by = 5)
      
      B_factor <- (1 + (input$antagonist/input$KB))
      
      x_axis <- log10(drug)
      y_axis <- (drug/(input$user_EC50*B_factor + drug))
        
      qplot(x_axis, y_axis, geom = "smooth", xlab='Log[ligand]', ylab = 'Fractional Occupancy', color='red',main='Relationship between Ligand and fractional occupancy in the presence of antagonist [B]')
      
      
      #mu <- input$mu
      #lines(c(0, 0), c(0, 1),col="red",lwd=1)
      #mse <- mean((galton$child - mu)^2)
      #text(63, 150, paste("mu = ", mu))
      #text(63, 140, paste("MSE = ", round(mse, 2)))
    })
  }
)