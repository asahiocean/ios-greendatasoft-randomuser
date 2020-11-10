import Foundation

extension UserinfoVC {
    internal func _ageSetup(_ result: Results) {
        dateOfBirth.text = result.dob.date
        if let ageInt = result.dob.age,
           let ageStr = ages.text?.replacingOccurrences(of: "00", with: String(describing: ageInt)) {
            defer { ages.text = ageStr }
        } else {
            ages.removeSubviews()
        }
    }
}
