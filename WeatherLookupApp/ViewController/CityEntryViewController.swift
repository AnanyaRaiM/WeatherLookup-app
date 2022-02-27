//
//  CityEntryViewController.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//
import UIKit

class CityEntryViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var enterCityNameTextField: UITextField!
    @IBOutlet private weak var lookupButton: UIButton!
    
    // MARK: - Properties
    private var cityModel = CityModel()
    private var alertView = AlertViewController()
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Home screen navigation bar is kept hidden
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - IBAction
    @IBAction func lookUpButtonTapped(_ sender: UIButton) {
        if let enteredCityName = enterCityNameTextField.text, let isValidCity = cityModel.validateCityNameEntered(cityName: enteredCityName) {
            if (isValidCity) {
                // if city name is not empty move to next screen
                self.navigateToWeatherDataListScreen(of: enteredCityName)
            } else{
                // if city name is empty alert user
                DispatchQueue.main.async {
                    self.alertView.showAlertView(view: self, alertMesssage: Constants.invalidCityString)
                }
            }
        }
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    private func setupUI() {
        self.lookupButton.layer.borderWidth = 1.5
        self.lookupButton.layer.borderColor = UIColor.gray.cgColor
        self.lookupButton.layer.cornerRadius = lookupButton.frame.height / 2
        self.enterCityNameTextField.delegate = self
        self.enterCityNameTextField.clearButtonMode = .whileEditing
    }
    
    // Navigating to weather data list view controller
    private func navigateToWeatherDataListScreen(of cityName: String) {
        let storyBoard = UIStoryboard(name: Constants.mainStoryBoardName, bundle: nil)
        guard let weatherDataListViewController = storyBoard.instantiateViewController(
            withIdentifier: Constants.weatherDataListScreen) as? WeatherDataListViewController
        else { return }
        weatherDataListViewController.cityName = self.cityModel.getFormattedString(city: cityName)
        self.navigationController?.pushViewController(weatherDataListViewController, animated: false)
    }
}

//MARK: - UITextFieldDelegate
extension CityEntryViewController: UITextFieldDelegate {
  // Text field specific codes if required
}
