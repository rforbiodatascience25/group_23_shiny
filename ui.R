ui <- page_fluid(
  layout_columns(
    col_widths = 12,
    card(
      titlePanel("Virtual Gene Generator"),
      style = 'backgrounf-color: #f0f0f0; padding: 15px;'
    )),
  layout_columns(
    col_widths = 12, 
    card(
      titlePanel('About'),
      helpText('This is  a gene generator.')
    )),
  layout_columns(
    col_widths = 12, 
    card(
      card_header('Virtual Gene Generator'),
      sliderInput(inputId = "n_bases",
                  label = "Number of bases:",
                  min = 1,
                  max = 60,
                  value = 30),
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        numericInput(inputId = 'freq_a',
                     label = 'Frequency of A',
                     min=0,
                     max = 1,
                     value = 0.25),
        numericInput(inputId = 'freq_t',
                     label = 'Frequency of T',
                     min=0,
                     max = 1,
                     value = 0.25),
        numericInput(inputId = 'freq_c',
                     label = 'Frequency of C',
                     min=0,
                     max = 1,
                     value = 0.25),
        numericInput(inputId = 'freq_g',
                     label = 'Frequency of G',
                     min=0,
                     max = 1,
                     value = 0.25)
      ))), 
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene output"),
      mainPanel(
        verbatimTextOutput(outputId = "dna")
      )
    ))
)
