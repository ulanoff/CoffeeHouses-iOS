// 
//  CafesMapViewController.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 25.12.2023.
//

import UIKit
import SnapKit
import YandexMapsMobile

protocol CafesMapViewProtocol: AnyObject {
    func showPlacemarks(_ placemarks: [CafePlacemark])
}

final class CafesMapViewController: UIViewController {
    var presenter: CafesMapPresenterProtocol?
    private let userLocationService = UserLocationService.shared
    
    // MARK: - UI Elements

    private lazy var mapView = YMKMapView()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        moveMapToUser()
    }
}

// MARK: - Private Methods

private extension CafesMapViewController {
    func moveMapToUser() {
        userLocationService.getUsersCurrentLocation { [weak self] result in
            switch result {
            case .success(let location):
                let targetPoint = YMKPoint(
                    latitude: location.latitude,
                    longitude: location.longitude
                )
                self?.moveToPoint(targetPoint)
            case .failure(_):
                let targetPoint = YMKPoint(
                    latitude: 55.7558,
                    longitude: 37.6173
                )
                self?.moveToPoint(targetPoint)
            }
        }
    }
    
    func addPlacemarks(_ placemarks: [CafePlacemark]) {
        let map = mapView.mapWindow.map
        let image: UIImage = .mapPoint
        placemarks.forEach{ placemarkModel in
            let placemark = map.mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(
                latitude: placemarkModel.location.latitude,
                longitude: placemarkModel.location.longitude
            )
            placemark.userData = placemarkModel.cafeId
            placemark.setIconWith(image)
            placemark.addTapListener(with: self)
            placemark.setTextWithText(
                placemarkModel.name,
                style: YMKTextStyle(
                    size: 14,
                    color: .chBrown,
                    outlineColor: .white,
                    placement: .bottom,
                    offset: 0,
                    offsetFromIcon: true,
                    textOptional: false
                )
            )
        }
    }
    
    func moveToPoint(_ point: YMKPoint) {
        let map = mapView.mapWindow.map
        map.move(
            with: YMKCameraPosition(
                target: point,
                zoom: 10,
                azimuth: 0,
                tilt: 30
            ),
            animation: YMKAnimation(
                type: .smooth,
                duration: 2.0
            )
        )
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        // Subviews
        view.addSubview(mapView)
        
        // Constraints
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        // Views Configuration
        view.backgroundColor = .chWhite
        title = "cafesMap-title"~
    }
}

// MARK: - YMKMapObjectTapListener

extension CafesMapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        
        
        guard let id = mapObject.userData as? Int else {
            assertionFailure()
            return false
        }
        presenter?.cafePlacemarkTapped(cafeId: id)
        return true
    }
}

// MARK: - CafesMapViewProtocol

extension CafesMapViewController: CafesMapViewProtocol {
    func showPlacemarks(_ placemarks: [CafePlacemark]) {
        addPlacemarks(placemarks)
    }
}
