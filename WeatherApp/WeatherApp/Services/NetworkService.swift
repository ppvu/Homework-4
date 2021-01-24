//
//  NetworkService.swift
//  WeatherApp
//
//  Created by spezza on 19.01.2021.
//

import Foundation

class NetworkService {
    
    let urlApiKey = "5f3b95f9256ec76f44d734d702f99850"
    let urlBase = "https://api.openweathermap.org/data/2.5/"
    
    let session = URLSession(configuration: .default)
    
    func buildURLWithCoords(lat: Double, lon: Double) -> String {
        return urlBase + "onecall" + "?lat=" + String(lat) + "&lon=" + String(lon) + "&units=metric" + "&appid=" + urlApiKey
    }
    
    func buildURL(city: String) -> String {
        return urlBase + "weather" + "?q=" + city + "&units=metric" + "&appid=" + urlApiKey
    }
    
    func getWeatherByCoords(lat: Double, lon: Double, onSuccess: @escaping (Forecast) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: buildURLWithCoords(lat: lat, lon: lon)) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    print(String(data: data, encoding: .utf8) ?? "")
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Forecast.self, from: data)
                        onSuccess(items)
                        
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
    
    // Get weather by city name.
    func getWeatherByCityName(city: String,
                              onSuccess: @escaping (CurrentWeather) -> Void,
                              onError: @escaping (String) -> Void) {
        
        guard let url = URL(string: buildURL(city: city)) else {
            onError("Error building URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(CurrentWeather.self, from: data)
                        onSuccess(items)
                    } else {
                        onError("Response wasn't 200. It was: " + "\n\(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getWeatherForAllCities(cities: [String], handler: @escaping ([CurrentWeather]) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var currentWeathers = [CurrentWeather]()
        
        var errors = [String]()
        
        for city in cities {
            dispatchGroup.enter()
            getWeatherByCityName(city: city, onSuccess: { currentWeather in
                currentWeathers.append(currentWeather)
                dispatchGroup.leave()
                
            }, onError: { error in
                errors.append(error)
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print(errors)
            handler(currentWeathers)
        }
    }
}


