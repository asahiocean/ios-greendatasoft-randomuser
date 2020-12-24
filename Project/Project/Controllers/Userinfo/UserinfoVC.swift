import UIKit

class UserinfoVC: UIViewController {
    
    static var nib: String { String(describing: self) }
    
    @IBOutlet weak var bgGradientPhoto: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    internal var address: String?
    internal var location: Location?
    
    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var ages: UILabel!
    @IBOutlet weak var localtime: UILabel!
    
    internal var interactionMap: UIContextMenuInteraction!
    internal var interactionPhoto: UIContextMenuInteraction!
    internal var interactionName: UIContextMenuInteraction!
    internal var interaction_Email: UIContextMenuInteraction!
    
    private(set) var result: Result?
    
    public func setResult(_ result: Result) {
        userPhoto(result)
        userName(result)
        userEmail(result)
        userAge(result)
        userGender(result)
        userLocation(result)
        self.result = result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Info"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let username = try? result?.name.jsonString() {
            API.shared.report(key: "Currently viewed", value: username)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let username = try? result?.name.jsonString() {
            API.shared.report(key: "Viewing is over", value: username)
        }
    }
}
