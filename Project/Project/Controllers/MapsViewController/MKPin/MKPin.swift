import Foundation
import UIKit.UIImage
import MapKit

class MKPin: NSObject, MKAnnotation {
    var title: String?
    var snippet: String?
    var image: UIImage?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, snippet: String?, icon: UIImage, coords: Coordinates) {
        self.title = title ?? "Untitled"
        self.snippet = snippet ?? ""
        self.image = icon
        
        guard let lt = NumberFormatter().number(from: coords.latitude!), let ln = NumberFormatter().number(from: coords.longitude!) else { fatalError() }
        
        let lat = CLLocationDegrees(CGFloat(truncating: lt))
        let long = CLLocationDegrees(CGFloat(truncating: ln))
        self.coordinate = CLLocationCoordinate2D(latitude: lat,
                                                 longitude: long)
        super.init()
    }
}

extension Array where Element == MKPin {
    var center: CLLocation {
        guard self.count >= 1 else { return .init() }
        
        let longArray = self.map { $0.coordinate.longitude }
        let latArray = self.map { $0.coordinate.latitude }
        
        let minLong = longArray.min()!
        let maxLong = longArray.max()!
        
        let minLat =  latArray.min()!
        let maxLat =  latArray.max()!
        
        return CLLocation(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2)
    }
}
