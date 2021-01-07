import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var pins: [MKPin] = []
    
    private var quene: DispatchQueue!
    private var group: DispatchGroup!
    func pinPreview(_ loc: Location) {
        group.enter()
        quene.async { [self] in
            _ = group.wait(wallTimeout: .now() + 2)
            let pin = MKPin(
                title: loc.city,
                snippet: loc.street.name + ", " + String(loc.street.number),
                icon: UIImage(named: "mapsicon")!,
                coords: loc.coordinates)
            pins.append(pin)
            mapView.addAnnotations(pins)
            do { group.leave() }
        }
        
        group.notify(queue: .main, execute: { [self] in
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
        self.quene = DispatchQueue(label: "com.MapsViewController.quene")
        self.group = DispatchGroup()
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
            fatalError("MKAnnotation Class Error")
        }
    }
}
