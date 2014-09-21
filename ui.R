library(shiny)
library(rMaps)

shinyUI(navbarPage("World Indices",
    tabPanel("World Map",
#     headerPanel("World Map of Population"),
    sidebarPanel(
        h6("Select the data type to display and notice the change in map colors."),
        h6("You may need to scroll map down to see color legend."),
        h6("Hover over individual countries to see specific numbers."),
        radioButtons("worldIndex", "Country Data to Dispay:", 
                     c("2012 Population (in millions)" = "pop",
                       "2011 GDP based on PPP (in dollars)" = "gdp_ppp",
                       "2012 GDP in current Dollars (in millions )" = "gdp_cd",
                       "Human Development Index" = "hdi"), 
                     selected = "pop", inline = FALSE)
    ),
    mainPanel(
            rCharts::chartOutput('popPlot', 'datamaps'))
    ),
    tabPanel("About", h3("Sources"),
             h5("Population"), h6("UN Population Division, Policy Section: http://esa.un.org/PopPolicy/cprofile_report.aspx  
                                  and http://data.worldbank.org/indicator/SP.POP.TOTL 2012"),
                            h6("Population, total refers to the total population. (1) United Nations Population Division. World Population Prospects, 
                               (2) United Nations Statistical Division. Population and Vital Statistics Report (various years), 
                               (3) Census reports and other statistical publications from national statistical offices, 
                               (4) Eurostat: Demographic Statistics, (5) Secretariat of the Pacific Community: Statistics and Demography Programme, 
                               and (6) U.S. Census Bureau: International Database."),
             h5("GDP in current Dollars 2012"), h6("The World Bank: http://data.worldbank.org/indicator/NY.GDP.MKTP.CD"),	
             h5("GDP PPP in million U.S Dollars"), h6("The International Comparison Program (ICP) is a worldwide statistical partnership to collect 
                comparative price data and compile detailed expenditure values of countries' gross domestic products (GDP). 
                These are the findings of the 2011 International Comparison Program as published on April 30, 2014.	GDP at purchaser's 
                prices is the sum of gross value added by all resident producers in the economy plus any product taxes and minus any subsidies not 
                included in the value of the products. It is calculated without making deductions for depreciation of fabricated assets or for 
                depletion and degradation of natural resources. Data are in current U.S. dollars. Dollar figures for GDP are converted from 
                domestic currencies using single year official exchange rates. For a few countries where the official exchange rate does not reflect 
                the rate effectively applied to actual foreign exchange transactions, an alternative conversion factor is used."),
            h5("GDP Per Capita in PPP in $"), h6("A measure of the total output of a country that takes the gross domestic product (GDP) 
                and divides it by the number of people in the country. The per capita GDP is especially useful when comparing one country 
                to another because it shows the relative performance of the countries. A rise in per capita GDP signals growth in the economy 
                and tends to translate as an increase in productivity."),
            h5("HDI"), h6("United Nations Development Programme https://data.undp.org/dataset/Table-1-Human-Development-Index-and-its-components/wxub-qc5k")	
)
)
)