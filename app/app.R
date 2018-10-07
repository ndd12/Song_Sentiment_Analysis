library(shiny)
library(reticulate)
import("nltk")
source("webScrape/webScrape.R")
use_python("C:\ Python37")
source_python("classifier/preprocessLyrics.py")


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
    paste(process((scrapeLyrics(input$band,input$song))))
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
string1 <- scrapeLyrics(input$band,input$song)
strsplit(string1," ")[[1]]
shinyApp(ui,server)
