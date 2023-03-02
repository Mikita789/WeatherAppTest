//
//  CurrentWeatherDelegate.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import Foundation


protocol CurrentWeatherDelegate:AnyObject{
    func appendCurrenWeatherModel(item: CurrentWeather)
}
