//
//  ViewController.swift
//  LoginPage
//
//  Created by anil kumar srivastava on 7/26/17.
//  Copyright © 2017 loginScreen. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Alamofire
import SwiftyJSON


class SignupViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var weatherIcon: UIImageView!
    
    let nextField = [1:2, 2:3, 3:4]
    var activeField: UITextField?
    @IBOutlet var pickImage: UIButton!
    @IBOutlet var showImage: UIImageView!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var btnsignup: UIButton!
    @IBOutlet weak var btnlogin: UIButton!
    var message = ""
    var imagePicker = UIImagePickerController()
   
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    let locationManager = CLLocationManager()
    let locationDataModel = WeatherDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
       

        showImage.layer.masksToBounds = false
        showImage.layer.cornerRadius = showImage.frame.height/2
        showImage.clipsToBounds = true
        signupView.isHidden = false
        loginView.isHidden = true
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        
        for i in 1...4
        {
            if let textField = self.view.viewWithTag(i) as? UITextField {
                textField.delegate = self
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pickImage(_ sender: Any) {
        self.showImageSourceActionSheet()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : Any]) {
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        showImage?.image  = tempImage
        pickImage.isHidden = true
        
        dismiss(animated: true, completion: nil)
    
    }
    fileprivate func showImageSourceActionSheet() {
        
        // create alert controller having style as ActionSheet
        let alertCtrl = UIAlertController(title: "Select Image Source" , message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        // create photo gallery action
        let galleryAction = UIAlertAction(title: "Photo Gallery", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showPhotoGallery()
        }
        )
        
        // create camera action
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: {
            (alertAction) -> Void in
            self.showCamera()
        }
        )
        
        // create cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // add action to alert controller
        alertCtrl.addAction(galleryAction)
        alertCtrl.addAction(cameraAction)
        alertCtrl.addAction(cancelAction)
        
        // do this setting for ipad
        alertCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = alertCtrl.popoverPresentationController
        //popover?.UIButton = self.cameraButton
        
        
        // present action sheet
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    
    // Show photo gallery to choose image
    fileprivate func showPhotoGallery() -> Void {
        
        // debug
        print("Choose - Photo Gallery")
        
        // show picker to select image form gallery
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.mediaTypes = ["public.image" , "public.movie"]
            
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            
            // do this settings to show popover within iPad
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            let popover = imagePicker.popoverPresentationController
            //popover!.UIButton = self.cameraButton
            showImage?.isHidden = false
            
            // show image picker
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Device can not access gallery.")
        }
        
    }
    
    
    // Show camera to capture image
    fileprivate func showCamera() -> Void {
        
        // debug
        print("Choose Camera")
        
        // show camera
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            
            // create image picker
            let imagePicker = UIImagePickerController()
            
            // set image picker property
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.photo
            imagePicker.allowsEditing = false
            
            // do this settings to show popover within iPad
            imagePicker.modalPresentationStyle = UIModalPresentationStyle.popover
            let popover = imagePicker.popoverPresentationController
            //  popover!.barButtonItem = self.cameraButton
            
            // show image picker with camera.
            self.present(imagePicker, animated: true, completion: nil)
            
        }else {
            self.showAlertMessage(alertTitle: "Not Supported", alertMessage: "Camera not supported in emulator.")
        }
        
    }
    func showAlertMessage(alertTitle: String, alertMessage: String) {
        
        showImage?.isHidden = true
        
        let myAlertVC = UIAlertController( title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlertVC.addAction(okAction)
        
        self.present(myAlertVC, animated: true, completion: nil)
    }
    
    
    
    @IBAction func btnsignup(_ sender: Any) {
        
        btnsignup.backgroundColor = UIColor.white
        
        
    }
    @IBAction func getLocation(_ sender: Any) {
        
        
        
       
    }
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(response.result.error)")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            locationDataModel.temperature = Int(tempResult - 273.15)
            
            locationDataModel.city = json["name"].stringValue
            
            locationDataModel.condition = json["weather"][0]["id"].intValue
            
            locationDataModel.weatherIconName = locationDataModel.updateWeatherIcon(condition: locationDataModel.condition)
            
            
            updateUIWithWeatherData()
            
        }
        else {
            cityLabel.text = "City Unavailable"
        }
    }
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = locationDataModel.city
        weatherIcon.image = UIImage(named: locationDataModel.weatherIconName)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            // locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
   
    
    @IBAction func loginback(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 4
        {
            textField.resignFirstResponder()
            return true
        }
        else
        {
            if let nextTag = nextField[textField.tag]{
                if let nextResponder = textField.superview?.viewWithTag(nextTag){
                    nextResponder.becomeFirstResponder()
                }
            }
            
            return false
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func REGISTER(_ sender: Any) {
        if isValidInput(Input: txt1.text!)
        {
            if Contactvalidity(value: txt2.text!)
            {
                if isValidEmail(testStr: txt3.text!)
                {
                    
            if isPasswordValid(txt4.text!)
            {
                
                    let _:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
                    let context:NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserFields", into: context) as NSManagedObject
                    newUser.setValue(txt1.text, forKey: "email")
                    newUser.setValue(txt2.text, forKey: "phone")
                    newUser.setValue(txt3.text, forKey: "name")
                    newUser.setValue(txt4.text, forKey: "password")
                
                var dict = Singleton.sharedInstance.userImageDic
//                dic?[txt1.text ?? ""] = UIImageJPEGRepresentation(showImage.image!, 100)
//                Singleton.sharedInstance.userImageDic = dic
                
                if dict == nil {
                    var dict1 = [String:Data]()
                    dict1[txt1.text ?? ""] = UIImageJPEGRepresentation(showImage.image!, 100)
                    dict = dict1
                }else{
                    dict?[txt1.text ?? ""] = UIImageJPEGRepresentation(showImage.image!, 100)
                }
                
                Singleton.sharedInstance.userImageDic = dict
                
              
//                   UserDefaults.standard.register(defaults: ["key":UIImageJPEGRepresentation(showImage.image!, 100)!])
//                UserDefaults.standard.set(UIImageJPEGRepresentation(showImage.image!, 100), forKey: "key")
//                let kUserDefault = UserDefaults.standard
//
//                kUserDefault.set([(showImage.image!, 100)], forKey: "keyarray")
//                kUserDefault.synchronize()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                vc.number = txt2.text
                vc.password = txt3.text
                vc.name = txt1.text
                vc.email = txt2.text
                
                
                do {
                        try context.save()
                    } catch {}
                    print(newUser)
                    print("Object Saved.")
                    let alertController1 = UIAlertController (title: "Valid ", message: "Sucess ", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                    
                    

                    
                }else
                {
                    print("pswd check")
                    let alertController1 = UIAlertController (title: "Fill the password ", message: "Enter valid password", preferredStyle: UIAlertControllerStyle.alert)
                    alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController1, animated: true, completion: nil)
                }
            }
            else
            {
                print("mail check")
                let alertController1 = UIAlertController (title: "Fill Email id", message: "Enter valid email", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
                
            }
        }
            else
            {
                print("contact no. check")
                let alertController1 = UIAlertController (title: "Fill the Contact No.", message: "Enter valid Contact No.", preferredStyle: UIAlertControllerStyle.alert)
                alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController1, animated: true, completion: nil)
            }
        }
        else
        {
            print("name check")
            
            let alertController1 = UIAlertController (title: "Fill the Name ", message: "Enter valid username", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController1, animated: true, completion: nil)
        }
       
    }
    
    }
    func isValidInput(Input:String) -> Bool
    {
        do
              {
                   let regex = try NSRegularExpression(pattern: "^[a-zA-Z]", options: .caseInsensitive)
                   if regex.matches(in: Input, options: [], range: NSMakeRange(0, Input.characters.count)).count > 0
                   {   return true
        
                   }
              }
               catch {}
               return false
    }
    func Contactvalidity(value: String) -> Bool {
        
        
                let PHONE_REGEX = "^[0-9]{6,12}"
                let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
                let result =  phoneTest.evaluate(with: value)
                return result
        
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let RegEx = "\\A\\w{3,18}\\z"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: password)
    }
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
  
    

    

      
