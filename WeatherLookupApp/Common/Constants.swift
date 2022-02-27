//
//  Constants.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

/* All constants */
import Foundation

struct Constants{
    
    static let baseWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=ba24c6018ddd72041749018d0c1b1ef8&units=metric"
    static let temperatureUnit = "°C"
    static let emptyString = ""
    static let errorString = "Error"
    static let okString = "Ok"
    static let successStatusCode = "200"
    // Alert Message
    static let invalidCityString = "Please enter a valid city"
    
    // Storyboard constants
    static let mainStoryBoardName = "Main"
    static let weatherDataListScreen = "WeatherDataListViewController"
    static let weatherDataDetailScreen = "WeatherDataDetailViewController"
    
    // Tableview cell constants
    static let weatherDataListTableViewCell = "WeatherDataListTableViewCell"
}

