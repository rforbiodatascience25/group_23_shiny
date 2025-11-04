# Load needed libraries
library("shiny")
library('bslib')

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
      titlePanel('Virtual Gene Generator'),
      helpText('This is  a gene generator: by specifying a length and the probabilities of having each nucleotide,
               a dna sequence is generated, transcribed into rna and then translated into amino acids. The count of
               each nucleotid of this dna sequence is also plotted.')
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
                     value = 0.25),
        #textInput(inputId = 'translation',
        #           label = 'Translation',
        #           value = 'paste DNA to translate into RNA',
        #           placeholder = "ATGC", 
        #           updateOn = "change"),
        # textInput(inputId = 'transcription',
        #           label = 'Transcription',
        #           value = 'paste RNA to transcribe to amino acids',
        #           placeholder = "AUGC", 
        #           updateOn = "change")
      ))), 
  layout_columns(
    col_widths = 12,
    card(
      card_header("Virtual Gene output"),
      mainPanel(
        verbatimTextOutput(outputId = "dna"), 
        verbatimTextOutput(outputId = "rna"),
        verbatimTextOutput(outputId = "amino_acids"),
        plotOutput(outputId = "freqPlot")
      )))
)
