import Foundation
import FontAwesome_swift

extension UserinfoVC {
    internal func _genderSetup(_ result: Result) {
        switch result.gender {
        case .male:
            DispatchQueue.main.async { [self] in
                genderIcon.image = .fontAwesomeIcon(
                    name: .mars,
                    style: .solid,
                    textColor: #colorLiteral(red: 0.2030032575, green: 0.2080235779, blue: 0.2164820433, alpha: 1),
                    size: genderIcon.bounds.size)
            }
        case .female:
            DispatchQueue.main.async { [self] in
            genderIcon.image = .fontAwesomeIcon(
                name: .venus,
                style: .solid,
                textColor: #colorLiteral(red: 0.2030032575, green: 0.2080235779, blue: 0.2164820433, alpha: 1),
                size: genderIcon.bounds.size)
            }
        }
    }
}
