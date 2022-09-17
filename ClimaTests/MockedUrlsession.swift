
import Foundation
@testable import Clima

class MockedURLSession: URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockedURLSessionDataTask(completion: completionHandler)
    }
}


class MockedURLSessionDataTask: URLSessionDataTaskProtocol {
    private let completion: (Data?, URLResponse?, Error?) -> Void
    
    let respondedJSON = """
        {
          "coord": {
            "lon": 2.3488,
            "lat": 48.8534
          },
          "weather": [
            {
              "id": 804,
              "main": "Clouds",
              "description": "overcast clouds",
              "icon": "04d"
            }
          ],
          "base": "stations",
          "main": {
            "temp": 17.56,
            "feels_like": 16.78,
            "temp_min": 15.34,
            "temp_max": 19.77,
            "pressure": 1015,
            "humidity": 54
          },
          "visibility": 10000,
          "wind": {
            "speed": 5.14,
            "deg": 330
          },
          "clouds": {
            "all": 100
          },
          "dt": 1663338567,
          "sys": {
            "type": 2,
            "id": 2041230,
            "country": "FR",
            "sunrise": 1663306101,
            "sunset": 1663351376
          },
          "timezone": 7200,
          "id": 2988507,
          "name": "Paris",
          "cod": 200
        }
    """
    
    init(completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completion = completion
    }
    
    func resume() {
        let data = respondedJSON.data(using: .utf8)
        
        completion(data, nil, nil)
    }
}
