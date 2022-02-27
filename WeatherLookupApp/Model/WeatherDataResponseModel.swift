//
//  WeatherDataResponseModel.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

import Foundation
import UIKit

// MARK: - WeatherDataResponseModel
class WeatherDataResponseModel: Codable{
    let statusCode: String?
    let weatherDataList: [WeatherDataList]?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "cod"
        case weatherDataList = "list"
        case message
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try container.decode(String?.self, forKey: .statusCode)
        let messageString = try? container.decode(String?.self, forKey: .message)
        let messageInt = try? container.decode(Int?.self, forKey: .message)
        self.message = messageString ?? "\(String(describing: messageInt))" // reponse message could be Int or String type
        weatherDataList = try? container.decode([WeatherDataList]?.self, forKey: .weatherDataList)
    }
    
}

// MARK: - WeatherDataList
struct WeatherDataList: Codable{
    let temperatureDeatil: TemperatureDetail?
    let weatherDetail: [WeatherDetail]?
    
    enum CodingKeys: String, CodingKey {
        case weatherDetail = "weather"
        case temperatureDeatil = "main"
    }
}

// MARK: - TemperatureDetail
struct TemperatureDetail: Codable{
    let temperatureInCelcius: Double?
    let feelsLikeTemperatureInCelcius: Double?
    // converting to string with single decimal point to display
    var temperatureString: String? {
        return String(format: "%.1f", temperatureInCelcius ?? 0)
    }
    var feelsLikeTemperatureString: String? {
        return String(format: "%.1f", feelsLikeTemperatureInCelcius ?? 0)
    }
    
    enum CodingKeys: String, CodingKey {
        case temperatureInCelcius = "temp"
        case feelsLikeTemperatureInCelcius = "feels_like"
    }
}

// MARK: - WeatherDetail
struct WeatherDetail: Codable{
    let weather: WeatherConditions?
    let weatherDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case weather = "main"
        case weatherDescription = "description"
    }
    
    var weatherImage: UIImage? {
        switch weather {
        case .clear:
            return UIImage(named: WeatherConditions.clear.rawValue)
        case .clouds:
            return UIImage(named: WeatherConditions.clouds.rawValue)
        case .rain:
           return UIImage(named: WeatherConditions.rain.rawValue)
        default: break
        }
        return UIImage()
    }
}

enum WeatherConditions: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}
