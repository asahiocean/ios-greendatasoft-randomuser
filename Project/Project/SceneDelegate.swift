import UIKit

func windowSceneConfig(_ window: UIWindow) {
    let navigationController = UINavigationController()
    let tableViewController = TableViewController()
    navigationController.viewControllers.append(tableViewController)
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { fatalError("scene != UIWindowScene") }
        self.window = UIWindow(windowScene: windowScene)
        guard let window = window else { fatalError("UIWindow nil") }
        windowSceneConfig(window)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}
