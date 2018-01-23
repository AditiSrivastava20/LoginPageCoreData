//
//  StoreData.swift
//  LoginPage
//
//  Created by brst on 1/12/18.
//  Copyright © 2018 loginScreen. All rights reserved.
//

import Foundation

//class SingletonClass {
//    var sharedInstance: SingletonClass {
//        struct Static {
//            static let instance = SingletonClass()
//        }
//        return Static.instance
//    }
//    var txtemail : String = ""
    class Singleton {
        var txtemail : String = ""
        class var sharedInstance : Singleton {
            struct Static {
                static let instance : Singleton = Singleton()
            }
            return Static.instance
        }
        
        var brandName : String {
            get{
                return self.txtemail
            }
            
            set {
                self.txtemail = newValue
            }
        }
        
        //MARK: - Save Images to dictionary
        var userImageDic:[String:Data]?{
            get{
                return UserDefaults.standard.value(forKey: "Images") as? [String: Data]
            }set{
                if let value = newValue {
                    UserDefaults.standard.set(value, forKey: "Images")
                }else{
                    UserDefaults.standard.removeObject(forKey: "Images")
                }
            }
        }
    }

