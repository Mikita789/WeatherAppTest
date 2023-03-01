import UIKit
import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let data: DataClass
    let location: Location
}

// MARK: - DataClass
struct DataClass: Codable {
    let time: Date
    let values: [String: Double?]
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double
    let name, type: String
}




func JSParse(data:Data)->WeatherData?{
    let decoder = JSONDecoder()
    guard let res = try? decoder.decode(WeatherData.self, from: data) else {return nil}
    return res
}

func dataCheck(){
    guard let url = URL(string: "https://api.tomorrow.io/v4/weather/realtime?location=minsk&apikey=VIHaNecTryOEzS7E19mWdjbFVEwepZrE") else { return }
    var req = URLRequest(url: url)
    req.httpMethod = "GET"
    req.addValue("application/json", forHTTPHeaderField: "accept")
    let task = URLSession.shared.dataTask(with: req, completionHandler: {data, req, err in
        guard let data = data else { return }
        
    }).resume()
}


dataCheck()




