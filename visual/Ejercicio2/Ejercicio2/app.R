#EJERCICIO 2

library(shiny)
library(ggplot2)

# UI
ui <- fluidPage(
    
    titlePanel("Examen de Shiny - Marina Ortin Fernandez"),
    theme = shinythemes::shinytheme('united'),
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider",
                        "Numero de elementos",
                        min = 1,
                        max = 50,
                        value = 20,
                        step = 1),
            actionButton(inputId = "boton",
                         label = "Nuevo dataset")
        ),
        
        mainPanel(
            plotOutput("scatter1"),
            plotOutput('scatter2'),
            plotOutput('scatter3')
           
        )
    )
)

#SERVER
server <- function(input, output) {
    #scatterplot 1. 20 elementos, sin reactividad.
    output$scatter1 <- renderPlot({
        ggplot() + aes(x = rnorm(n = 20,
                                 mean = 0,
                                 sd = 1), 
                       y = rnorm(n = 20,
                                 mean = 0,
                                 sd = 1)) + geom_point()
    })
    
    #scatterplot2. Elementos determinados con sliderbar.
        
    output$scatter2 <- renderPlot({
        ggplot() + aes(x = rnorm(n = input$slider,
                                 mean = 0,
                                 sd = 1), 
                       y = rnorm(n = input$slider,
                                 mean = 0,
                                 sd = 1)) + geom_point()
    })
    #scatterplot3. Reactividad con botón.
        output$scatter3 <- renderPlot({
            input$boton
            isolate(ggplot() + aes(x = rnorm(n = input$slider, 
                                             mean = 0, 
                                             sd = 1), 
                                   y = rnorm(input$slider, 0, 1)) + geom_point())
})
}

shinyApp(ui = ui, server = server)