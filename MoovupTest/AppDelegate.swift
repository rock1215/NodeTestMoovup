//
//  AppDelegate.swift
//  MoovupTest
//
//  Created by Yansong Wang on 2022/3/1.
//

import UIKit
import Alamofire
import AlamofireImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let imageCache = AutoPurgingImageCache( memoryCapacity: 100 * 3072 * 3072, preferredMemoryUsageAfterPurge: 60 * 3072 * 3072)
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow();
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible();
        
        return true
    }

}

extension UIImageView {
    public func setImage(url: URL?, duration: TimeInterval) {
        let appDelegate:AppDelegate  = UIApplication.shared.delegate as! AppDelegate
        let imageCache = appDelegate.imageCache
        let urlStr = url!.absoluteString
        if let cachedImage = imageCache.image(withIdentifier: urlStr){
            self.image = cachedImage
        } else {
            AF.request(url!).responseImage(completionHandler: { (response) in
                if case .success(let image) = response.result {
                    self.alpha = 0
                    self.image = image
                    imageCache.add(self.image!, withIdentifier: urlStr)
                    UIView.animate(withDuration: duration, animations: {
                        self.alpha = 1
                    })
                }
            })
        }
    }
}

extension UIView {
    func removeAllSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

