# implement streak (3 times)

PUM4 = function(n_experiments){
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
      if (identical(tail(urn,3),c(pick,pick,pick))){     # if last 3 picks are equal = put in doubles
        urn[length(urn)+1] = pick
        urn[length(urn)+1] = pick
        urn[length(urn)+1] = pick
      }
      fraction_blue[i] = sum(urn == 'blue')/length(urn)  # calculate fraction red and store
      fraction_red[i] = sum(urn == 'red')/length(urn)    # calculate fraction blue and store
      if (i == n_picks/2){
        urn[n_picks/4 : n_picks/2] = 'red'               # when at half point of all picks, 50% of all previous picks become blue
      }
    }
    
    if (j == 1){                                         # plot colour fractions
      plot(fraction_blue,ylab = 'Fraction Blue',xlab = 'picks',ylim = c(0,1), type = 'l')
    }else{
      points(fraction_blue,type = 'l', col=colorRampPalette(sample(2:9,2), alpha = TRUE)(n_experiments-1))
    }
  }
}