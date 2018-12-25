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
    let navCont = UINavigationController()
    
    
    override init(nibName: String?, bundle: Bundle?){
        super.init(nibName: nibName, bundle: bundle)
        self.navCont.pushViewController(self, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        saveButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveEntries))

        self.navigationItem.rightBarButtonItems = [saveButton]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissForm))

        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 44
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
