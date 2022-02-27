//
//  WeatherDataListTableViewCell.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

import UIKit

protocol WeatherDataListTableViewCellDelegate: AnyObject {
    func showWeatherDetailButtonTapped(rowSelected: Int)
}

class WeatherDataListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var drillDownButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: WeatherDataListTableViewCellDelegate?
    
    // MARK: - IBAction
    @IBAction func drillDownButtonTapped(_ sender: Any) {
        self.delegate?.showWeatherDetailButtonTapped(rowSelected: drillDownButton.tag)
    }
}
