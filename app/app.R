library(shiny)
library(reticulate)
source("webScrape/webScrape.R")
source_python("lyricProccessing/processLyrics.py")
py_available()


ui <- fluidPage(
  titlePanel("Song Sentiment Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Let Us Help You Find Your New Favorite Song"),
      textInput("band",
                label = "Enter a Band or Artist Name",
                placeholder="Band Name"),
      textInput("song",
                label = "Enter a song Title",
                placeholder = "Song Title"),
      sliderInput("happiness",
                  label = "Happiness",
                  min=0, max=10, value=5
                  ),
      sliderInput("sadness",
                  label = "Sadness",
                  min=0, max=10, value=5),
      submitButton(text= "Generate Info")
    ),
    mainPanel(
      textOutput('selected_var_3'),
      plotOutput("distPlot")
    )
  )
)
#Define server logic to plot various variables against mpg

server <- function(input,output){
  output$selected_var_3 <- renderText({
    paste(scrapeLyrics(input$band,input$song))
  })
  output$distPlot <- renderPlot({
    data <- c(input$happiness , input$sadness)
    barplot(data, xlab="Happiness")
  })
}
scrapeLyrics(input$band,input$song)
shinyApp(ui,server)
