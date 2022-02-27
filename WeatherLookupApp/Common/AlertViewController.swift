//
//  AlertViewController.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 27/02/22.
//

/* Common class for all alert Views */
import UIKit

class AlertViewController {
    // to show an alert view with a single message and a single ok button
    func showAlertView(view: UIViewController?, alertMesssage: String?){
        let alert = UIAlertController(title: Constants.errorString, message: alertMesssage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.okString, style: .default, handler: {_ in
            view?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        view?.present(alert, animated: true)
    }
}
