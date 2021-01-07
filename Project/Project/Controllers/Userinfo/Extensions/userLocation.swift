import Foundation

extension UserinfoVC {
    public func userLocation(_ result: Result) {
        let loc = result.location; self.location = loc
        let country = String(describing: loc.country ?? "") + ", "
        let state = String(describing: loc.state ?? "") + ", "
        let city = String(describing: loc.city ?? "")
        
        locationLabel.text = country + state + city
        
        guard let locShort = locationLabel.text else { return }
        let street = loc.street.name + ", "
        let n = String(describing: loc.street.number)
        address = locShort + street + n
        
        userTimezone(result)
        userLocationIcon()
    }
}
