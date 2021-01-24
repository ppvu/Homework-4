//
//  Structs.swift
//  WeatherApp
//
//  Created by spezza on 19.01.2021.
//
import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
//    let current: Current
//    let minutely: [Minutely]
//    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
}

// Это более правильная структура на сегодняшний день. Данные которые АПИ возвращает может меняться, твой Current расчитан на более старую версию как я понимаю.
// Переименуешь потом структуры как хоч.
struct Coordinates: Codable {
    
    let lat, lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}


struct CurrentWeather: Codable {

    let weather: [Weather]
    let main: CurrentWeatherMain
    let city: String
    let coord: Coordinates

    enum CodingKeys: String, CodingKey {
        case weather
        case main
        case city = "name"
        case coord
    }
}

struct CurrentWeatherMain: Codable {
    let temperature: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}


// MARK: - Current
struct Current: Codable {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    let pop: Int?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, pop
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    // Тут стринга
    let main: String
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// Ты тут не учел fog, вообще плохая практика такой мап делать: есть метод, который приводит строку к виду, с first capital letter, загугли.
//enum Main: String, Codable {
//    case clear = "Clear"
//    case clouds = "Clouds"
//    case mist = "Mist"
//    case rain = "Rain"
//    case snow = "Snow"
//}

// MARK: - Daily
struct Daily: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
//    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let snow: Double?
    let uvi: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case clouds, pop, snow, uvi, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt, precipitation: Int
}
