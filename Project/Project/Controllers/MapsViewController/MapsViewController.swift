import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private var pins: [MKPin] = []
    
    func pinPreview(_ loc: Location) {
        if pins.isEmpty {
            let pin = MKPin(
                title: loc.street.name,
                snippet: "QWEQWE",
                icon: UIImage(named: "mapsicon")!,
                coords: loc.coordinates)
            pins.append(pin)
        }
        mapView.addAnnotations(pins)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [self] in
            let center = CLLocation(
                latitude: pins.center.coordinate.latitude,
                longitude: pins.center.coordinate.longitude)
            mapView.centerLocation(center)
        })
    }
    
    static var nibName: String { String(describing: self ) }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(MKPin.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.removeAnnotations(pins)
        pins.removeAll()
    }
}

extension MapsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case let pin as MKPin:
            let id = String(describing: pin.coordinate)
            let marker = MKMarkerAnnotationView(annotation: pin,
                                                reuseIdentifier: id)
            marker.canShowCallout = true
            marker.calloutOffset = CGPoint(x: -5, y: 5)
            return marker
        default:
            fatalError()
        }
    }
}
