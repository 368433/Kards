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
        self.navCont.navigationBar.barTintColor = .white
    }
    
//    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController = UINavigationController()
        self.tableView.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        saveButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveEntries))
//        let crossCancelButton = UIBarButtonItem(image: UIImage(named: "icons8-multiply"), style: .plain, target: self, action: #selector(dismissForm))
        let crossCancel = UIButton(type: .custom)
        crossCancel.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        crossCancel.setImage(UIImage(named: "icons8-multiply"), for: .normal)
        crossCancel.addTarget(self, action: #selector(dismissForm), for: .touchUpInside)
        
        let leftMenuBarItem = UIBarButtonItem(customView: crossCancel)
        let currWidth = leftMenuBarItem.customView?.widthAnchor.constraint(equalToConstant: 36)
        currWidth?.isActive = true
        let currHeight = leftMenuBarItem.customView?.heightAnchor.constraint(equalToConstant: 36)
        currHeight?.isActive = true
        
//        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissForm))
        self.navigationItem.rightBarButtonItems = [saveButton]
        self.navigationItem.leftBarButtonItem = leftMenuBarItem
//        self.navigationItem.leftBarButtonItems = [crossCancelButton]
        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 44
//        setupHeaderView()
    }
    
//    private func setupHeaderView(){
//        let buttonSize: CGFloat = 33
//        let topView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
//        let closeButton = UIButton(frame: CGRect(x: 10, y: 90, width: buttonSize, height: buttonSize))
//        let saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
//        closeButton.imageView?.image = UIImage(named: "icons8-multiply")
//        closeButton.titleLabel?.text = "THIS"
////        let topStack = UIStackView(arrangedSubviews: [closeButton, saveButton])
////        topStack.axis = .horizontal
////        topStack.distribution = .equalCentering
//        topView.backgroundColor = .red
//        topView.addSubview(closeButton)
//        self.view.addSubview(topView)
//    }
    
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
