library("shiny")
library("httr")
library("jsonlite")
library("RMariaDB")
library("tidyverse")
library("shinyalert")
library("shinyWidgets")
library("shinythemes")
library("leaflet")
library("plotly")
library("lubridate")
library("XML")
library("kulife")

ui <- fluidPage(

  useShinyalert(),
   
  navbarPage("United States COVID-19 Dashboard",
    theme = shinytheme("flatly"),
    navbarMenu("US",
      tabPanel("US Covid Map",
        div(class="outer",
          leafletOutput('myMap', width = "100%", height = 700),
          tags$style("
        #controls {
          background-color: #ffffff;
          opacity: 0.7;
        }
        #controls:hover{
          opacity: 1;
        }
               "),
          absolutePanel(id = "controls", class = "panel panel-default",
            top = 185, left = 42, width = 250, fixed=TRUE,
            draggable = TRUE, height = "auto",
            dateInput("dateAmerica", "Date:", value = "2021-03-07"),
            selectInput("americaTypeSelectMap", "Select Stastic", choices = c("Positive Cases", "Hospitilized Currently", "Deaths"))
          )
        )
      ),
      tabPanel("US Covid Over Time",
        sidebarLayout(
          sidebarPanel(
            dateInput("dateStartAmerica", "Start Date:", value = "2020-03-01"),
            dateInput("dateEndAmerica", "End Date:", value = "2021-03-07")
          ),
          mainPanel(
            tabsetPanel(
              tabPanel("Positive Cases",
                plotlyOutput("UStrendPositive")
              ),
              tabPanel("Deaths",
                plotlyOutput("UStrendDeaths")
              ),
              tabPanel("Hosipitalized Currently",
                       plotlyOutput("UStrendHospitalized")
              )
            )
          )
        )
      )
    ),
    navbarMenu("States",
      tabPanel("States Over Time",
        sidebarLayout(
          sidebarPanel(
            pickerInput("stateSelect", "Select States",
              choices = c("Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Northern Mariana Islands", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "US Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"),
              selected = c("Alaska", "Alabama", "Arkansas"),
              multiple = TRUE,
              options = pickerOptions(
                actionsBox = TRUE,
                title = "Please select a state",
                header = "States")),
            dateInput("dateStartState", "Start Date:", value = "2020-03-01"),
            dateInput("dateEndState", "End Date:", value = "2021-03-07")
          ),
          mainPanel(
            tabsetPanel(
              tabPanel("Positive Cases",
                plotlyOutput("statesTrendPositive")
              ),
              tabPanel("Deaths",
                plotlyOutput("statesTrendDeaths")
              ),
              tabPanel("Hosipitalized Currently",
                plotlyOutput("statesTrendHospitalized")
              )
            )
          )
        )
      ),
    tabPanel("States Info",
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterAlaska")),column(9, htmlOutput("websiteURLAlaska"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterAlabama")),column(9, htmlOutput("websiteURLAlabama"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterArkansas")),column(9, htmlOutput("websiteURLArkansas"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterAmericanSamoa")),column(9, htmlOutput("websiteURLAmericanSamoa"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterArizona")),column(9, htmlOutput("websiteURLArizona"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterCalifornia")),column(9, htmlOutput("websiteURLCalifornia"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterColorado")),column(9, htmlOutput("websiteURLColorado"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterConnecticut")),column(9, htmlOutput("websiteURLConnecticut"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterDistrictofColumbia")),column(9, htmlOutput("websiteURLDistrictofColumbia"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterDelaware")),column(9, htmlOutput("websiteURLDelaware"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterFlorida")),column(9, htmlOutput("websiteURLFlorida"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterGeorgia")),column(9, htmlOutput("websiteURLGeorgia"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterGuam")),column(9, htmlOutput("websiteURLGuam"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterHawaii")),column(9, htmlOutput("websiteURLHawaii"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterIowa")),column(9, htmlOutput("websiteURLIowa"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterIdaho")),column(9, htmlOutput("websiteURLIdaho"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterIllinois")),column(9, htmlOutput("websiteURLIllinois"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterIndiana")),column(9, htmlOutput("websiteURLIndiana"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterKansas")),column(9, htmlOutput("websiteURLKansas"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterKentucky")),column(9, htmlOutput("websiteURLKentucky"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterLouisiana")),column(9, htmlOutput("websiteURLLouisiana"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMassachusetts")),column(9, htmlOutput("websiteURLMassachusetts"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMaryland")),column(9, htmlOutput("websiteURLMaryland"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMaine")),column(9, htmlOutput("websiteURLMaine"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMichigan")),column(9, htmlOutput("websiteURLMichigan"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMinnesota")),column(9, htmlOutput("websiteURLMinnesota"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMissouri")),column(9, htmlOutput("websiteURLMissouri"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNorthernMarianaIslands")),column(9, htmlOutput("websiteURLNorthernMarianaIslands"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMississippi")),column(9, htmlOutput("websiteURLMississippi"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterMontana")),column(9, htmlOutput("websiteURLMontana"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNorthCarolina")),column(9, htmlOutput("websiteURLNorthCarolina"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNorthDakota")),column(9, htmlOutput("websiteURLNorthDakota"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNebraska")),column(9, htmlOutput("websiteURLNebraska"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNewHampshire")),column(9, htmlOutput("websiteURLNewHampshire"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNewJersey")),column(9, htmlOutput("websiteURLNewJersey"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNewMexico")),column(9, htmlOutput("websiteURLNewMexico"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNevada")),column(9, htmlOutput("websiteURLNevada"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterNewYork")),column(9, htmlOutput("websiteURLNewYork"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterOhio")),column(9, htmlOutput("websiteURLOhio"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterOklahoma")),column(9, htmlOutput("websiteURLOklahoma"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterOregon")),column(9, htmlOutput("websiteURLOregon"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterPennsylvania")),column(9, htmlOutput("websiteURLPennsylvania"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterPuertoRico")),column(9, htmlOutput("websiteURLPuertoRico"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterRhodeIsland")),column(9, htmlOutput("websiteURLRhodeIsland"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterSouthCarolina")),column(9, htmlOutput("websiteURLSouthCarolina"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterSouthDakota")),column(9, htmlOutput("websiteURLSouthDakota"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterTennessee")),column(9, htmlOutput("websiteURLTennessee"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterTexas")),column(9, htmlOutput("websiteURLTexas"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterUtah")),column(9, htmlOutput("websiteURLUtah"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterVirginia")),column(9, htmlOutput("websiteURLVirginia"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterUSVirginIslands")),column(9, htmlOutput("websiteURLUSVirginIslands"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterVermont")),column(9, htmlOutput("websiteURLVermont"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterWashington")),column(9, htmlOutput("websiteURLWashington"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterWisconsin")),column(9, htmlOutput("websiteURLWisconsin"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterWestVirginia")),column(9, htmlOutput("websiteURLWestVirginia"))))),
      fixedRow(column(12,fixedRow(column(3, textOutput("stateTwitterWyoming")),column(9, htmlOutput("websiteURLWyoming")))))
    )
  ),
  tabPanel("Data",
    sidebarLayout(
        sidebarPanel(
          selectInput("datasetCSV", "Choose CSV to Download:",
            choices = c("Historical US Data", "Historical State Data", "State Meta Information")),
          downloadButton("downloadDataCSV", "Download CSV"),
          h1(" "),
          h4("NOTE: Historical State Data is to large to render as XML."),
          h1(" "),
          selectInput("datasetXML", "Choose XML to Download:",
            choices = c("Historical US Data", "State Meta Information")),
          downloadButton("downloadDataXML", "Download XML")
        ),
      mainPanel(
        h2("API"),
        h4("Covid data is pulled from The Covid Tracking Project:"),
        htmlOutput("APIURL"),
        h4("The Covid Tracking Project has stopped collecting data as of 2021/03/07."),
        h2("Data Definitions"),
        h3("Positive Cases:"),
        h4("Total number of confirmed plus probable cases of COVID-19 reported by the state or territory. https://covidtracking.com/data/api"),
        h3("Deaths:"),
        h4("Total fatalities with confirmed OR probable COVID-19 case diagnosis. https://covidtracking.com/data/api"),
        h3("Hospitilized Currently:"),
        h4("Individuals who are currently hospitalized with COVID-19. https://covidtracking.com/data/api"),
      )
    )
  ),
  tags$script(
    HTML("var header = $('.navbar > .container-fluid'); header.append('<div style=\"float:right; padding-top: 8px\"><button id=\"updateBtn\" type=\"button\" class=\"btn btn-primary action-button\" onclick=\"update_data_button()\">Update Data</button></div>')")
    )
  )
)

