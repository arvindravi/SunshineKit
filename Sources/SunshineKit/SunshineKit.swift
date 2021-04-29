import Foundation
import Combine
import CoreLocation

public protocol SunshineKitType: AnyObject {
	func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, SunshineKit.Error>
}

public final class SunshineKit: SunshineKitType {
	
	public enum Error: Swift.Error {
		case invalidURL
		case unknownError
	}
    
    private let session: URLSession
    private static let APIKey: String = "58a4b14287eb47abb01141445212804"
    private let decoder = JSONDecoder()
	private var cancellables = [AnyCancellable]()
    
    public static let shared: SunshineKitType = SunshineKit()
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum Endpoint {
        static let baseURL = URL(string: "http://api.worldweatheronline.com/premium/v1/marine.ashx")!
		static var baseURLComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        case weather(CLLocation)
        
        var url: URL? {
            switch self {
            case .weather(let location):
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
				Endpoint.baseURLComponents.queryItems = [
					URLQueryItem(name: "key", value: APIKey),
					URLQueryItem(name: "format", value: "json"),
					URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
				]
				return Endpoint.baseURLComponents.url
            }
        }
    }
    
    public func weather(for location: CLLocation) -> AnyPublisher<WeatherRawResponse, SunshineKit.Error> {
		guard let url = Endpoint.weather(location).url else {
			return Fail(error: Error.invalidURL).eraseToAnyPublisher()
		}
        print("Fetching Weather for \(url.absoluteString)")
        return session.dataTaskPublisher(for: url)
			.map(\.data)
            .decode(type: WeatherRawResponse.self, decoder: decoder)
			.mapError { (error) -> Error in
				Error.unknownError
			}
			.eraseToAnyPublisher()
    }
    
}
