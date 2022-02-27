//
//  WeatherDataPresenter.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

import UIKit

protocol WeatherDataPresenterDelegate: AnyObject{
    func succesfullyFetchedWeatherData(_ weatherData: [WeatherDataList]?)
    func requestFailedWithError(_ error : Error?)
    func failedToObtainResponse(_ errorMessage: String?)
}

class WeatherDataPresenter: NSObject{
    
    var output: WeatherDataPresenterDelegate?
    var weatherList: [WeatherDataList]?
    
    init(presenterOutput: WeatherDataPresenterDelegate){
        output = presenterOutput
    }
    // get Url from base url and city name
    func fetchWeatherConditions(city: String) {
        let urlString = "\(Constants.baseWeatherURL)&q=\(city)"
        self.performRequest(with: urlString)
    }
    // perform request using url
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.output?.requestFailedWithError(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.output?.succesfullyFetchedWeatherData(weather)
                    }
                }
            }
            task.resume()
        }
    }
    // parse JSON response
    private func parseJSON(_ weatherData: Data) -> [WeatherDataList]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherDataResponseModel.self, from: weatherData)
            let statusCode = decodedData.statusCode
            if statusCode == Constants.successStatusCode {
                if let weatherDataList = decodedData.weatherDataList{
                    weatherList = weatherDataList
                }
            }else{
                self.output?.failedToObtainResponse(decodedData.message)
                return nil
            }
            return weatherList
        } catch {
            self.output?.requestFailedWithError(error)
            return nil
        }
    }
}
