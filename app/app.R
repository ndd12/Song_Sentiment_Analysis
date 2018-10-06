library(shiny)
source("Dataset.r")
ui <- fluidPage(
  titlePanel("Song Sentiment Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Let Us Help You Find Your New Favorite Song"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Happy","Sad","Love","Dance"),
                  selected = "Dance"),
      textInput("band",
                label = "Enter a Band or Artist Name",
                placeholder="Band Name"),
      textInput("song",
                label = "Enter a song Title",
                placeholder = "Song Title"),
      submitButton(text= "Generate Info")
    ),
    mainPanel(
      textOutput("selected_var"),
      textOutput("selected_var_2")
    )
  )
)
#Define server logic to plot various variables against mpg

server <- function(input,output){
  output$selected_var <- renderText({ 
    paste("You Searched for the Artist ", input$band)
  })
  output$selected_var_2 <- renderText({
    paste("You Searched for the Song", input$song)
  })
  scrapeLyrics()
}

shinyApp(ui,server)
