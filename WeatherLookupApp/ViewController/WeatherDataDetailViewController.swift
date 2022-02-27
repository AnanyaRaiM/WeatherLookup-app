//
//  WeatherDataDetailViewController.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

import UIKit

class WeatherDataDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet private weak var weatherConditionLabel: UILabel!
    @IBOutlet private weak var weatherDescriptionLabel: UILabel!
    @IBOutlet private weak var weatherImage: UIImageView!
    
    // MARK: - Properties
    var cityName: String?
    var weatherDetails: WeatherDataList?
    
    //MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationBar()
        self.setUpUI()
    }
    
    //MARK: - Methods
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = self.cityName
    }
    
    private func setUpUI() {
        if let temperature = self.weatherDetails?.temperatureDeatil?.temperatureString{
            self.temperatureLabel.text = "\(String(describing: temperature))" + Constants.temperatureUnit
        }
        if let feelsLikeTemperature = self.weatherDetails?.temperatureDeatil?.feelsLikeTemperatureString{
            self.feelsLikeTemperatureLabel.text = "Feels Like: " + "\(String(describing: feelsLikeTemperature))" + Constants.temperatureUnit
        }
        self.weatherConditionLabel.text = self.weatherDetails?.weatherDetail?[0].weather?.rawValue
        self.weatherDescriptionLabel.text = self.weatherDetails?.weatherDetail?[0].weatherDescription
        self.weatherImage.image = self.weatherDetails?.weatherDetail?[0].weatherImage
    }
}

