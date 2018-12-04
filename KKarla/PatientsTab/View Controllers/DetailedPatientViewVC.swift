//
//  DetailedPatientViewVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-30.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class DetailedPatientViewVC: UIViewController, Storyboarded {

    weak var coordinator: PatientsCoordinator?
    var patient: Patient?
    lazy var tagStackList = ButtonTagStackList(stack: tagsStack)
    var actModel: ActListModel!
    var diagnosticEpisodeModel: DiagnosticEpisodeListModel!
    var resultsControllerDelegate: TableViewFetchResultAdapter!
    var actTabIsSelected: Bool = true

    
    // MARK: IBoutlets
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientAgeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var bedlocationLabel: UILabel!
    @IBOutlet weak var patientBlurbLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagsStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var patientIdImageButton: UIImageView!
    @IBOutlet weak var actTabButton: UIButton!
    @IBOutlet weak var clinicalListTabButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: ActTableViewCell.nibName, bundle: nil)
        let nib2 = UINib(nibName: DiagnosticEpisodeTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ActTableViewCell.reuseID)
        self.tableView.register(nib2, forCellReuseIdentifier: DiagnosticEpisodeTableViewCell.reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.rowHeight = Ac.rowHeight
        
        configurePatientDetails()
        
        // Do any additional setup after loading the view.
    }

    private func configurePatientDetails(){
        self.patientNameLabel.text = patient?.name
        self.patientAgeLabel.text = patient?.dateOfBirth?.dayMonthYear()
        self.genderLabel.text = patient?.patientGender
        self.bedlocationLabel.text = patient?.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
        self.patientBlurbLabel.text = patient?.summaryBlurb
        
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)

        // Setting up actModel
        let rightExpression = NSExpression(forConstantValue: patient)
        let leftExpression = NSExpression(forKeyPath: Act.patientTag)
        let expression = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
        actModel = ActListModel(searchPredicate: expression)
        actModel.resultController.delegate = resultsControllerDelegate
        
        // Setting up diagnostic episode model
        let rightExpression2 = NSExpression(forConstantValue: patient)
        let leftExpression2 = NSExpression(forKeyPath: DiagnosticEpisode.patientTag)
        let expression2 = NSComparisonPredicate(leftExpression: leftExpression2, rightExpression: rightExpression2, modifier: .direct, type: .equalTo, options: .caseInsensitive)
        diagnosticEpisodeModel = DiagnosticEpisodeListModel(searchPredicate: expression2)
        diagnosticEpisodeModel.resultController.delegate = resultsControllerDelegate
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupTags()
        setupTabButtons()
    }
    
    private func setupTags(){
        let tagsTitlesList = patient?.tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.bedsideLocationLabel, $0) }
        if let labelsList = labelsList {
            tagStackList.setLabels(for: labelsList)
            tagStackList.tagStack.arrangedSubviews.forEach {($0 as! UIButton).addTarget(self, action: #selector(tagButtonAction), for: .touchUpInside)}
        }
    }
    
    @objc func tagButtonAction(sender: UIButton){
        
        // get tag corresponding to the button
        if let patient = patient, let buttonTitle = sender.titleLabel?.text, let tag = patient.tags?.first(where: { ($0 as! Tag).tagTitle == buttonTitle }) as? Tag{
            
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "Edit tag title", style: .default) {_ in
                self.coordinator?.showTagForm(for: self.patient!, existingTag: tag)
            })
            
            ac.addAction(UIAlertAction(title: "Delete tag", style: .destructive) {_ in
                patient.removeFromTags(tag)
            })
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            coordinator?.showTagActions(for: ac)
        }
    }
}

extension DetailedPatientViewVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if actTabIsSelected {
            return actModel.resultController.sections?.count ?? 0
        } else {
            return diagnosticEpisodeModel.resultController.sections?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if actTabIsSelected {
            return actModel.resultController.sections![section].numberOfObjects
        } else {
            return diagnosticEpisodeModel.resultController.sections![section].numberOfObjects
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if actTabIsSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActTableViewCell.reuseID) as! ActTableViewCell
            cell.textLabel?.text = actModel?.resultController.object(at: indexPath).actNature
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagnosticEpisodeTableViewCell.reuseID) as! DiagnosticEpisodeTableViewCell
            cell.textLabel?.text = diagnosticEpisodeModel?.resultController.object(at: indexPath).primaryDiagnosis
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let patient = patient else {fatalError("patient is nil")}
        if actTabIsSelected {
            let act = actModel.resultController.object(at: indexPath)
            coordinator?.showActForm(patient: patient, existingAct: act, actToPrePopSomeFields: act, existingDiagnosticEpisode: nil)
        } else {
            let diagnosticEpisode = diagnosticEpisodeModel.resultController.object(at: indexPath)
            coordinator?.showDiagnosticEpisodeForm(for: patient, existingAct: nil, existingDiagnosticEpisode: diagnosticEpisode)
        }
    }
}

extension DetailedPatientViewVC {
    private func setupTabButtons(){
        actTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        clinicalListTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        
    }
    
    private func updateTabButtons(){
        
    }
    
    @objc private func switchTabButtons(sender: UIButton){
        if sender === actTabButton{
            actTabButton.backgroundColor = .groupTableViewBackground
            clinicalListTabButton.backgroundColor = .white
            actTabIsSelected = true
            self.tableView.reloadData()
        } else if sender === clinicalListTabButton {
            actTabButton.backgroundColor = .white
            clinicalListTabButton.backgroundColor = .groupTableViewBackground
            actTabIsSelected = false
            self.tableView.reloadData()
        }
    }
}

enum TabStatus {
    case active
    case inactive
    
    var backgroundColor: UIColor {
        switch self {
        case .active:
            return .white
        case .inactive:
            return .groupTableViewBackground
        }
    }
}
