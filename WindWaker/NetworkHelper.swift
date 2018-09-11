//
//  NetworkHelper.swift
//  WindWaker
//
//  Created by C4Q on 9/11/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func performDataTask(with url: URL, completionHandler: @escaping ((Data) -> Void), errorHandler: @escaping ((String) -> Void)) {
        
        self.urlSession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {
                    errorHandler("Data Not Received")
                    return
                }
               
                if let error = error{
                    let error = error as NSError
                    if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet{
                        errorHandler("No Internet Connection")
                    }else{
                        errorHandler(error.localizedDescription)
                    }
                }
                completionHandler(data)
            }
            }.resume()
    }
}
