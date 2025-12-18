//
//  SceneDelegate.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 2.12.2025.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = determineInitialViewController()
        window?.makeKeyAndVisible()
    }
    
    func determineInitialViewController() -> UIViewController {
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "seenOnboarding")
        let currentUser = Auth.auth().currentUser
        
        if !hasSeenOnboarding {
            return OnboardingVC()
        }
        if let user = currentUser, user.isEmailVerified == false {
            return UINavigationController(rootViewController: ValidateEmailVC())
        }
        if currentUser == nil {
            return UINavigationController(rootViewController: SignInVC())
        }
        return createTabbar()
    }
    
    func createHomeNavigationController() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: SFSymbols.house), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createCalendarNavigationController() -> UINavigationController {
        let calendarVC = CalendarVC()
        calendarVC.title = "DayZ"
        calendarVC.tabBarItem = UITabBarItem(title: "DayZ", image: UIImage(systemName: SFSymbols.calendar), tag: 1)
        
        return UINavigationController(rootViewController: calendarVC)
    }
    
    func createProfileNavigationController() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: SFSymbols.emptyProfile), tag: 2)
        
        return UINavigationController(rootViewController: profileVC)
    }
    
    func createTabbar() -> UITabBarController{
        let tabbar = UITabBarController()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = .black
        
        tabbar.viewControllers = [createHomeNavigationController(), createCalendarNavigationController(), createProfileNavigationController()]
        
        return tabbar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

