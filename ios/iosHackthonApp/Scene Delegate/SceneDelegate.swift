import UIKit
import SwiftUI
import shared
import Components

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  private let loginViewModel = LoginViewModel(firebase: FirebaseAuthenticationStore(), authorizationStore: AuthorizationStore(cache: UserDefaults.standard))

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    let appState = AppState()
    let loginView = LoginView(viewModel: loginViewModel).environmentObject(appState)

    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: loginView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }

  func sceneDidDisconnect(_ scene: UIScene) {}

  func sceneDidBecomeActive(_ scene: UIScene) {}

  func sceneWillResignActive(_ scene: UIScene) {}

  func sceneWillEnterForeground(_ scene: UIScene) {}

  func sceneDidEnterBackground(_ scene: UIScene) {}
}
