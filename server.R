library(shiny)
library(ggplot2)

server <- function(input, output){
  
  #####################################################################################################
  
  # Plot for standard model  
  fraction_blue = reactive({
    
    if (input$urn_size == 11 & input$n_picks == 8 & input$n_experiments == 92){    # easter egg
      
      df_fractions = 2
      myRefUpper <- setNames(65:90, LETTERS)
      myRefLower <- setNames(97:122, letters)
      output$plot1 = renderPlot({
        plot(1:13, 1:13, type="p", pch=c(myRefUpper["H"], myRefLower[c("a", "p", "p", "y")], myRefUpper["B"],myRefLower[c("i", "r", "t", "h", "d", "a", "y")]),ann = F,axes = F)
      })
      
    }else{
      
      df_fractions = data.frame()
      for( j in 1:input$n_experiments){
        
        urn = rep(c('blue', 'red'), each = input$urn_size/2)
        fraction_blue_ = vector()
        for (i in 1:input$n_picks){                                 
          pick = sample(urn,1)                                # pick a random ball
          urn[length(urn)+1] = pick                           # add this ball to urn
          fraction_blue_[i] = sum(urn == 'blue')/length(urn)  # calculate fraction red and store
        }
        df_fractions[1:length(fraction_blue_),j] = fraction_blue_
      }
    }
    return(df_fractions)
  })
  
  #####################################################################################################
  
  # Plot for learning model  
  fraction_blue2 = reactive({
    
    df_fractions = data.frame()
    
    for( j in 1:input$n_experiments2){
      
      urn = rep(c('blue', 'red'), each = input$urn_size2/2)
      fraction_blue_ = vector()
      for (i in 1:input$n_picks2){                                 
        pick = sample(urn,1)                               # pick a random ball
        if (pick == 'blue'){                               # if pick is blue:
          urn[length(urn)+1:input$extra_balls] = pick      # add 1 + input amount of balls
        }else{                                             # if pick is red:
          urn[length(urn)+1] = pick                        # add 1
        }
        fraction_blue_[i] = sum(urn == 'blue')/length(urn)  # calculate fraction blue and store
      }
      df_fractions[1:length(fraction_blue_),j] = fraction_blue_
    }
    return(df_fractions)
    return(c(0.1,0.5))
  })
  
  #####################################################################################################
  
  # Plot for streak model
  fraction_blue3 = reactive({
    
    df_fractions = data.frame()
    
    for( j in 1:input$n_experiments3){
      
      urn = sample(rep(c('blue', 'red'), each = input$urn_size3/2))
      fraction_blue_ = vector()
      for (i in 1:input$n_picks3){                                 
        pick = sample(urn,1)                               # pick a random ball
        urn[length(urn)+1] = pick                          # add this ball to urn
        if (identical(tail(urn,input$streak),rep(pick, input$streak))){     # if last [input] picks are equal = put in [input] extra
          urn[length(urn)+1:input$extra_balls3] = pick
        }
        fraction_blue_[i] = sum(urn == 'blue')/length(urn)  # calculate fraction blue and store
      }
      df_fractions[1:length(fraction_blue_),j] = fraction_blue_
    }
    return(df_fractions)
  })
  
  #####################################################################################################
  
  # Plot for life event model
  fraction_blue4 = reactive({
    
    df_fractions = data.frame()
    drastic_trauma = as.numeric(input$drastic_trauma)
    
    for( j in 1:input$n_experiments4){
      
      urn = sample(rep(c('blue', 'red'), each = input$urn_size4/2))
      fraction_blue_ = vector()
      for (i in 1:input$n_picks4){                                 
        pick = sample(urn,1)                                # pick a random ball
        urn[length(urn)+1] = pick                           # add this ball to urn
        fraction_blue_[i] = sum(urn == 'blue')/length(urn)  # calculate fraction blue and store
        if (i == input$occ_trauma){
          urn = urn[1:(length(urn) - (length(urn)/100)*drastic_trauma)]
          #urn[(length(urn)-(length(urn)*(drastic_trauma/100))):length(urn)] = 'red'   # input van maken red or blue?, drastic_trauma or random zetten tussen 30 en 80 % van alle totale picks?
          #urn[(length(urn)-(length(urn)*(drastic_trauma/100))):length(urn)] = sample(c('blue','red'),1)
          sample(urn)                                       # shuffle urn
        }
      }
      df_fractions[1:length(fraction_blue_),j] = fraction_blue_
    }
    return(df_fractions)
  })
  
  #####################################################################################################
  
  # Plot for decay model  
  fraction_blue5 = reactive({
    
    df_fractions = data.frame()
    
    for( j in 1:input$n_experiments5){
      
      urn = rep(c('blue', 'red'), each = input$urn_size5/2)
      fraction_blue_ = vector()
      for (i in 1:input$n_picks5){                                 
        pick = sample(urn,1)                                # pick a random ball
        urn[length(urn)+1] = pick                           # add this ball to urn
        if (i %% input$many_picks == 0){                    # after each [imput] picks
          urn[-sample(length(urn),(input$much_decay))]      # delete [imput] random element form urn
        }
        
        fraction_blue_[i] = sum(urn == 'blue')/length(urn)  # calculate fraction red and store
      }
      df_fractions[1:length(fraction_blue_),j] = fraction_blue_
    }
    return(df_fractions)
  })
  
  #####################################################################################################
  
  # Plot for test page 
  fraction_blue6 = observeEvent(input$start, {
    fraction_blue5()
  })
  
  # Idea : choose an ending position (fraction), try to simulate it
  
  #####################################################################################################
  
  # Output 1
  output$plot1 = renderPlot({
    matplot(fraction_blue(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary1 = renderText('In the basic Pólya urn model, the urn contains x white and y black balls; one ball is drawn randomly from the urn and its color observed; it is then returned in the urn, and an additional ball of the same color is added to the urn, and the selection process is repeated.')
  
  # Output 2  
  output$plot2 = renderPlot({
    matplot(fraction_blue2(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary2 = renderText('In this version of the model, the colour bleu represents a good experience. In order to simulate the effects of positive experiences on behaviour, whenever a blue ball is picked from the urn, 2 additional balls will be put back inside. As opposed to the colour red where only 1 additional ball will be put back in.')
  
  # Output 3
  output$plot3 = renderPlot({
    matplot(fraction_blue3(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary3 = renderText('Now, it could be possible that if you had a certain few experiences in a row, they would amplify each other. For instance, having multiple good practice experiences in a row would be more beneficial than these experiences in sepeartion. However, experiencing multiple failures in a row could also be harmfull, perhaps demotivating someone or creating a stressful situation.')
  
  # Output 4
  output$plot4 = renderPlot({
    matplot(fraction_blue4(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary4 = renderText('What if you were unlucky and sufferd from a headtrauma and you would lose a few past experiences?')
  
  # Output 5
  output$plot5 = renderPlot({
    matplot(fraction_blue5(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary5 = renderText('Some decay story...')
  
  # Output 6
  output$plot6 = renderPlot({
    matplot(fraction_blue6(),ylab = 'Fraction Blue',xlab = 'picks', ylim = c(0,1),type = 'l',lty = 1, lwd = 2)
  })
  output$summary6 = renderText('Now to put our knowledge to the test... Lets generate a random model and try to estimate it with the given parameters. Press the generate button to start...')
}

shinyApp(ui = ui, server = server)
