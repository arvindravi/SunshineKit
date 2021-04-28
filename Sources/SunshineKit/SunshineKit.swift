import Foundation
import Combine
import CoreLocation

protocol SunshineKitType: AnyObject {
    func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, Error>
}

final class SunshineKit: SunshineKitType {
    
    private let session: URLSession
    private static let APIKey: String = "58a4b14287eb47abb01141445212804"
    private let decoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum Endpoint {
        static let baseURL = URL(string: "http://api.worldweatheronline.com/premium/v1/marine.ashx?key=\(APIKey)&format=json")!
        
        case weather(CLLocation)
        
        var url: URL {
            switch self {
            case .weather(let location):
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                return Endpoint.baseURL.appendingPathComponent("&q=\(latitude),\(longitude)")
            }
        }
    }
    
    func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, Error> {
        session.dataTaskPublisher(for: Endpoint.weather(location).url)
            .receive(on: DispatchQueue(label: "background.queue"))
            .map(\.data)
            .decode(type: WeatherRawResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
