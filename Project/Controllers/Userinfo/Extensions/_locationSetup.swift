import Foundation

extension UserinfoVC {
    internal func _locationSetup(_ result: Results) {
        let loc = result.location; self.location = loc
        let country = String(describing: loc.country ?? "") + ", "
        let state = String(describing: loc.state ?? "") + ", "
        let city = String(describing: loc.city ?? "")
        
        locationLabel.text = country + state + city
        
        guard let locShort = locationLabel.text else { return }
        let street = loc.street.name + ", "
        let n = String(describing: loc.street.number)
        address = locShort + street + n
        
        _timezoneSetup(result)
        _locationIconConfig()
    }
}
