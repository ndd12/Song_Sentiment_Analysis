library(shiny)
library(shiny.router)
library(reticulate)
source("webScrape/webScrape.R")
source_python("classifier/test.py")

string1 <- scrapeLyrics(input$band,input$song)
strsplit(string1," ")[[1]]
shinyApp(ui,server)

# This creates UI for each page.
root_page <- function(title, content) {
  div(
    titlePanel(title),
    p(content)
  )
  titlePanel("Song Sentiment Analysis")
  
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
}

# This creates UI for each page.
spotify_page <- function(title, content) {
  div(
    titlePanel(title),
    p(content)
  )
}

# Both sample pages.
root_page <- root_page("Home page", "Welcome on sample routing page!")
spotify_page <- spotify_page("Some spotify page", "spotify")

# Callbacks on the server side for
# the pages
root_callback <- function(input, output, session) {
  # yeet
}

spotify_callback <- function(input, output, session) {
  print(input)
  print(output)
  print(session)
}

# Creates router. We provide routing path, a UI as
# well as a server-side callback for each page.
router <- make_router(
  route("/", root_page, root_callback),
  route("spotify", spotify_page, spotify_callback)
)

# Creat output for our router in main UI of Shiny app.
ui <- shinyUI(fluidPage(
  router_ui()
))

# Plug router into Shiny server.
server <- shinyServer(function(input, output, session) {
  router(input, output, session)
  
  output$selected_var_3 <- renderText({
    string1 <- (scrapeLyrics(input$band,input$song))
    paste(test(scrapeLyrics(input$band,input$song)))
  })
  output$distPlot <- renderPlot({
    data <- c(input$happiness , 10-(input$happiness))
    barplot(data, 
            col=c("yellow","blue"),
            xlab = "Emotion", names = c("Happiness", "Sadness"),
            horiz = TRUE
    )
  })
})

# Run server in a standard way.
shinyApp(ui, server)
