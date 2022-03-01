//
//  TabBarViewController.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabList = UINavigationController(rootViewController: ListViewController())
        
        let tabListBarItem = UITabBarItem(title: "List View", image: nil, selectedImage: nil)
        
        tabList.tabBarItem = tabListBarItem
        
        let tabMap = MapViewController()
        
        let tabMapBarItem = UITabBarItem(title: "Map View", image: nil, selectedImage: nil)
        
        tabMap.tabBarItem = tabMapBarItem
        
        self.viewControllers = [tabList, tabMap]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
