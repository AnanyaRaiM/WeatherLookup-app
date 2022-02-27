//
//  ActivityIndicatorView.swift
//  WeatherLookupApp
//
//  Created by  Ananya M on 26/02/22.
//

/* Common class for activity indiactor */
import UIKit

class ActivityIndicatorView: UIActivityIndicatorView {
    // To show activity indicator
    func showActivityIndicator(view: UIView) {
        showActivityIndicator(view: view, color: .gray, style: UIActivityIndicatorView.Style.large)
    }
    
    private func showActivityIndicator(view: UIView, color: UIColor, style: UIActivityIndicatorView.Style) {
        frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        center = view.center
        hidesWhenStopped = true
        self.style = style
        view.addSubview(self)
        view.bringSubviewToFront(self)
        translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
        self.color = color
        startAnimating()
    }
    
    // To remove activity indicator
    func removeActivityIndicator() {
        superview?.isUserInteractionEnabled = true
        stopAnimating()
        removeFromSuperview()
    }
}
