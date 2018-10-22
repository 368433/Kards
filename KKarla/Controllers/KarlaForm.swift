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

class KarlaForm: FormViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
//    let populator = Populator()
//    let dataHandler = DataHandler()
//    let imageService = ImageService()
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEntries))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissForm))
        self.navigationItem.rightBarButtonItems = [saveButton]
        self.navigationItem.leftBarButtonItems = [cancelButton]
    }
    
    @objc func saveEntries(){
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