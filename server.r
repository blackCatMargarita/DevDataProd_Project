library(shiny)
library(rMaps)

countryData <- read.csv('countries.csv', stringsAsFactors = F)
popData <- countryData[, c('IOS','Population','HDI','GDP_PPP','GDP')]
blank <- popData$Population == 'n/a' | popData$HDI == 'n/a' | popData$GDP_PPP == 'n/a' | popData$GDP == 'n/a'
dataMap <- popData[!blank,]
dataMap$Population <- sapply(dataMap$Population, function(x){
    x2 <- gsub(pattern = ",", replacement = "", x = x)
    as.numeric(x2)})
dataMap$GDP_PPP <- sapply(dataMap$GDP_PPP, function(x){
    x2 <- gsub(pattern = ",", replacement = "", x = x)
    as.numeric(x2)})
dataMap$GDP <- sapply(dataMap$GDP, function(x){
    x2 <- gsub(pattern = ",", replacement = "", x = x)
    as.numeric(x2)})
dataMap$HDI <- as.numeric(dataMap$HDI)

# popDataSort <- popDataShort[order(-popDataShort$Population),]
# rankOrder <- c(1:length(popDataSort$Population))
# popDataMap <- cbind(popDataSort, rankOrder)

dataMap$Population <- dataMap$Population/1000

choro1 = ichoropleth(Population ~ IOS, data = dataMap, map = 'world', ncuts = 9, labels = FALSE)
choro1$set(geographyConfig = list(
    popupTemplate = "#! function(geography, data){
    return '<div class=hoverinfo><strong>' + geography.properties.name + 
    ': ' + data.Population + '</strong></div>';
    } !#" 
))

choro2 = ichoropleth(HDI ~ IOS, data = dataMap, map = 'world', ncuts = 9, labels = FALSE)
choro2$set(geographyConfig = list(
    popupTemplate = "#! function(geography, data){
    return '<div class=hoverinfo><strong>' + geography.properties.name + 
    ': ' + data.HDI + '</strong></div>';
    } !#" 
))

choro3 = ichoropleth(GDP_PPP ~ IOS, data = dataMap, map = 'world', ncuts = 9, labels = FALSE)
choro3$set(geographyConfig = list(
    popupTemplate = "#! function(geography, data){
    return '<div class=hoverinfo><strong>' + geography.properties.name + 
    ': ' + data.GDP_PPP + '</strong></div>';
    } !#" 
))

choro4 = ichoropleth(GDP ~ IOS, data = dataMap, map = 'world', ncuts = 9, labels = FALSE)
choro4$set(geographyConfig = list(
    popupTemplate = "#! function(geography, data){
    return '<div class=hoverinfo><strong>' + geography.properties.name + 
    ': ' + data.GDP + '</strong></div>';
    } !#" 
))

shinyServer(
    function(input, output, session){
#         if (input$worldIndex == "Population") {
            output$popPlot <- rCharts::renderChart2({
                 if (is.null(input$worldIndex)){choro1}
                 else if (input$worldIndex == "pop") {choro1}
                 else if (input$worldIndex == "hdi") {choro2}
                 else if (input$worldIndex == "gdp_ppp") {choro3}
                 else if (input$worldIndex == "gdp_cd") {choro4}
            })      
    }
)
