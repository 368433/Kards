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
    @IBOutlet weak var contributionStack: UIStackView!
    @IBOutlet weak var tableCardView: UIView!
    @IBOutlet weak var contributionCardView: UIView!
    
    //DataViews
    @IBOutlet weak var leftDataView: UIView!
    @IBOutlet weak var rightDataView: UIView!
    
    weak var coordinator: PatientsCoordinator?
    var dataCoordinator = AppDelegate.dataCoordinator
    var model: [LandingCardViewModel] = [.AllPatients, .TagsList, .ArchivedWorklists, .ActiveWorklists]
    let mainBgGradient = Gradients.februaryInk.layer
    let listgb = Gradients.februaryInk.layer
    var topCircle: CAShapeLayer?
    let stickerMaker = StickerMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear

//        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = .white
        self.tableCardView.backgroundColor = .clear
        stickerMaker.setupSticker(view: tableCardView, backgroundLayer: nil, cornerRadius: 0, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.black.cgColor, shadowOffset: CGSize(width: 0, height: 10), shadowRadius: 20, shadowOpacity: 0.2)
        stickerMaker.setupSticker(view: contributionCardView, backgroundLayer: nil, cornerRadius: 5, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.black.cgColor, shadowOffset: CGSize(width: 0, height: 10), shadowRadius: 20, shadowOpacity: 0.2)
        
        let contributionDrawer = ContributionGraph()
        contributionDrawer.layoutGrid(contributionStack: contributionStack)
        
        let circularDrawer = CircularGraph()
        leftDataView.backgroundColor = .clear
        
        topCircle = circularDrawer.drawCercle(inside: leftDataView, radius: 30, lineWidth: 5, strokeEnd: 0, strokeColor: UIColor.yellow.cgColor)
        let trackCircle = circularDrawer.drawCercle(inside: leftDataView,  radius: 30, lineWidth: 5, strokeEnd: 1, strokeColor: UIColor.lightGray.cgColor)
        leftDataView.layer.addSublayer(trackCircle)
        leftDataView.layer.addSublayer(topCircle!)
        leftDataView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }

    @objc private func moreOptions(){
    }

    @objc private func handleTap(){
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        topCircle!.add(basicAnimation, forKey: "urSoBasic")
    }
    
    override func viewDidLayoutSubviews() {
        mainBgGradient.frame = self.view.bounds
        listgb.frame = CGRect(x: 0, y: 0, width: 335, height: 220)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
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
//        cell.configureCell(title: rowObject.title, count: rowObject.count)
        cell.configureCell(model: rowObject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch model[indexPath.row] {
        case .AllPatients:
            coordinator?.showAllPatients(predicate: nil, vcTitle: "All Patients")
        case .TagsList:
            coordinator?.showTagsListsTVC()
        case .ArchivedWorklists:
            coordinator?.showWorklists(filter: .Archived)
        case .ActiveWorklists:
            coordinator?.showWorklists(filter: .Active)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
