//
//  WeatherAPIClient.swift
//  WindWaker
//
//  Created by C4Q on 9/11/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation


class WeatherAPIClient{
    private init() {}
    static let manager = WeatherAPIClient()
    func getWeather(completionHandler: @escaping ([Weather]) -> Void, errorHandler: @escaping (String) -> Void){
        
        guard let url = URL(string: "https://api.aerisapi.com/forecasts/newyork,ny?&filter=day&limit=7&fields=periods.timestamp,periods.icon,periods.maxTempF,periods.maxTempC,periods.minTempF,periods.minTempC,periods.weather&client_id=Zgur78jpIezv4yMbcWVKw&client_secret=nhMPLaGUH02KE5UZzDg0dOJaHSRmTE7mQJkc2G3O") else{
            errorHandler("BAD URL")
            return
        }
        
        let completion: (Data) -> Void = {(data: Data) in
            
            do{
                let myDecoder = JSONDecoder()
                
                let response = try myDecoder.decode(Response.self, from: data)
                let weather = response.response[0].periods
                completionHandler(weather)
                
            } catch{
                errorHandler("weatherJSONERROR: " + error.localizedDescription)
                
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
    }
}
