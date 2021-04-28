import Foundation
import Combine
import CoreLocation

public protocol SunshineKitType: AnyObject {
    func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, Error>
}

public final class SunshineKit: SunshineKitType {
    
    private let session: URLSession
    private static let APIKey: String = "58a4b14287eb47abb01141445212804"
    private let decoder = JSONDecoder()
    
    public static let shared: SunshineKitType = SunshineKit()
    
    private init(session: URLSession = .shared) {
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
    
    public func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, Error> {
        session.dataTaskPublisher(for: Endpoint.weather(location).url)
            .receive(on: DispatchQueue(label: "background.queue"))
            .map(\.data)
            .decode(type: WeatherRawResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
