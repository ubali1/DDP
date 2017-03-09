library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Relationship between compound Ki and Ligand EC50"),
  sidebarPanel(
    tabsetPanel(
      tabPanel("Ki Plot", 
        sliderInput('IC50', 'Slide to change IC50 concentration',value = 10, min = 0, max = 1000, step = 5),
        sliderInput('user_EC50', 'Slide to change EC50 concentration',value = 20, min = 0, max = 100, step = 5),
        sliderInput('ligand', 'Slide to enter the ligand concentration',value = 50, min = 0, max = 100, step = 5)
        #actionButton("goButton", "Calculate")
      ), #end tabPanel 1
      tabPanel("Fractional Occupancy Plot",
        sliderInput('antagonist', 'Slide to enter the antagonist concentration [B]',value = 5, min = 0, max = 100, step = 5),
        sliderInput('KB', 'Slide to enter the antagonist KB',value = 20, min = 0, max = 100, step = 5)
        )#end tabPanel 2
    )#end tabsetPanel
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Ki Plot",
        p('Your IC50 value is:'),
        textOutput('IC50'),
        p('Your EC50 value is:'),
        textOutput('user_EC50'),
        p('Your ligand concentration is:'),
        textOutput('ligand'),
        p('Receptor occupancy at stated concentrations is:'),
        textOutput('rocc'),
        p('Plot of Ki and Ligand EC50'),
        plotOutput('Ki_ligand_plot')
      ), #end tabPanel
      tabPanel("Fractional Occupancy Plot",
        p('The antagonist concentration you entered is:'),
        textOutput('antagonist'),
        p('The antagonist KB you entered is:'),
        textOutput('KB'),
       # p('The EC50 of your ligand is:'),
       #textOutput('user_EC50'),
        p('Plot of fractional receptor occupancy in the presence of antagonist [B]'),
        plotOutput('KB_plot')
      )#end tabPanel
    )#end tabsetPanel
  ) #end mainPanel
))