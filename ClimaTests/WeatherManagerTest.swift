import XCTest
import Foundation
@testable import Clima

class WeatherManagerTest: XCTestCase {
    var weatherManager: WeatherManager?
    var expected: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        weatherManager = WeatherManager(urlSessionProtocol: MockedURLSession())
        weatherManager?.delegate = self
    }

    override func tearDown() {
        super.tearDown()
        self.weatherManager = nil
        self.weatherManager?.delegate = nil
    }
    
    func testFetchWeatherWithCityName() {
        self.expected = expectation(description: "Weather is done fetching")
        self.weatherManager?.fetchWeather(cityName: "testCityName")
        waitForExpectations(timeout: 2)
    }
}


extension WeatherManagerTest: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        XCTAssertTrue(weather.cityName == "Paris")
        expected?.fulfill()
    }
    
    func didFailWithError(error: Error) {
        
    }
}

