//
//  ApI.swift
//  Test3
//
//  Created by Bogdan Marica on 06/12/2019.
//  Copyright © 2019 Florin Precup. All rights reserved.
//

import Foundation

class API {

    private init(){}

    static let sharedInstance = API()

    func getData(forCity:String, dp:DispatchGroup, succes: @escaping (DataModel) -> Void){
        dp.enter()
        let session = URLSession.shared
        let url = URL(string: "http://api.weatherstack.com/current?access_key=efa1ee506917219171068ad3fce1db44&query=\(forCity)")!

        let task = session.dataTask(with: url,
        completionHandler: { (data, response, error) in
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: [])
            //                print(json)
                            if let dictionary = json as? [String: Any] {
                                if let dictionary2 = dictionary["current"] as? [String: Any] {
                                    let weather_descriptions = dictionary2["weather_descriptions"] as! [String]
                                    let temperature = dictionary2["temperature"] as! Double
                                    let weather_description = "description: \(weather_descriptions[0])"
                                    let temp = "temperature: \(temperature)"
                                    dp.leave()
                                    succes(DataModel(city: forCity, data1: weather_description, data2: temp))
                                }
                            }
                        } catch {
                            print("JSON error: \(error.localizedDescription)")
                        }

        })
        task.resume()
    }
}
