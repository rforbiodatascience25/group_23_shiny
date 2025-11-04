# Load needed libraries
library("shiny")
library('bslib')

# Load needed functions
source(file = "app_functions.R")

server <- function(input, output) {

  pipeline_results <- reactive({
    probs <- c(input$freq_a, input$freq_t, input$freq_c, input$freq_g)
    if (is.null(input$n_bases) || any(is.na(probs)) || abs(sum(probs) - 1) > 0.001) {
      # Return NULL or a list of errors if inputs are incomplete/invalid
      return(list(
        dna = "Waiting for valid inputs...",
        rna = "",
        aa = "",
        valid = FALSE
      ))
    }
    
    dna_sequence <- gene_dna(length = input$n_bases, base_probs = probs)
    rna_sequence <- transcribe_dna(dna_sequence) 
    aa_sequence <- translate_rna(rna_sequence) 
    list(
      dna = dna_sequence,
      rna = rna_sequence,
      aa = aa_sequence,
      valid = TRUE
    )
  })

  
  output$dna <- renderText({
    pipeline_results()$dna
  })
  
  output$rna <- renderText({
    pipeline_results()$rna
  })
  
  output$amino_acids <- renderText({
    pipeline_results()$aa
  })
  
  output$freqPlot <- renderPlot({
    results <- pipeline_results()
    
    if (!results$valid) {
      # Draw an empty plot or display an error if inputs are invalid
      plot(0, 0, type = 'n', axes = FALSE, xlab = "", ylab = "", 
           main = "Input Validation Required")
      return()
    }
    
    # Get data and plot
    data <- base_freqs(results$dna)
    
    barplot(
      height = data$Freq, 
      names.arg = data$dna_vec, 
      main = "Base Frequencies in Generated DNA",
      xlab = "DNA Base",
      ylab = "Count",
      col = "#66B3BA", 
      border = "white"
    )
  })
}


# server <- function(input, output) {
#   dna <- gene_dna(length = input$n_bases, base_probs = c(input$freq_a, input$freq_t, input$freq_c, input$freq_g))
#   rna <- translate_dna(dna)
#   aa <- translate_rna(rna)
#   
#   output$dna <- renderText({
#     dna
#     #gene_dna(length = input$n_bases, base_probs = c(input$freq_a, input$freq_t, input$freq_c, input$freq_g))
#   })
#   output$rna <- renderText({
#     rna
#     #translate_dna(dna = dna)
#   })
#   output$amino_acids <- renderText({
#     aa
#     #translate_rna(rna = output$rna)
#   })
#   output$freqPlot <- renderPlot({
#     
#     data <- base_freqs(dna)
#     barplot(
#       height = data$Freq, # The counts for the y-axis
#       names.arg = data$Var1, # The base names (A, C, G, T) for the x-axis labels
#       main = "Base Frequencies in Generated DNA",
#       xlab = "DNA Base",
#       ylab = "Count",
#       col = "#66B3BA", # A nice blue/green color
#       border = "white"
#     )
#   })
# }