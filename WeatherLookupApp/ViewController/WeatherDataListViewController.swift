//
//  WeatherDataListViewController.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

import UIKit

class WeatherDataListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var weatherDataListTableList: UITableView!
    
    // MARK: - Properties
    private var activityIndicator = ActivityIndicatorView()
    private var weatherDetails: [WeatherDataList]?
    private var alertView = AlertViewController()
    var cityName: String?
    private lazy var weatherDataPresenter: WeatherDataPresenter = {
        let presenter = WeatherDataPresenter(presenterOutput: self)
        return presenter
    }()
    
    //MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        self.fetchWeatherData()
    }
    
    //MARK: - Methods
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = self.cityName
    }
    
    private func registerNibs(){
        self.weatherDataListTableList.register(UINib(nibName: Constants.weatherDataListTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.weatherDataListTableViewCell)
    }
    
    private func fetchWeatherData(){
        if let cityName = self.cityName{
            activityIndicator.showActivityIndicator(view: self.view)
            self.weatherDataPresenter.fetchWeatherConditions(city: cityName)
        }
    }
    
    private func navigateToWeatherDetailScreen(of selectedRow: Int){
        guard let weatherDataDetailViewController = UIStoryboard(name: Constants.mainStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: Constants.weatherDataDetailScreen) as? WeatherDataDetailViewController else{ return }
        weatherDataDetailViewController.cityName = self.cityName
        weatherDataDetailViewController.weatherDetails = self.weatherDetails?[selectedRow]
        navigationController?.pushViewController(weatherDataDetailViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension WeatherDataListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherData = self.weatherDetails else
        { return 0 }
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherDataListTableViewCell, for: indexPath) as? WeatherDataListTableViewCell else{
            return UITableViewCell()
        }
        cell.drillDownButton.tag = indexPath.row
        cell.delegate = self
        if let weather = self.weatherDetails?[indexPath.row].weatherDetail?[0].weather{
            cell.weatherConditionLabel.text = weather.rawValue
        }
        if let temperature = self.weatherDetails?[indexPath.row].temperatureDeatil?.temperatureString{
            cell.temperatureLabel.text = "Temp: " + "\(temperature)" + Constants.temperatureUnit
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WeatherDataListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Drill down to weather detail is a weather is selected
        self.navigateToWeatherDetailScreen(of: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Giving constant height as cell contains only two labels instead of auto dimension
    }
}

//MARK: - WeatherDataPresenterDelegate
extension WeatherDataListViewController: WeatherDataPresenterDelegate {
    // Succesfull fetching of weather details
    func succesfullyFetchedWeatherData(_ weatherData: [WeatherDataList]?) {
        self.weatherDetails = weatherData
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            self.weatherDataListTableList.reloadData()
        }
    }
    // Error
    func requestFailedWithError(_ error: Error?) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            self.alertView.showAlertView(view: self, alertMesssage: error?.localizedDescription ?? Constants.emptyString)
        }
    }
    //response other than expected weather data
    func failedToObtainResponse(_ errorMessage: String?) {
        DispatchQueue.main.async {
            self.activityIndicator.removeActivityIndicator()
            self.alertView.showAlertView(view: self, alertMesssage: errorMessage ?? Constants.emptyString)
        }
    }
}

//MARK: - WeatherDataListTableViewCellDelegate
extension WeatherDataListViewController: WeatherDataListTableViewCellDelegate{
    // drill down button tapped for weather details 
    func showWeatherDetailButtonTapped(rowSelected: Int) {
        self.navigateToWeatherDetailScreen(of: rowSelected)
    }
}
