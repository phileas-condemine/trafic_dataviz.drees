## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- fluidPage(
    dateRangeInput("daterange1", "Date range:",
                   start = "2001-01-01",
                   end   = "2010-12-31")%>%
      shinyInput_label_embed(
        icon("question-circle") %>%
          bs_embed_tooltip(title = "choose your date range dude !")
      )
    ,
    selectInput("date", "Date:",
                   choices = c("me","you"))%>%
    shinyInput_label_embed(
      icon("question-circle") %>%
        bs_embed_tooltip(title = "choose your date range dude !")
    )
    
    
  )
  
  shinyApp(ui, server = function(input, output) { })
}
