#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
dashboardPage(
    tags$header(class = "main-header", span(class = "logo",style="background: #1263b3;", "Trafic dataviz.drees"),
                tags$nav(class = "navbar navbar-static-top",style="background: #0253a3;",
                         role = "navigation", span(shiny::icon("bars"), style = "display:none;"),
                         a(href = "#", class = "sidebar-toggle", `data-toggle` = "offcanvas",
                           role = "button", span(class = "sr-only", "Toggle navigation")),
                         div(class = "navbar-custom-menu",
                             tags$ul(class = "nav navbar-nav",
                                     tags$li(id="logo_ministere",
                                             a(tags$i(class="fa icon_ministere text-success vert_center"),"Ministère",href="http://solidarites-sante.gouv.fr/",
                                               target="_blank")),
                                     tags$li(id="logo_drees",
                                             a(tags$i(class="fa icon_drees text-success vert_center"),"DREES",href="http://drees.solidarites-sante.gouv.fr/etudes-et-statistiques/",
                                               target="_blank")),
                                     tags$li(id="Github",
                                             a(tags$i(class="fa icon_github text-success vert_center"),"Code Source",href="https://github.com/phileas-condemine/trafic_dataviz.drees",
                                               target="_blank"))
                                     
                             ))),
                includeCSS("www/my_styles.css")
                
                
    ),
    
    dashboardSidebar(sidebarMenu(id="sidebarmenu",
                  selectInput(inputId="apps_to_show",label="Application à analyser",
                              choices=sheets,multiple=T,selected=sheets)%>%
                      shinyInput_label_embed(
                                  icon("question-circle") %>%
                                      bs_embed_tooltip(title = 
                        "Choisissez la ou les applications dont vous souhaitez connaître la fréquentation.")
                              ),
                  dateRangeInput(inputId="date_range",label="Section temporelle",
                                 start = "2018-01-01",end = NULL,format = "dd-mm-yyyy",
                                 language = "fr",separator = "à",startview = 1)
                  ),
                     includeHTML("logos.html")
                     
                     
    ),
    
    dashboardBody(
        div(style="margin-bottom:50px",shinycssloaders::withSpinner(plotlyOutput("my_plot",height="600px"),size=2)),
        includeHTML("footer.html")
    
    )
    
    
    
)