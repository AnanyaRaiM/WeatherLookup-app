//
//  CityModel.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 27/02/22.
//

import Foundation

class CityModel {
    // validate city name, returns false if empty city name found
    func validateCityNameEntered(cityName: String) -> Bool?{
        if cityName.count == 0 {
            return false
        }
        return true
    }
    // City name first letter is upper cased
    func getFormattedString(city: String?) -> String? {
        return String(city?.prefix(1) ?? "").uppercased() + String(city?.dropFirst() ?? "")
    }
}
