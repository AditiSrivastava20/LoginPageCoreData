//
//  TableViewController.swift
//  LoginPage
//
//  Created by brst on 1/12/18.
//  Copyright © 2018 loginScreen. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController {
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tblView: UITableView!
    private let persistentContainer = NSPersistentContainer(name: "LoginPage")
    var userDefaults: SignupViewController?
    // MARK: -
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<UserFields> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<UserFields> = UserFields.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupMessageLabel()
        
        updateView()
    }
    
    private func updateView() {
        var hasQuotes = false
        
        if let quotes = fetchedResultsController.fetchedObjects {
            hasQuotes = quotes.count > 0
        }
        
        tblView.isHidden = !hasQuotes
        messageLabel.isHidden = hasQuotes
        
     
    }
    
    // MARK: -
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any quotes yet."
    }
    
    
    @IBAction func btnLogOutAction(_ sender: Any) {
        
       self.logOut()
      
    }
    
     //MARK: - LogOut
    func logOut() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController  = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        
    }
    
}

extension TableViewController: NSFetchedResultsControllerDelegate {
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
            fatalError("Unexpected Index Path")
        }
        
        // Fetch Quote
        let quote = fetchedResultsController.object(at: indexPath)
        
        // Configure Cell
        cell.retrieveEmail.text = quote.name
        cell.namelbl.text = quote.email
        cell.passwordlbl.text = quote.password
        cell.phonelbl.text = quote.phone
        
       
//          let kUserDefault = UserDefaults.standard
//        kUserDefault.array(forKey: "keyarray")!
        let image = UIImage(data: (Singleton.sharedInstance.userImageDic?[quote.email ?? ""]!)!)!
        
//      let imageData = UserDefaults.standard.value(forKey: "key") as! Data
//      let imageFromData = UIImage(data: imageData)!
       cell.imagesStored.image = image
        
        
        return cell
    }
    
}

