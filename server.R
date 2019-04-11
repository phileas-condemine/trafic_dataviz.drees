
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$my_plot <- renderPlotly({
        req(input$apps_to_show)
        apps=sheets[2:3]
        apps=input$apps_to_show
        rapports=lapply(apps,function(sheet){
            rapport=read_xlsx("rapports.xlsx",sheet = sheet)
            rapport=rapport[-c(1:13),]
            names(rapport) <- rapport[1,]
            rapport=rapport[-c(1),]
            rapport %<>% mutate(Date=as.Date(as.numeric(Date),origin = "1899-12-30"),Users=as.numeric(Users),app=sheet)
            rapport[cumsum(rapport$Users)>0,]
            
        })
        rapports=rbindlist(rapports)
        
        g <- ggplot(rapports,aes(x=Date,y=Users,color=app))+geom_line()
        ggplotly(g)
        
    })

})