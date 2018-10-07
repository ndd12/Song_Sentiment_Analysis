library(shiny)
library(reticulate)
use_python("C:/Users/Josh/AppData/Local/Programs/Python/Python37/python.exe",required=TRUE)
source_python("../webScrape/webScrape2.py")

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
      actionButton(
        inputId = "submit_loc",
        label = "Submit"
      )
    ),
    mainPanel(
      textOutput('selected_var_3'),
      plotOutput("distPlot")
    )
  )
)

server <- function(input,output){
  observeEvent(
    eventExpr = input[["submit_loc"]],
    handlerExpr = {
       output$selected_var_3 <- renderText({
    paste(scrapeLyrics(input$band,input$song))
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
  )

}

shinyApp(ui,server)
