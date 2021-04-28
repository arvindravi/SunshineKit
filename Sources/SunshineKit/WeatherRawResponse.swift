// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weatherRawResponse = try? newJSONDecoder().decode(WeatherRawResponse.self, from: jsonData)

import Foundation

// MARK: - WeatherRawResponse
public struct WeatherRawResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
public struct DataClass: Codable {
    let request: [Request]
    let weather: [Weather]
}

// MARK: - Request
public struct Request: Codable {
    let type, query: String
}

// MARK: - Weather
public struct Weather: Codable {
    let date: String
    let astronomy: [Astronomy]
    let maxtempC, maxtempF, mintempC, mintempF: String
    let uvIndex: String
    let hourly: [Hourly]
}

// MARK: - Astronomy
public struct Astronomy: Codable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase, moonIllumination: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

// MARK: - Hourly
public struct Hourly: Codable {
    let time, tempC, tempF, windspeedMiles: String
    let windspeedKmph, winddirDegree, winddir16Point, weatherCode: String
    let weatherIconURL, weatherDesc: [WeatherDescElement]
    let precipMM, precipInches, humidity, visibility: String
    let visibilityMiles, pressure, pressureInches, cloudcover: String
    let heatIndexC, heatIndexF, dewPointC, dewPointF: String
    let windChillC, windChillF, windGustMiles, windGustKmph: String
    let feelsLikeC, feelsLikeF, sigHeightM, swellHeightM: String
    let swellHeightFt, swellDir, swellDir16Point, swellPeriodSecs: String
    let waterTempC, waterTempF, uvIndex: String

    enum CodingKeys: String, CodingKey {
        case time, tempC, tempF, windspeedMiles, windspeedKmph, winddirDegree, winddir16Point, weatherCode
        case weatherIconURL = "weatherIconUrl"
        case weatherDesc, precipMM, precipInches, humidity, visibility, visibilityMiles, pressure, pressureInches, cloudcover
        case heatIndexC = "HeatIndexC"
        case heatIndexF = "HeatIndexF"
        case dewPointC = "DewPointC"
        case dewPointF = "DewPointF"
        case windChillC = "WindChillC"
        case windChillF = "WindChillF"
        case windGustMiles = "WindGustMiles"
        case windGustKmph = "WindGustKmph"
        case feelsLikeC = "FeelsLikeC"
        case feelsLikeF = "FeelsLikeF"
        case sigHeightM = "sigHeight_m"
        case swellHeightM = "swellHeight_m"
        case swellHeightFt = "swellHeight_ft"
        case swellDir, swellDir16Point
        case swellPeriodSecs = "swellPeriod_secs"
        case waterTempC = "waterTemp_C"
        case waterTempF = "waterTemp_F"
        case uvIndex
    }
}

// MARK: - WeatherDescElement
public struct WeatherDescElement: Codable {
    let value: String
}
