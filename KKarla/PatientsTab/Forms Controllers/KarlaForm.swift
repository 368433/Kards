//
//  KarlaForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import CoreData

class KarlaForm: FormViewController, Storyboarded, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    var coordinator: PatientsCoordinator?

//    let dataHandler = DataHandler()
//    let imageService = ImageService()
    var saveButton: UIBarButtonItem!
    var dataCoordinator = AppDelegate.dataCoordinator
    let populator = Populator()
    var objectToSave: NSManagedObject?
    
    
    override init(nibName: String?, bundle: Bundle?){
        super.init(nibName: nibName, bundle: bundle)
    }
    
//    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView?.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEntries))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissForm))
        self.navigationItem.rightBarButtonItems = [saveButton]
        self.navigationItem.leftBarButtonItems = [cancelButton]
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func saveEntries(){
        guard let objectToSave = objectToSave else { fatalError("object to save is nil")}
        populator.populate(objectsList: [objectToSave], with: self.form.values())
        dataCoordinator.saveContext()
        dismissForm()
    }
    
    @objc func dismissForm(){
        dismiss(animated: true)
    }
    
    private func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
}
