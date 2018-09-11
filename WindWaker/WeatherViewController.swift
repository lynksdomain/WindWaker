//
//  WeatherViewController.swift
//  WindWaker
//
//  Created by C4Q on 9/11/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var unitSwitch: UIButton!
    @IBOutlet weak var weatherCV: UICollectionView!
    var useFarenheit = true
    var forecast = [Weather]() {
        didSet {
            weatherCV.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherCV.dataSource = self
        weatherCV.delegate = self
        WeatherAPIClient.manager.getWeather(completionHandler: { (sevenDayForecast) in
            self.forecast = sevenDayForecast
        }) { (error) in
            print(error)
        }
    }
    
    func getDisplayDate(timestamp:Double) -> (date: String,weekday: String) {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDayNumber = myCalendar.component(.weekday, from: date)
        var weekDay = ""
        switch weekDayNumber {
        case 1:
            weekDay = "Sunday"
        case 2:
            weekDay = "Monday"
        case 3:
            weekDay = "Tuesday"
        case 4:
            weekDay = "Wednesday"
        case 5:
            weekDay = "Thursday"
        case 6:
            weekDay = "Friday"
        case 7:
            weekDay = "Saturday"
        default:
            weekDay = "error"
        }
        return (dateString,weekDay)
    }
    @IBAction func unitSwitchPressed(_ sender: UIButton) {
        if useFarenheit {
            useFarenheit = false
            unitSwitch.setTitle("Farenheit", for: .normal)
        } else {
            useFarenheit = true
            unitSwitch.setTitle("Celcius", for: .normal)
        }
        weatherCV.reloadData()
    }
}



extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCollectionViewCell
        let selectedForecast = forecast[indexPath.row]
        let dateInfo = getDisplayDate(timestamp: Double(selectedForecast.timestamp))
        
        if useFarenheit {
            cell.maxTempLabel.text = selectedForecast.maxTempF.description + "°F"
        } else {
            cell.maxTempLabel.text = selectedForecast.maxTempC.description + "°C"
        }
        
        
        
        cell.dateLabel.text = dateInfo.date + " " + dateInfo.weekday
        cell.weatherImage.image = UIImage(named: selectedForecast.icon)
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
        

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (collectionView.bounds.width), height: collectionView.bounds.height * 0.95)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 0
        }
    }
    
    
    

