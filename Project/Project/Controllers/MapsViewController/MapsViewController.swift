import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    func pinPreview(_ loc: Location) {
        let quene = DispatchQueue(label: "pinPreview")
        let group = DispatchGroup()
        var pins: [MKPin] = [] { didSet { do { group.leave() } } }
        
        group.enter()
        quene.async {
            _ = group.wait(wallTimeout: .now() + 1)
            let pin = MKPin(
                title: loc.city,
                snippet: loc.street.name + ", " + String(loc.street.number),
                icon: UIImage(named: "mapsicon")!,
                coords: loc.coordinates)
            pins.append(pin)
            self.mapView.addAnnotations(pins)
        }
        
        group.notify(queue: quene, execute: { [self] in
            DispatchQueue.main.async {
                let center = CLLocation(
                    latitude: pins.center.coordinate.latitude,
                    longitude: pins.center.coordinate.longitude)
                mapView.centerLocation(center)
            }
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
        for anno in mapView.annotations {
            mapView.removeAnnotation(anno)
        }
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
