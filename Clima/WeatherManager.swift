

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

enum WeatherFetchingError: Error {
    case locationNotRecognised
}

public struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7549ea880eeb3148174fc5b66c759e20&units=metric"
    var delegate: WeatherManagerDelegate?
    
    private let urlSessionProtocol: URLSessionProtocol
    
    public init(urlSessionProtocol: URLSessionProtocol) {
        self.urlSessionProtocol = urlSessionProtocol
    }
    
    public func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    public func fetchWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees ) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
         print(urlString)
        performRequest(with: urlString)
    }
    
    public func performRequest(with urlString: String) {
        if let url = URL(string: urlString)  {
            let task = self.urlSessionProtocol.dataTask(with: url) { (data, resonse, error) in
                if let urlErr = error{
                    self.delegate?.didFailWithError(error: urlErr)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        } else {
            self.delegate?.didFailWithError(error: WeatherFetchingError.locationNotRecognised)
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

