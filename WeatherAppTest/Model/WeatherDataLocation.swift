//
//  WeatherDataLocation.swift
//  WeatherAppTest
//
//  Created by Никита Попов on 2.03.23.
//

import Foundation


struct NetworkManagerLocation{
    weak var delegate:CurrentWeatherDelegate? = nil
    
    func currentWeatherDate(lat:String, long:String){
        var urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&lang=ru&units=metric&appid=a9a0b74f3e9fa3791aba58556db76d6f"
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
        guard let data = try? decoder.decode(WeatherData.self, from: data) else { return nil }
        let result = CurrentWeather(weatherData: data)
        return result
    }
    
}
