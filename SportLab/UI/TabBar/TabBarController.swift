//
//  TabBarViewController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 11.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupController()
    }
    
    private func setupTabBar() {
//        tabBar.barTintColor = ?
//        tabBar.backgroundColor = ?
//        tabBar.tintColor = ?
//        tabBar.unselectedItemTintColor = ?
    }
    
    private func setupController() {
        let homePage = HomePageViewController()
        let trainingPage = TrainingPageViewController()
        let goalsPage = GoalsViewController()
        let profilePage = ProfileViewController()
        
        homePage.title = "SportLab"
        trainingPage.title = "Мои тренировки"
        goalsPage.title = "Мои достижения"
        profilePage.title = "Профиль"
        
        let nav1 = UINavigationController(rootViewController: homePage)
        let nav2 = UINavigationController(rootViewController: trainingPage)
        let nav3 = UINavigationController(rootViewController: goalsPage)
        let nav4 = UINavigationController(rootViewController: profilePage)
        
        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "homeLogo"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "trainingLogo"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "goalsLogo"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profileLogo"), tag: 4)
        
        nav1.title = ""
        nav2.title = ""
        nav3.title = ""
        nav4.title = ""
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: false)
    }
    
    
    
    
}
