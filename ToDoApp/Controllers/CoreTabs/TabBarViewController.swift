//
//  TabBarViewController.swift
//  ToDoApp
//
//  Created by Alisher Abdulin on 12.01.2023.
//

import Foundation

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
        

    
    }
    
    private func setUpControllers() {
        let home = ActivityViewController()
        home.title = "Home"
        
        let todo = ToDoViewController()
        todo.title = "To do"
        
        let profile = ProfileViewController()
        profile.title = "Profile"
        
//        let stopwatch = StopwatchSettingsViewController()
//        stopwatch.title = "Stopwatch"
        
        
        
        home.navigationItem.largeTitleDisplayMode = .always
        todo.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
//        stopwatch.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: todo)
        let nav3 = UINavigationController(rootViewController: profile)
//        let nav4 = UINavigationController(rootViewController: stopwatch)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
//        nav4.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "checkmark.circle"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 3)
//        nav4.tabBarItem = UITabBarItem(title: "Stopwatch", image: UIImage(systemName: "timer"), tag: 4)
        
        
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }

}
