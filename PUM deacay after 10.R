PUM5 = function(n_experiments){
  #n_experiments = 100
  
  for (j in 1:n_experiments){
    urn_size = 2                                         # inital urn size
    urn = rep(c('blue', 'red'), each = urn_size/2)       # fill urn
    n_picks = 200                                        # set amount of balls drawn
    
    fraction_blue = vector()                             # initialize fraction of blue balls
    fraction_red = vector()                              # initialize fraction of red balls
    
    for (i in 1:n_picks){                                 
      pick = sample(urn,1)                               # pick a random ball
      urn[length(urn)+1] = pick                          # add this ball to urn
      
      if (i %% 10 == 0){                                 # after each 10 picks
        urn[-sample(length(urn),5)]                      # delete 5 random element form urn
      }
      
      fraction_blue[i] = sum(urn == 'blue')/length(urn)  # calculate fraction red and store
      fraction_red[i] = sum(urn == 'red')/length(urn)    # calculate fraction blue and store
    }
    
    if (j == 1){                                         # plot colour fractions
      plot(fraction_blue,ylab = 'Fraction Blue',xlab = 'picks',ylim = c(0,1), type = 'l')
    }else{
      points(fraction_blue,type = 'l', col=colorRampPalette(sample(2:9,2), alpha = TRUE)(n_experiments-1))
    }
  }
}