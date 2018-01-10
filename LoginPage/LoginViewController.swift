//
//  LoginViewController.swift
//  LoginPage
//
//  Created by anil kumar srivastava on 7/26/17.
//  Copyright © 2017 loginScreen. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    let nextField  = [1:2]
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.isHidden = true
        view2.isHidden = false
        txtemail.delegate = self
        txtpassword.delegate = self
        
        for i in 1...2
        {
            if let textField = self.view.viewWithTag(i) as? UITextField {
                textField.delegate = self
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup(_ sender: Any) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserFields")
        let searchString = self.txtemail.text
        let searcghstring2 = self.txtpassword.text
        request.predicate = NSPredicate (format: "name == %@", searchString!)
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let   n = (result[0] as AnyObject).value(forKey: "name") as! String
                let p = (result[0] as AnyObject).value(forKey: "password") as! String
                //  print(" checking")
                
                
                if (searchString == n && searcghstring2 == p)
                {
                    let UserDetailsVc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                    UserDetailsVc.myStringValue = txtemail.text
                    self.navigationController?.pushViewController(UserDetailsVc, animated: true)
                }
                else if (searchString == n || searcghstring2 == p)
                {
                    // print("password incorrect ")
                    let alertController1 = UIAlertController (title: "no user found ", message: "password incorrect ", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                }
            }
            else
            {
                let alertController1 = UIAlertController (title: "no user found ", message: "invalid username ", preferredStyle: UIAlertControllerStyle.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
                print("no user found")
            }
        }
        catch
        {
            print("error")
        }
    }
}
