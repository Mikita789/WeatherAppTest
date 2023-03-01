//
//  CurrentWeatherModel.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import Foundation


struct CurrentWeather:Codable{
    let temp, feelsLike: Double
    let name:String
    let discr:String
    
    var im:String{
        switch discr{
        case "ясно" : return "sun.max"
        case "пасмурно" : return "cloud.circle"
        case "снег" : return "snowflake"
        case "дождь" : return "cloud.rain.fill"
        case "гроза" : return "cloud.bolt.rain.fill"
        case "облачно с прояснениями" : return "cloud.sun"
        case "переменная облачность" : return "cloud.sun.fill"
        default: return "pawprint"
        }
    }
    
    
    
    init(weatherData: WeatherData ) {
        self.temp = weatherData.main.temp
        self.feelsLike = weatherData.main.feelsLike
        self.name = weatherData.name
        self.discr = weatherData.weather.first?.description ?? "ясно"
    }
    
}
