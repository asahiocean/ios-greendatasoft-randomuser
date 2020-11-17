import Foundation

extension UserinfoVC {
    internal func _ageSetup(_ result: Result) {
        let formatter1: DateFormatter = .iso8601Full
        let formatter2: DateFormatter = .ddMMyyyy // ДД.ММ.ГГГГ
        
        guard let rawDate = try? jsonDecoder().decode(String.self, from: (result.dob.date?.data(using: .utf8))!) else { return }
        if let isoDate = formatter1.date(from: rawDate) {
            dateOfBirth.text = formatter2.string(from: isoDate)
        } else {
            dateOfBirth.text = .none
        }
        
        if let ageInt = result.dob.age,
           let ageStr = ages.text?.replacingOccurrences(of: "00", with: String(describing: ageInt)) {
            do { ages.text = ageStr }
        } else {
            ages.removeSubviews()
        }
    }
}
