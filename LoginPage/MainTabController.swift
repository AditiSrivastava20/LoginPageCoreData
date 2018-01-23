//
//  MainTabController.swift
//  LoginPage
//
//  Created by brst on 1/12/18.
//  Copyright © 2018 loginScreen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainTabController: UITabBarController {
    
//    var userModel: LoginViewController?
//    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserFields")
//        let searchString = userModel?.txtemail.text
//        let searcghstring2 = userModel?.txtpassword.text
//        request.predicate = NSPredicate (format: "name == %@", searchString ?? "")
//        do
//        {
//            let result = try context.fetch(request)
//            if result.count > 0
//            {
//                let   n = (result[0] as AnyObject).value(forKey: "name") as! String
//                let p = (result[0] as AnyObject).value(forKey: "password") as! String
//                //  print(" checking")
//                
//                
//                if (searchString == n && searcghstring2 == p)
//                {
//                    
//                    
//                    let UserDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController")  as! UserDetailsViewController
//                    UserDetailsVc.myStringValue = userModel?.txtemail.text
//                   
//                    self.navigationController?.pushViewController(UserDetailsVc, animated: true)
//                    
//                    
//                }
//                else if (searchString == n || searcghstring2 == p)
//                {
//                   
//                    let alertController1 = UIAlertController (title: "no user found ", message: "password incorrect ", preferredStyle: UIAlertControllerStyle.alert)
//                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                    present(alertController1, animated: true, completion: nil)
//                }
//            }
//            else
//            {
//                let alertController1 = UIAlertController (title: "no user found ", message: "invalid username ", preferredStyle: UIAlertControllerStyle.alert)
//                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alertController1, animated: true, completion: nil)
//                print("no user found")
//            }
//        }
//        catch
//        {
//            print("error")
//        }
//        
//    }
    
}
}
