//
//  NetwManager.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 27.02.23.
//

import Foundation



struct NetworkManager{
    weak var delegate:CurrentWeatherDelegate? = nil
    
    func currentWeatherDate(cityName:String){
        var urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&lang=ru&units=metric&appid=a9a0b74f3e9fa3791aba58556db76d6f"
        guard let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string:urlString) else {
            print("broken url!")
            return }
        
        
        let _ = URLSession.shared.dataTask(with: url, completionHandler: {data,req,error in
            guard let data = data else {
                print("no data")
                return }
            guard let result = parseJS(data: data) else {
                print("error parse")
                return }
            self.delegate?.appendCurrenWeatherModel(item: result)
            
        }).resume()
    }
    
    private func parseJS(data:Data)->CurrentWeather?{
        let decoder = JSONDecoder()
        guard let data = try? decoder.decode(WeatherData.self, from: data) else {
            print("error decode")
            return nil }
        let result = CurrentWeather(weatherData: data)
        return result
    }
    
}
