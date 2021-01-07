import Foundation

extension UserinfoVC {
    public func userAge(_ result: Result) {
        let df1: DateFormatter = .iso8601Full
        let df2: DateFormatter = .ddMMyyyy // ДД.ММ.ГГГГ
        
        if let raw = result.dob.date,
           let iso = df1.date(from: raw) {
            dateOfBirth.text = df2.string(from: iso)
            if let age = result.dob.age, let years = ages.text?.replacingOccurrences(of: "00", with: String(age)) {
                do { ages.text = years }
            } else {
                ages.removeSubviews()
            }
        }
    }
}
