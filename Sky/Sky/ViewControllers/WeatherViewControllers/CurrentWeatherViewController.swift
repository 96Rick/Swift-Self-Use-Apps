 //
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Rick on 2018/9/10.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import UIKit

 protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: WeatherViewController)
    func settingsButtonPressed(controller: WeatherViewController)
 }
 
class CurrentWeatherViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    @IBAction func locationButtonDidPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonDidPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self )
    }
    
    var now: WeatherData? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    func updateView() {
         activityIndicatorView.stopAnimating()
        
        if let now = now, let location = location {
            updateWeatherContainer(with: now, at: location)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Fetch weather / Location Failed"
        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at location: Location) {
        weatherContainerView.isHidden = false
        
        locationLabel.text = location.name
        
        temperatureLabel.text = String(format: "%.1f °C", data.currently.temperature.toCelcius())
        
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        
        humidityLabel.text = String(format: "%.1f", data.currently.humidity)
        
        summaryLabel.text = data.currently.summary
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E dd MMMM"
        dateLabel.text = formatter.string(from: data.currently.time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
