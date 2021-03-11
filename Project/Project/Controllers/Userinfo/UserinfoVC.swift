import UIKit

class UserinfoVC: UIViewController {
    
    static var id: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: id, bundle: nil) }
    
    @IBOutlet weak var bgPhotoBlur: UIView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var mapIconImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var genderIcon: UIImageView!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var ages: UILabel!
    @IBOutlet weak var localtime: UILabel!
    
    internal var userPhotoInter: UIContextMenuInteraction!
    internal var fullnameLabelInter: UIContextMenuInteraction!
    internal var emailLabelInter: UIContextMenuInteraction!
    internal var mapIconInter: UIContextMenuInteraction!
    internal var locationLabelInter: UIContextMenuInteraction!
    
    internal var address: String?
    internal var location: Location?
    
    private(set) var result: Result?
    
    public func setResult(_ result: Result) {
        self.result = result
        
        //MARK: -- SETTING USER PHOTO
        let urlImage: String = result.picture.largeUrl
        API.shared.loadImage(urlImage, { [weak self] (image) -> Void in
            DispatchQueue.main.async {
                self?.userPhotoImageView.image = image
            }
        })
        
        DispatchQueue.main.async { [self] in
            bgPhotoBlur.backgroundColor = UIColor(patternImage: userPhotoImageView.image ?? UIImage(named: "RoyalBlueGradient")!)
            userPhotoImageView.layer.cornerRadius = userPhotoImageView.bounds.width / 2
            userPhotoImageView.layer.masksToBounds = true
            userPhotoImageView.layer.borderColor = #colorLiteral(red: 0.2031390071, green: 0.2078698874, blue: 0.2164929211, alpha: 1)
            userPhotoImageView.layer.borderWidth = 5
        }
        
        //MARK: -- SETTING USERNAME
        if let firstname = result.name.first, let lastname = result.name.last {
            fullnameLabel.text = firstname + " " + lastname
        }
        
        //MARK: -- SETTING USER EMAIL
        emailLabel.text = result.email
        
        //MARK: -- SETTING USER AGE
        if let raw = result.dob.date, let iso8601 = DateFormatter.iso8601Full.date(from: raw) {
            self.dateOfBirth.text = DateFormatter.ddMMyyyy.string(from: iso8601)
            switch result.dob.age {
            case .some(let age):
                if let yo = ages.text?.replacingOccurrences(of: "00", with: age.description) {
                    self.ages.text = yo
                }
            default:
                self.ages.removeSubviews()
            }
        }
        
        //MARK: -- SETTING USER GENDER
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
        
        //MARK: -- SETTING USER LOCATION
        let loc = result.location; self.location = loc
        let country = String(describing: loc.country ?? "") + ", "
        let state = String(describing: loc.state ?? "") + ", "
        let city = String(describing: loc.city ?? "")
        
        locationLabel.text = country + state + city
        
        guard let locShort = locationLabel.text else { return }
        let street = loc.street.name + ", "
        let n = String(describing: loc.street.number)
        address = locShort + street + n
        
        if let tz = result.location.timezone.offset {
            let format = DateFormatter()
            format.dateFormat = "HH:mm"
            format.timeZone = TimeZone(identifier: "GMT" + tz)
            
            localtime.text = format.string(from: .init()) + " (GMT \(tz.prefix(2)))"
        }
        
        //MARK: -- LOCATION ICON
        mapIconImageView.layer.masksToBounds = false
        mapIconImageView.layer.cornerRadius = 10
        mapIconImageView.layer.shadowColor = UIColor.black.cgColor
        mapIconImageView.layer.shadowRadius = 3
        mapIconImageView.layer.shadowOffset = .zero
        mapIconImageView.layer.shadowOpacity = 0.5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Info"
        userPhotoInter = .init(delegate: self)
        userPhotoImageView.addInteraction(userPhotoInter)
        
        fullnameLabelInter = .init(delegate: self)
        fullnameLabel.addInteraction(fullnameLabelInter)
        
        emailLabelInter = .init(delegate: self)
        emailLabel.addInteraction(emailLabelInter)
        
        mapIconInter = .init(delegate: self)
        mapIconImageView.addInteraction(mapIconInter)
        
        locationLabelInter = .init(delegate: self)
        locationLabel.addInteraction(locationLabelInter)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let username = try? result?.name.jsonString() {
            API.report(key: "Currently viewed", value: username)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let username = try? result?.name.jsonString() {
            API.report(key: "Viewing is over", value: username)
        }
    }
}
