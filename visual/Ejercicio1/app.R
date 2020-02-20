# EJERCICIO 1
library(shiny)
library(ggplot2)

ui <- fluidPage(
    
    titlePanel("Examen de Shiny - Marina Ortin Fernandez"),
    theme = shinythemes::shinytheme('united'),
    
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "color",
                        label = "Choose your colour",
                        choices = list("grey" = "grey",
                                       "red" = "red",
                                       "blue" = "blue"))
        ),
        
        mainPanel(
            plotOutput("barplot"),

        )
    )
)

server <- function(input, output) {
    
    # En esta primera salida se crea el histograma
    output$barplot <- renderPlot({
        ggplot(data = mpg, mapping = aes(x = cyl)) +
            geom_bar(fill = input$color)

    })
}
# Run the application 
shinyApp(ui = ui, server = server)
