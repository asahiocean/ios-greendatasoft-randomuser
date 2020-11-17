import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            if let window = window {
                
                class NavigationController: UINavigationController {
                    private var tableView = TableViewController()
                    override func viewDidLoad() {
                        super.viewDidLoad()
                        self.viewControllers = [tableView]
                    }
                }
                
                window.rootViewController = NavigationController()
                window.makeKeyAndVisible()
            }
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
