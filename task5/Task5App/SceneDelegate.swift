// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options: UIScene.ConnectionOptions) {
        guard let ws = scene as? UIWindowScene else { return }
        let w = UIWindow(windowScene: ws)
        w.rootViewController = UINavigationController(rootViewController: GradesInputViewController())
        w.makeKeyAndVisible()
        window = w
    }
}