server <- function(input, output) {
  
  # Connecting to DB. Will execute once.
  con <- dbConnect(MariaDB(),
                   host = "redacted",
                   port = 3306,
                   dbname = "redacted",
                   user = "redacted",
                   password = "redacted")

  # America wide data API.
  hist_america <- function() {
    url <- 'https://api.covidtracking.com/v1/us/daily.json'
    r <- GET(url)
    data = fromJSON(rawToChar(r$content))
    return(as_tibble(data) %>% select(1:11, 13:15) %>% rename(dateDay = date))
  }

  # State wide data API.
  hist_state <- function() {
    url <- 'https://api.covidtracking.com/v1/states/daily.json'
    r <- GET(url)
    data = fromJSON(rawToChar(r$content))
    return(as_tibble(data) %>% select(1:15, 19, 27) %>% rename(dateDay = date))
  }

  # Function to update data in db.
  update_data <- function() {
    us_date <- as.integer(dbGetQuery(con, "SELECT MAX(dateDay) FROM histAmerica;")[1,1])
    states_date <- as.integer(dbGetQuery(con, "SELECT MAX(dateDay) FROM histState;")[1,1])
    us_data <- hist_america() %>% filter(dateDay > us_date)
    states_data <- hist_state() %>% filter(dateDay > states_date)
    dbBegin(con)
    dbWriteTable(con, "histAmerica", us_data, append = TRUE)
    dbWriteTable(con, "histState", states_data, append = TRUE)
    dbCommit(con)
  }
  
  
  # Calling update data on loading app.
  update_data()

  # Reactive to update data button.
  observeEvent(input$updateBtn, {
    update_data()
    shinyalert(title = "Data Updated!", type = "success")
  })
  
  statemetasecond <- as_tibble(dbGetQuery(con, "SELECT * FROM statemetasecond;"))
  americaData <- as_tibble(dbGetQuery(con, "SELECT * FROM histAmerica;"))
  histState <- as_tibble(dbGetQuery(con, "SELECT * FROM histState;")) %>% select(1,2,3,9,10,16)
  
  output$stateTwitterAlaska <- renderText({paste("Alaska Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Alaska", "';")))[[1,1]])})
  output$stateTwitterAlabama <- renderText({paste("Alabama Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Alabama", "';")))[[1,1]])})
  output$stateTwitterArkansas <- renderText({paste("Arkansas Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Arkansas", "';")))[[1,1]])})
  output$stateTwitterAmericanSamoa <- renderText({paste("American Samoa Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "American Samoa", "';")))[[1,1]])})
  output$stateTwitterArizona <- renderText({paste("Arizona Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Arizona", "';")))[[1,1]])})
  output$stateTwitterCalifornia <- renderText({paste("California Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "California", "';")))[[1,1]])})
  output$stateTwitterColorado <- renderText({paste("Colorado Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Colorado", "';")))[[1,1]])})
  output$stateTwitterConnecticut <- renderText({paste("Connecticut Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Connecticut", "';")))[[1,1]])})
  output$stateTwitterDistrictofColumbia <- renderText({paste("District of Columbia Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "District of Columbia", "';")))[[1,1]])})
  output$stateTwitterDelaware <- renderText({paste("Delaware Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Delaware", "';")))[[1,1]])})
  output$stateTwitterFlorida <- renderText({paste("Florida Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Florida", "';")))[[1,1]])})
  output$stateTwitterGeorgia <- renderText({paste("Georgia Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Georgia", "';")))[[1,1]])})
  output$stateTwitterGuam <- renderText({paste("Guam Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Guam", "';")))[[1,1]])})
  output$stateTwitterHawaii <- renderText({paste("Hawaii Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Hawaii", "';")))[[1,1]])})
  output$stateTwitterIowa <- renderText({paste("Iowa Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Iowa", "';")))[[1,1]])})
  output$stateTwitterIdaho <- renderText({paste("Idaho Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Idaho", "';")))[[1,1]])})
  output$stateTwitterIllinois <- renderText({paste("Illinois Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Illinois", "';")))[[1,1]])})
  output$stateTwitterIndiana <- renderText({paste("Indiana Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Indiana", "';")))[[1,1]])})
  output$stateTwitterKansas <- renderText({paste("Kansas Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Kansas", "';")))[[1,1]])})
  output$stateTwitterKentucky <- renderText({paste("Kentucky Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Kentucky", "';")))[[1,1]])})
  output$stateTwitterLouisiana <- renderText({paste("Louisiana Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Louisiana", "';")))[[1,1]])})
  output$stateTwitterMassachusetts <- renderText({paste("Massachusetts Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Massachusetts", "';")))[[1,1]])})
  output$stateTwitterMaryland <- renderText({paste("Maryland Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Maryland", "';")))[[1,1]])})
  output$stateTwitterMaine <- renderText({paste("Maine Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Maine", "';")))[[1,1]])})
  output$stateTwitterMichigan <- renderText({paste("Michigan Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Michigan", "';")))[[1,1]])})
  output$stateTwitterMinnesota <- renderText({paste("Minnesota Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Minnesota", "';")))[[1,1]])})
  output$stateTwitterMissouri <- renderText({paste("Missouri Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Missouri", "';")))[[1,1]])})
  output$stateTwitterNorthernMarianaIslands <- renderText({paste("Northern Mariana Islands Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Northern Mariana Islands", "';")))[[1,1]])})
  output$stateTwitterMississippi <- renderText({paste("Mississippi Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Mississippi", "';")))[[1,1]])})
  output$stateTwitterMontana <- renderText({paste("Montana Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Montana", "';")))[[1,1]])})
  output$stateTwitterNorthCarolina <- renderText({paste("North Carolina Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "North Carolina", "';")))[[1,1]])})
  output$stateTwitterNorthDakota <- renderText({paste("North Dakota Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "North Dakota", "';")))[[1,1]])})
  output$stateTwitterNebraska <- renderText({paste("Nebraska Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Nebraska", "';")))[[1,1]])})
  output$stateTwitterNewHampshire <- renderText({paste("New Hampshire Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "New Hampshire", "';")))[[1,1]])})
  output$stateTwitterNewJersey <- renderText({paste("New Jersey Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "New Jersey", "';")))[[1,1]])})
  output$stateTwitterNewMexico <- renderText({paste("New Mexico Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "New Mexico", "';")))[[1,1]])})
  output$stateTwitterNevada <- renderText({paste("Nevada Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Nevada", "';")))[[1,1]])})
  output$stateTwitterNewYork <- renderText({paste("New York Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "New York", "';")))[[1,1]])})
  output$stateTwitterOhio <- renderText({paste("Ohio Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Ohio", "';")))[[1,1]])})
  output$stateTwitterOklahoma <- renderText({paste("Oklahoma Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Oklahoma", "';")))[[1,1]])})
  output$stateTwitterOregon <- renderText({paste("Oregon Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Oregon", "';")))[[1,1]])})
  output$stateTwitterPennsylvania <- renderText({paste("Pennsylvania Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Pennsylvania", "';")))[[1,1]])})
  output$stateTwitterPuertoRico <- renderText({paste("Puerto Rico Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Puerto Rico", "';")))[[1,1]])})
  output$stateTwitterRhodeIsland <- renderText({paste("Rhode Island Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Rhode Island", "';")))[[1,1]])})
  output$stateTwitterSouthCarolina <- renderText({paste("South Carolina Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "South Carolina", "';")))[[1,1]])})
  output$stateTwitterSouthDakota <- renderText({paste("South Dakota Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "South Dakota", "';")))[[1,1]])})
  output$stateTwitterTennessee <- renderText({paste("Tennessee Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Tennessee", "';")))[[1,1]])})
  output$stateTwitterTexas <- renderText({paste("Texas Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Texas", "';")))[[1,1]])})
  output$stateTwitterUtah <- renderText({paste("Utah Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Utah", "';")))[[1,1]])})
  output$stateTwitterVirginia <- renderText({paste("Virginia Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Virginia", "';")))[[1,1]])})
  output$stateTwitterUSVirginIslands <- renderText({paste("US Virgin Islands Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "US Virgin Islands", "';")))[[1,1]])})
  output$stateTwitterVermont <- renderText({paste("Vermont Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Vermont", "';")))[[1,1]])})
  output$stateTwitterWashington <- renderText({paste("Washington Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Washington", "';")))[[1,1]])})
  output$stateTwitterWisconsin <- renderText({paste("Wisconsin Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Wisconsin", "';")))[[1,1]])})
  output$stateTwitterWestVirginia <- renderText({paste("West Virginia Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "West Virginia", "';")))[[1,1]])})
  output$stateTwitterWyoming <- renderText({paste("Wyoming Twitter: ",as_tibble(dbGetQuery(con, paste0("SELECT twitter FROM statemetasecond WHERE nameOfState = '", "Wyoming", "';")))[[1,1]])})
  
  output$websiteURLAlaska <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Alaska", "';")))[[1,1]],paste0("Alaska", " Covid Website"))})
  output$websiteURLAlabama <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Alabama", "';")))[[1,1]],paste0("Alabama", " Covid Website"))})
  output$websiteURLArkansas <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Arkansas", "';")))[[1,1]],paste0("Arkansas", " Covid Website"))})
  output$websiteURLAmericanSamoa <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "American Samoa", "';")))[[1,1]],paste0("American Samoa", " Covid Website"))})
  output$websiteURLArizona <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Arizona", "';")))[[1,1]],paste0("Arizona", " Covid Website"))})
  output$websiteURLCalifornia <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "California", "';")))[[1,1]],paste0("California", " Covid Website"))})
  output$websiteURLColorado <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Colorado", "';")))[[1,1]],paste0("Colorado", " Covid Website"))})
  output$websiteURLConnecticut <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Connecticut", "';")))[[1,1]],paste0("Connecticut", " Covid Website"))})
  output$websiteURLDistrictofColumbia <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "District of Columbia", "';")))[[1,1]],paste0("District of Columbia", " Covid Website"))})
  output$websiteURLDelaware <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Delaware", "';")))[[1,1]],paste0("Delaware", " Covid Website"))})
  output$websiteURLFlorida <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Florida", "';")))[[1,1]],paste0("Florida", " Covid Website"))})
  output$websiteURLGeorgia <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Georgia", "';")))[[1,1]],paste0("Georgia", " Covid Website"))})
  output$websiteURLGuam <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Guam", "';")))[[1,1]],paste0("Guam", " Covid Website"))})
  output$websiteURLHawaii <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Hawaii", "';")))[[1,1]],paste0("Hawaii", " Covid Website"))})
  output$websiteURLIowa <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Iowa", "';")))[[1,1]],paste0("Iowa", " Covid Website"))})
  output$websiteURLIdaho <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Idaho", "';")))[[1,1]],paste0("Idaho", " Covid Website"))})
  output$websiteURLIllinois <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Illinois", "';")))[[1,1]],paste0("Illinois", " Covid Website"))})
  output$websiteURLIndiana <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Indiana", "';")))[[1,1]],paste0("Indiana", " Covid Website"))})
  output$websiteURLKansas <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Kansas", "';")))[[1,1]],paste0("Kansas", " Covid Website"))})
  output$websiteURLKentucky <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Kentucky", "';")))[[1,1]],paste0("Kentucky", " Covid Website"))})
  output$websiteURLLouisiana <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Louisiana", "';")))[[1,1]],paste0("Louisiana", " Covid Website"))})
  output$websiteURLMassachusetts <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Massachusetts", "';")))[[1,1]],paste0("Massachusetts", " Covid Website"))})
  output$websiteURLMaryland <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Maryland", "';")))[[1,1]],paste0("Maryland", " Covid Website"))})
  output$websiteURLMaine <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Maine", "';")))[[1,1]],paste0("Maine", " Covid Website"))})
  output$websiteURLMichigan <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Michigan", "';")))[[1,1]],paste0("Michigan", " Covid Website"))})
  output$websiteURLMinnesota <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Minnesota", "';")))[[1,1]],paste0("Minnesota", " Covid Website"))})
  output$websiteURLMissouri <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Missouri", "';")))[[1,1]],paste0("Missouri", " Covid Website"))})
  output$websiteURLNorthernMarianaIslands <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Northern Mariana Islands", "';")))[[1,1]],paste0("Northern Mariana Islands", " Covid Website"))})
  output$websiteURLMississippi <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Mississippi", "';")))[[1,1]],paste0("Mississippi", " Covid Website"))})
  output$websiteURLMontana <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Montana", "';")))[[1,1]],paste0("Montana", " Covid Website"))})
  output$websiteURLNorthCarolina <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "North Carolina", "';")))[[1,1]],paste0("North Carolina", " Covid Website"))})
  output$websiteURLNorthDakota <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "North Dakota", "';")))[[1,1]],paste0("North Dakota", " Covid Website"))})
  output$websiteURLNebraska <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Nebraska", "';")))[[1,1]],paste0("Nebraska", " Covid Website"))})
  output$websiteURLNewHampshire <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "New Hampshire", "';")))[[1,1]],paste0("New Hampshire", " Covid Website"))})
  output$websiteURLNewJersey <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "New Jersey", "';")))[[1,1]],paste0("New Jersey", " Covid Website"))})
  output$websiteURLNewMexico <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "New Mexico", "';")))[[1,1]],paste0("New Mexico", " Covid Website"))})
  output$websiteURLNevada <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Nevada", "';")))[[1,1]],paste0("Nevada", " Covid Website"))})
  output$websiteURLNewYork <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "New York", "';")))[[1,1]],paste0("New York", " Covid Website"))})
  output$websiteURLOhio <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Ohio", "';")))[[1,1]],paste0("Ohio", " Covid Website"))})
  output$websiteURLOklahoma <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Oklahoma", "';")))[[1,1]],paste0("Oklahoma", " Covid Website"))})
  output$websiteURLOregon <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Oregon", "';")))[[1,1]],paste0("Oregon", " Covid Website"))})
  output$websiteURLPennsylvania <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Pennsylvania", "';")))[[1,1]],paste0("Pennsylvania", " Covid Website"))})
  output$websiteURLPuertoRico <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Puerto Rico", "';")))[[1,1]],paste0("Puerto Rico", " Covid Website"))})
  output$websiteURLRhodeIsland <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Rhode Island", "';")))[[1,1]],paste0("Rhode Island", " Covid Website"))})
  output$websiteURLSouthCarolina <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "South Carolina", "';")))[[1,1]],paste0("South Carolina", " Covid Website"))})
  output$websiteURLSouthDakota <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "South Dakota", "';")))[[1,1]],paste0("South Dakota", " Covid Website"))})
  output$websiteURLTennessee <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Tennessee", "';")))[[1,1]],paste0("Tennessee", " Covid Website"))})
  output$websiteURLTexas <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Texas", "';")))[[1,1]],paste0("Texas", " Covid Website"))})
  output$websiteURLUtah <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Utah", "';")))[[1,1]],paste0("Utah", " Covid Website"))})
  output$websiteURLVirginia <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Virginia", "';")))[[1,1]],paste0("Virginia", " Covid Website"))})
  output$websiteURLUSVirginIslands <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "US Virgin Islands", "';")))[[1,1]],paste0("US Virgin Islands", " Covid Website"))})
  output$websiteURLVermont <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Vermont", "';")))[[1,1]],paste0("Vermont", " Covid Website"))})
  output$websiteURLWashington <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Washington", "';")))[[1,1]],paste0("Washington", " Covid Website"))})
  output$websiteURLWisconsin <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Wisconsin", "';")))[[1,1]],paste0("Wisconsin", " Covid Website"))})
  output$websiteURLWestVirginia <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "West Virginia", "';")))[[1,1]],paste0("West Virginia", " Covid Website"))})
  output$websiteURLWyoming <- renderUI({tags$a(href = as_tibble(dbGetQuery(con, paste0("SELECT covid19Site FROM statemetasecond WHERE nameOfState = '", "Wyoming", "';")))[[1,1]],paste0("Wyoming", " Covid Website"))})
  
  # Date Inputs
  mapDate <- reactive({
    as.integer(str_remove_all(as.character(input$dateAmerica), "-"))
  })
  USTrendStartDate <- reactive({
    as.integer(str_remove_all(as.character(input$dateStartAmerica), "-"))
  })
  USTrendEndDate <- reactive({
    as.integer(str_remove_all(as.character(input$dateEndAmerica), "-"))
  })
  StatesTrendStartDate <- reactive({
    as.integer(str_remove_all(as.character(input$dateStartState), "-"))
  })
  StatesTrendEndDate <- reactive({
    as.integer(str_remove_all(as.character(input$dateEndState), "-"))
  })
  
  # Conversion of Map Value Select.
  mapValue <- reactive({
    case_when(
      input$americaTypeSelectMap == "Hospitilized Currently" ~ "hospitilizedCurrently",
      input$americaTypeSelectMap == "Deaths"~ "death",
      input$americaTypeSelectMap == "Positive Cases"~ "positive"
    )
  })
  
  # State Data for US Map
  stateData <- reactive({
    histState %>%
    left_join(statemetasecond) %>% filter(dateDay == mapDate()) %>%
    arrange(mapValue()) %>%
    filter(state %in% c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")) %>%
    mutate(state=factor(state, unique(state)))
  })

  # Create a color palette with handmade bins.
  colors <- c("#ffab12", "#ffab12")
  
  palPositive <- reactive({
    colorFactor(colors, stateData()$positive)
  })
    
  # Prepare the text for the tooltip:
  mytextPositive <- reactive({
    paste("State: ", stateData()$nameOfState, "<br/>", 
    "Positive Cases: ", stateData()$positive, sep="") %>%
    lapply(htmltools::HTML)
  })
  
  # Map on Main Page
  USmapPositive <- reactive({
    leaflet(stateData()) %>% 
      addTiles()  %>% 
      setView( lat=35, lng=-100 , zoom=4) %>%
      addProviderTiles("Esri.WorldGrayCanvas") %>%
      addCircles(lat = ~lat, lng = ~long, 
                 radius = ~(positive / 10), opacity = 5, popup = ~mytextPositive(), color = ~palPositive()(positive))
  })
  
  palDeaths <- reactive({
    colorFactor(colors, stateData()$death)
  })
  
  # Prepare the text for the tooltip:
  mytextDeaths <- reactive({
    paste("State: ", stateData()$nameOfState, "<br/>", 
          "Deaths: ", stateData()$death, sep="") %>%
      lapply(htmltools::HTML)
  })
  
  # Map on main page.
  USmapDeaths <- reactive({
    leaflet(stateData()) %>% 
      addTiles()  %>% 
      setView( lat=35, lng=-100 , zoom=4) %>%
      addProviderTiles("Esri.WorldGrayCanvas") %>%
      addCircles(lat = ~lat, lng = ~long, 
                 radius = ~(death / 0.25), opacity = 5, popup = ~mytextDeaths(), color = ~palDeaths()(death))
  })
  
  palHospitalized <- reactive({
    colorFactor(colors, stateData()$hospitalizedCurrently)
  })
  
  # Prepare the text for the tooltip:
  mytextHospitalized <- reactive({
    paste("State: ", stateData()$nameOfState, "<br/>", 
          "hospitalized Currently: ", stateData()$hospitalizedCurrently, sep="") %>%
      lapply(htmltools::HTML)
  })
  
  # Map on main page.
  USmapHospitalized <- reactive({
    leaflet(stateData()) %>% 
      addTiles()  %>% 
      setView( lat=35, lng=-100 , zoom=4) %>%
      addProviderTiles("Esri.WorldGrayCanvas") %>%
      addCircles(lat = ~lat, lng = ~long, 
                 radius = ~(hospitalizedCurrently / 0.025), opacity = 5, popup = ~mytextHospitalized(), color = ~palHospitalized()(hospitalizedCurrently))
  })
  
  # Map Output
  output$myMap <- renderLeaflet({
    if (input$americaTypeSelectMap == "Hospitilized Currently") {USmapHospitalized()}
    else if (input$americaTypeSelectMap == "Deaths") {USmapDeaths()}
    else {USmapPositive()}
  })
  
  # US Trending y lim.
  maxNumPos <- reactive({
    max(americaData %>%
          filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>% 
          select(positive))
  })
  # positive US trending
  output$UStrendPositive <- renderPlotly(
    ggplotly(americaData %>%
      filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>%
      mutate(dateDay = ymd(dateDay)) %>%
      rename(Date = dateDay) %>%
      rename(Positive = positive) %>%
      ggplot(aes(Date, Positive)) +
        theme_minimal() +
        geom_line(color = "Orange") +
        scale_y_continuous(limits =   c(0,maxNumPos())))
  )
  
  # US Trending y lim.
  maxNumDeaths <- reactive({
    max(americaData %>%
          filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>% 
          select(death))
  })
  # deaths US trending
  output$UStrendDeaths <- renderPlotly(
    ggplotly(americaData %>%
      filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>%
      mutate(dateDay = ymd(dateDay)) %>%
      rename(Date = dateDay) %>%
      rename(Deaths = death) %>%
      ggplot(aes(Date, Deaths)) +
        theme_minimal() +
        geom_line(color = "Orange") +
        scale_y_continuous(limits =   c(0,maxNumDeaths())))
  )
  
  # US Trending y lim.
  maxNumHospitalized <- reactive({
    max(americaData %>%
          filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>% 
          select(hospitalizedCurrently))
  })
  # Hosiptalized US trending
  output$UStrendHospitalized <- renderPlotly(
    ggplotly(americaData %>%
      filter(dateDay <= USTrendEndDate() & dateDay >= USTrendStartDate()) %>%
      mutate(dateDay = ymd(dateDay)) %>%
      rename(Date = dateDay) %>%
      rename(Hospitalized = hospitalizedCurrently) %>%
      ggplot(aes(Date, Hospitalized)) +
        theme_minimal() +
        geom_line(color = "Orange") +
        scale_y_continuous(limits =   c(0,maxNumHospitalized())))
  )

  stateDataTrend <- reactive({
    histState %>%
    left_join(statemetasecond) %>%
    select(-state) %>%
    rename(State = nameOfState) %>%
    filter(dateDay <= StatesTrendEndDate() & dateDay >= StatesTrendStartDate()) %>%
    mutate(dateDay = ymd(dateDay)) %>%
    rename(Date = dateDay) %>%
    rename(Hospitalized = hospitalizedCurrently)%>%
    rename(Deaths = death)%>%
    rename(Positive = positive)
  })
  
  max_num_positive <- reactive({
    max((stateDataTrend() %>% 
      filter(State %in% input$stateSelect) %>%
      select(Positive))[[1]], na.rm = TRUE)
    })
  
  output$statesTrendPositive <- renderPlotly(
    ggplotly(ggplot(stateDataTrend() %>%
      filter(State %in% input$stateSelect) %>%
      arrange(State),
        aes(Date, Positive, color = State)) +
           theme_minimal() +
           geom_line() +
           scale_y_continuous(limits =   c(0,max_num_positive())))
  )
  
  max_num_deaths <- reactive({
    max((stateDataTrend() %>% 
           filter(State %in% input$stateSelect) %>%
           select(Deaths))[[1]], na.rm = TRUE)
  })
  
  output$statesTrendDeaths <- renderPlotly(
    ggplotly(ggplot(stateDataTrend() %>%
      filter(State %in% input$stateSelect) %>%
      arrange(State),
        aes(Date, Deaths, color = State)) +
           theme_minimal() +
           geom_line() +
           scale_y_continuous(limits =   c(0,max_num_deaths())))
  )
  
  max_num_hospitalized <- reactive({
    max((stateDataTrend() %>% 
           filter(State %in% input$stateSelect) %>%
           select(Hospitalized))[[1]], na.rm = TRUE)
  })
  
  output$statesTrendHospitalized <- renderPlotly(
    ggplotly(ggplot(stateDataTrend() %>%
      filter(State %in% input$stateSelect) %>%
      arrange(State),
        aes(Date, Hospitalized, color = State)) +
          theme_minimal() +
          geom_line() +
          scale_y_continuous(limits =   c(0,max_num_hospitalized())))
  )
  
  # Reactive value for selected dataset.
  datasetInputCSV <- reactive({
    switch(input$datasetCSV,
           "Historical US Data" = americaData,
           "Historical State Data" = histState,
           "State Meta Information" = statemetasecond)
  })
  
  datasetInputXML <- reactive({
    switch(input$datasetXML,
           "Historical US Data" = americaData,
           "State Meta Information" = statemetasecond)
  })
  
  # Downloadable csv of selected dataset.
  output$downloadDataCSV <- downloadHandler(
    filename = function() {
      paste(input$datasetCSV, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInputCSV(), file, row.names = FALSE)
    }
  )
  
  # Downloadable csv of selected dataset.
  output$downloadDataXML <- downloadHandler(
    filename = function() {
      paste(input$datasetXML, ".xml", sep = "")
    },
    content = function(file) {
      write.xml(as.data.frame(datasetInputXML()), file)
    }
  )
  
  output$APIURL <- renderUI({tags$a(href = "https://covidtracking.com/","The Covid Tracking Project")})
  
  # When app closed, DB connection terminated.
  onSessionEnded(function() {
    dbDisconnect(con)
  })
}

shinyApp(ui = ui, server = server)