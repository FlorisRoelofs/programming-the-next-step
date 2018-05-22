library(shinydashboard)
library(shiny)

ui <- dashboardPage( skin = 'green',
  dashboardHeader(title = 'Tracing Memory Traces',titleWidth = 230),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Introduction' , tabName = 'nul', icon = icon('info-circle')),
      menuItem('Standard Model' , tabName = 'een', icon = icon('info-circle')),
      menuItem('Positive Feedback', tabName = 'twee',icon = icon('info-circle')),
      menuItem('Critical Moments', tabName = 'drie',icon = icon('info-circle')),
      menuItem('Life Events', tabName = 'vier',icon = icon('info-circle')),
      menuItem('Decay', tabName = 'vijf',icon = icon('info-circle')),
      menuItem('Testing', tabName = 'zes',icon = icon('gamepad'))
    )
  ),
  dashboardBody(
    tabItems(
      
      tabItem(tabName = 'nul', fluidRow(
        "", textOutput('summary0')
      )),
      
# tab 1 Standard Model 
      tabItem(tabName = 'een', fluidRow(
        box(numericInput("urn_size", "Starting Urn Size:", min = 2, max = 100, value = 2)),
        box(numericInput("n_picks", "Amount of Picks:", min = 2, max = 300,value = 100)),
        box(numericInput("n_experiments", "Amount of Experiments:", min = 1, max = 300,value = 100)),
        tabsetPanel(
          tabPanel("Summary", textOutput('summary1')),
          tabPanel("Plot",plotOutput('plot1')))
        )),
# tab 2 Positive Feedback    
      tabItem(tabName = 'twee', fluidRow(
        box(sliderInput("urn_size2", "Starting Urn Size:", min = 2, max = 100, value = 2)),
        box(sliderInput("n_picks2", "Amount of Picks:", min = 2, max = 300,value = 100)),
        box(sliderInput("n_experiments2", "Amount of Experiments:", min = 1, max = 300,value = 100)),
        box(numericInput("extra_balls", "Amount of Extra Balls", min = 1, max = 10,value = 1)),
        tabsetPanel(
          tabPanel("Summary", textOutput('summary2')),
          tabPanel("Plot",plotOutput('plot2')))
        )),
# tab 3 Critical Moments
      tabItem(tabName = 'drie', fluidRow(
        box(sliderInput("urn_size3", "Starting Urn Size:", min = 2, max = 100, value = 2)),
        box(sliderInput("n_picks3", "Amount of Picks:", min = 2, max = 300,value = 100)),
        box(sliderInput("n_experiments3", "Amount of Experiments:", min = 1, max = 300,value = 100)),
        box(numericInput("streak", "When will it be an Effective Streak?", min = 1, max = 10,value = 5)),
        box(numericInput("extra_balls3", "How many Extra Balls?", min = 0, max = 10,value = 0)),
        tabsetPanel(
          tabPanel("Summary", textOutput('summary3')),
          tabPanel("Plot",plotOutput('plot3')))
        )),
# tab 4 Life Events
        tabItem(tabName = 'vier', fluidRow(
          box(sliderInput("urn_size4", "Starting Urn Size:", min = 2, max = 100, value = 2)),
          box(sliderInput("n_picks4", "Amount of Picks:", min = 2, max = 300,value = 100)),
          box(sliderInput("n_experiments4", "Amount of Experiments:", min = 1, max = 300,value = 100)),
          box(numericInput("occ_trauma", "When did the Trauma occured?", min = 2, max = 250,value = 50)),
          box(selectInput("drastic_trauma", "How Drastic was the Trauma?",
                          c('Minor (lose last 25% experiences)' = 25,         # 5 last 5 % experiences -> red
                            'Intermediate (lose last 50% experiences)' = 50,  # 15 last 15% experiences -> red
                            'Major (lose last 75% experiences)' = 75))),      # 50 last 50% experiences -> red
          tabsetPanel(
            tabPanel("Summary", textOutput('summary4')),
            tabPanel("Plot",plotOutput('plot4')))
        )),
# tab 5 Decay
        tabItem(tabName = 'vijf', fluidRow(
          box(sliderInput("urn_size5", "Starting Urn Size:", min = 2, max = 100, value = 2)),
          box(sliderInput("n_picks5", "Amount of Picks:", min = 2, max = 300,value = 100)),
          box(sliderInput("n_experiments5", "Amount of Experiments:", min = 1, max = 300,value = 100)),
          box(numericInput("many_picks", "After how many Picks... (2-50):", min = 2, max = 50,value = 20)),
          box(numericInput("much_decay", "How much Decay? (1-20)", min = 1, max = 20,value = 5)),
          tabsetPanel(
            tabPanel("Summary", textOutput('summary5')),
            tabPanel("Plot",plotOutput('plot5')))
        )),
# tab 6 Testing
        tabItem(tabName = 'zes', fluidRow(
          box(actionButton("start", "Generate!")),
          #box(sliderInput("urn_size6", "Starting Urn Size:", min = 2, max = 100, value = 2)),
          #box(sliderInput("n_picks6", "Amount of Picks:", min = 2, max = 300,value = 100)),
          #box(sliderInput("n_experiments6", "Amount of Experiments:", min = 1, max = 300,value = 100)),
          #box(numericInput("many_picks6", "After how many Picks... (2-50):", min = 2, max = 50,value = 20)),
          #box(numericInput("much_decay6", "How much Decay? (1-20)", min = 1, max = 20,value = 5)),
          tabsetPanel(
            tabPanel("Summary", textOutput('summary6')),
            tabPanel("Plot",'Generated plot',plotOutput('plot6'),"Plot2",plotOutput('plot7')))
        ))
    )
  )
)

shinyApp(ui = ui, server = server)


