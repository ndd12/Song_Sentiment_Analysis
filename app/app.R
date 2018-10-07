library(shiny)
library(reticulate)
source("webScrape/webScrape.R")
use_python("C:\ Python37")
source_python("classifier/PredictRInterface.py")
source_python("classifier/predict.py")
source_python("classifier/processL")


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
      submitButton(text= "Generate Info")
    ),
    mainPanel(
      textOutput('selected_var_3'),
      plotOutput("distPlot")
    )
  )
)

server <- function(input,output){
  output$selected_var_3 <- renderText({
    scrapeLyrics(input$band,input$song)
  })
  output$distPlot <- renderPlot({
    data <- c(input$happiness , 10-(input$happiness))
    barplot(data, 
            col=c("yellow","blue"),
            xlab = "Emotion", names = c("Happiness", "Sadness"),
            horiz = TRUE
            )
  })
}

shinyApp(ui,server)
