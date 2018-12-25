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
    
    weak var coordinator: PatientsCoordinator?
    var dataCoordinator = AppDelegate.dataCoordinator
    var model: [LandingCardViewModel] = [.AllPatients, .TagsList, .ArchivedWorklists, .ActiveWorklists]
    let mainBgGradient = Gradients.februaryInk.layer
    let listgb = Gradients.februaryInk.layer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Patients"
//        self.view.layer.insertSublayer(mainBgGradient, at: 0)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.tableCardView.backgroundColor = .clear
        setupSticker(view: tableCardView, backgroundLayer: nil)
        setupSticker(view: contributionCardView, backgroundLayer: nil)
//        setupSticker(view: starredView, backgroundLayer: Gradients.springWarmth.layer)
//        setupSticker(view: toCallView, backgroundLayer: Gradients.springWarmth.layer)
        
        layoutGrid()
    }
    
    override func viewDidLayoutSubviews() {
        mainBgGradient.frame = self.view.bounds
        listgb.frame = CGRect(x: 0, y: 0, width: 335, height: 220)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupSticker(view: UIView, backgroundLayer: CALayer?){
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
//        view.layer.borderWidth = 1
//        view.layer.masksToBounds = true
        if let bg = backgroundLayer {
//            bg.frame = view.layer.frame
            view.layer.insertSublayer(bg, at: 0)
        }
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 20
        view.layer.shadowOpacity = 0.2
    }
    
    private func layoutGrid(){
        contributionStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 0..<13 {
            let monthStack = UIStackView()
            monthStack.axis = .vertical
            monthStack.alignment = .top
            monthStack.spacing = 4
            contributionStack.addArrangedSubview(monthStack)
            for _ in 0..<4 {
                let weekStack = UIStackView()
                weekStack.axis = .horizontal
                weekStack.spacing = 1
                weekStack.alignment = .top
                monthStack.addArrangedSubview(weekStack)
                for _ in 0..<7 {
                    let testview = UIView()
                    testview.widthAnchor.constraint(equalToConstant: 7).isActive = true
                    testview.heightAnchor.constraint(equalToConstant: 10).isActive = true
                    testview.backgroundColor = UIColor.groupTableViewBackground
                    weekStack.addArrangedSubview(testview)
                }
            }
        }
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
            coordinator?.showAllPatients(predicate: nil, vcTitle: "All Patients")
        case .TagsList:
            coordinator?.showTagsListsTVC()
        case .ArchivedWorklists:
//            coordinator?.showArchivedWorklists()
            coordinator?.showWorklists(filter: .Archived)
        case .ActiveWorklists:
            coordinator?.showWorklists(filter: .Active)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
