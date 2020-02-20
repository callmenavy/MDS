# EJERCICIO 3

library(shiny)

# UI
ui <- fluidPage(

    # titulo, tema
    titlePanel("Examen Shiny - Marina Ortin Fernandez"),
    theme = shinythemes::shinytheme('united'),

    # layout y sidepanel 
    sidebarLayout(
        sidebarPanel(
            actionButton(inputId = "guardar",
                         label = "Guardar CSV"),
            actionButton(inputId = 'borrar',
                         label = 'Borrar CSV'),
            actionButton(inputId = 'leer',
                         label = 'Leer CSV')
        ),

        # respuesta
        mainPanel(
           tableOutput("table")
        )
    )
)

# Server
server <- function(input, output) {
    readingTable <- reactiveVal(NULL)
    
    output$table <- renderTable({
        readingTable()
})
    observeEvent(
        input$guardar, {
            datos <- data.frame('x' = rnorm(n = 20), 'y' = rnorm(n = 20))
            write.csv(datos, file = "datos.csv")
        },
        ignoreInit = T # No ejecutar al arrancar (apartado 4)
        
    )
    
    # borrar
    observeEvent(
        input$borrar,
        {file.remove('datos.csv')},
        
        ignoreInit = T # No ejecutar al arrancar (apartado 4)
    )
    
    # leer
    observeEvent(
        input$leer,
        {misDatos <- read.csv('datos.csv')
        print(misDatos)
        readingTable(misDatos)
        },
        
        ignoreInit = T # No ejecutar al arrancar (apartado 4)
        
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
