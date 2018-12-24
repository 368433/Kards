//
//  LandincCardVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift


class LandingCardVC: UIViewController, Storyboarded{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var starredView: UIView!
    @IBOutlet weak var toCallView: UIView!
    
    weak var coordinator: PatientsCoordinator?
    var dataCoordinator = AppDelegate.dataCoordinator
    var model: [LandingCardViewModel] = [.AllPatients, .TagsList, .ArchivedWorklists, .ActiveWorklists]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
        
        setupSticker(view: starredView, backgroundLayer: Gradients.springWarmth.layer)
        setupSticker(view: toCallView, backgroundLayer: Gradients.springWarmth.layer)
        
    }
    
    private func setupSticker(view: UIView, backgroundLayer: CALayer?){
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.masksToBounds = true
//        if let bg = backgroundLayer {
//            backgroundLayer!.frame = view.bounds
//            view.layer.insertSublayer(bg, at: 0)
//        }
//        view.layer.shadowColor = UIColor.darkGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 2, height: 5)
//        view.layer.shadowRadius = 5
//        view.layer.shadowOpacity = 0.2
//        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }

}

//MARK: DATASOURCE AND DELEGATE
extension LandingCardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LandingCardTableViewCell
        let rowObject = model[indexPath.row]
        cell.configureCell(title: rowObject.title, count: rowObject.count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch model[indexPath.row] {
        case .AllPatients:
            coordinator?.showAllPatients(predicate: nil)
        case .TagsList:
            coordinator?.showTagsListsTVC()
        case .ArchivedWorklists:
            coordinator?.showArchivedWorklists()
        case .ActiveWorklists:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
