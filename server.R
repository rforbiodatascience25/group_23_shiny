server <- function(input, output) {
  output$dna <- renderText({
    gene_dna(length = input$n_bases, base_probs = c(input$freq_a, input$freq_t, input$freq_c, input$freq_g))
  })
}