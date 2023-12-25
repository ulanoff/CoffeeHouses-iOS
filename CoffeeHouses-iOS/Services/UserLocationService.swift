//
//  UserLocationService.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 24.12.2023.
//

import CoreLocation

enum LocationError: Error, LocalizedError {
    case notAvailable
    case usageRestricted
    case usageDenied
    
    var errorDescription: String? {
        switch self {
        case .notAvailable:
            "error-locationNotAvailable"~
        case .usageRestricted:
            "error-locationUsageRestricted"~
        case .usageDenied:
            "error-locationUsageDenied"~
        }
    }
}

struct Location {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init?(mapPoint: MapPoint) {
        guard let clLatitude = CLLocationDegrees(mapPoint.latitude),
              let clLongitude = CLLocationDegrees(mapPoint.longitude)
        else {
            return nil
        }
        latitude = clLatitude
        longitude = clLongitude
    }
}

typealias LocationCompletion =  (Result<Location, LocationError>) -> Void

final class UserLocationService: NSObject, CLLocationManagerDelegate {
    static let shared = UserLocationService()
    
    private let locationManager: CLLocationManager
    private var closuresQueue: [LocationCompletion] = []
    
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    func getUsersCurrentLocation(completion: @escaping LocationCompletion) {
        closuresQueue.append(completion)
        locationManager.requestLocation()
    }
    
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            if !closuresQueue.isEmpty {
                closuresQueue.forEach { $0(.failure(.usageRestricted)) }
            }
        case .denied:
            if !closuresQueue.isEmpty {
                closuresQueue.forEach { $0(.failure(.usageDenied)) }
            }
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            if !closuresQueue.isEmpty {
                locationManager.requestLocation()
            }
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let clLocation = locations.first {
            let location = Location(
                latitude: clLocation.coordinate.latitude,
                longitude: clLocation.coordinate.longitude
            )
            closuresQueue.forEach { $0(.success(location)) }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
