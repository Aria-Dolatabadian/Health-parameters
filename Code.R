library(shiny)
library(ggplot2)

# Define UI
ui <- fluidPage(
  titlePanel("Health Parameter Analysis"),
  sidebarLayout(
    sidebarPanel(
      numericInput("weight", "Weight (kg):", value = 0),
      numericInput("height", "Height (m):", value = 0),
      numericInput("age", "Age (years):", value = 0),
      selectInput("sex", "Sex:", choices = c("M", "F")),
      numericInput("rhr", "Resting Heart Rate (bpm):", value = 0),
      numericInput("waist", "Waist Circumference (cm):", value = 0),
      numericInput("hip", "Hip Circumference (cm):", value = 0),
      actionButton("calculate", "Calculate")
    ),
    mainPanel(
      textOutput("bmi_output"),
      textOutput("bmi_range_output"),
      textOutput("bmr_output"),
      textOutput("rhr_output"),
      textOutput("whr_output"),
      plotOutput("result_plot")
    )
  )
)

# Define server
server <- function(input, output) {
  observeEvent(input$calculate, {
    # Get input values
    weight <- input$weight
    height <- input$height
    age <- input$age
    sex <- input$sex
    rhr <- input$rhr
    waist <- input$waist
    hip <- input$hip
    
    # Calculate Body Mass Index (BMI)
    bmi <- weight / (height^2)
    
    # Calculate Basal Metabolic Rate (BMR) for different sexes
    if (toupper(sex) == "M") {
      bmr <- 10 * weight + 6.25 * height * 100 - 5 * age + 5
    } else if (toupper(sex) == "F") {
      bmr <- 10 * weight + 6.25 * height * 100 - 5 * age - 161
    } else {
      bmr <- NA
    }
    
    # Calculate Waist-to-Hip Ratio (WHR)
    whr <- waist / hip
    
    # Determine BMI range
    bmi_range <- ifelse(bmi < 18.5, "Underweight",
                        ifelse(bmi < 25, "Healthy Weight",
                               ifelse(bmi < 30, "Overweight", "Obese")))
    
    # Display the results
    output$bmi_output <- renderText(paste("Body Mass Index (BMI):", format(bmi, nsmall = 2)))
    output$bmi_range_output <- renderText(paste("BMI Range:", bmi_range))
    output$bmr_output <- renderText(paste("Basal Metabolic Rate (BMR):", format(bmr, nsmall = 2), "calories per day"))
    output$rhr_output <- renderText(paste("Resting Heart Rate (RHR):", rhr, "beats per minute"))
    output$whr_output <- renderText(paste("Waist-to-Hip Ratio (WHR):", format(whr, nsmall = 2)))
    
    # Create a bar plot
    result_data <- data.frame(Parameter = c("BMI", "BMR", "RHR", "WHR"),
                              Value = c(bmi, bmr, rhr, whr))
    
    result_plot <- ggplot(result_data, aes(x = Parameter, y = Value)) +
      geom_bar(stat = "identity", fill = "blue") +
      labs(x = "Health Parameters", y = "Values", title = "Health Parameter Analysis")
    
    output$result_plot <- renderPlot(result_plot)
  })
}

# Run the app
shinyApp(ui = ui, server = server)

