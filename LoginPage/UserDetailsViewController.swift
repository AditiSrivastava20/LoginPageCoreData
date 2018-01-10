//
//  UserDetailsViewController.swift
//  LoginPage
//
//  Created by anil kumar srivastava on 1/9/18.
//  Copyright © 2018 loginScreen. All rights reserved.
//

import UIKit
import CoreData

class UserDetailsViewController: UIViewController {

    @IBOutlet var profilepicOfUser: UIImageView!
    @IBOutlet var contactUser: UILabel!
    @IBOutlet weak var passwordOfuser: UILabel!
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var emailofUser: UILabel!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var myStringValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilepicOfUser.layer.masksToBounds = false
        profilepicOfUser.layer.cornerRadius = profilepicOfUser.frame.height/2
        profilepicOfUser.clipsToBounds = true
        
        
        // Do any additional setup after loading the view.
    }

   
    override func viewWillAppear(_ animated: Bool) {
        showData()
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    func showData()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserFields")
        request.predicate = NSPredicate (format: "name == %@", myStringValue!)
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                let nameData = (result[0] as AnyObject).value(forKey: "name") as! String
                let agedata = (result[0] as AnyObject).value(forKey: "password") as! String
                let emaildata = (result[0] as AnyObject).value(forKey: "email") as! String
                let contactdata = (result[0] as AnyObject).value (forKey: "phone") as! String
                let imageData = UserDefaults.standard.value(forKey: "key") as! Data
                let imageFromData = UIImage(data: imageData)!
                profilepicOfUser.image = imageFromData
//                let picdata = (result[0] as AnyObject).value (forKey: "profilepic") as! UIImage
             //let picdata = UIImagePNGRepresentation(profilepicOfUser.image!) as UIImage?
//                profilepicOfUser.image = UIImage(data: picdata! as Data)
                nameOfUser.text = nameData
                passwordOfuser.text = agedata
                emailofUser.text = emaildata
                contactUser.text = contactdata
//                profilepicOfUser.image = picdata
            }
        }
        catch {
            //handle error
            print(error)
        }
    }
}

    

  
