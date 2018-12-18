//
//  DetailedPatientViewVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-30.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import EmptyDataSet_Swift

class DetailedPatientViewVC: UIViewController, Storyboarded {
    
    weak var coordinator: PatientsCoordinator?
    var patient: Patient?
//    lazy var tagStackList = ButtonTagStackList(stack: tagsStack)
    var actModel: ActListModel!
    var diagnosticEpisodeModel: DiagnosticEpisodeListModel!
    var resultsControllerDelegateAct: TableViewFetchResultAdapter!
    var actTabIsSelected: Bool = true
    
    
    // MARK: IBoutlets
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientAgeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var bedlocationLabel: UILabel!
    @IBOutlet weak var patientBlurbLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clinEpTableView: UITableView!
    @IBOutlet weak var actTableView: UITableView!
    @IBOutlet weak var tagsStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var patientIdImageButton: UIImageView!
    
    
    @IBOutlet weak var patientEditButton: UIButton!
    
    
    @IBOutlet weak var actBottomLine: UIView!
    @IBOutlet weak var actRightView: UIView!
    @IBOutlet weak var ClinEpBottom: UIView!
    @IBOutlet weak var clinicalListTabButton: UIButton!
    @IBOutlet weak var actTabButton: UIButton!
    @IBOutlet weak var addToActOrClinicalEpTableButton: UIButton!
    
    @IBOutlet weak var idView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = patient?.name
        let nib = UINib(nibName: ActTableViewCell.nibName, bundle: nil)
        let nib2 = UINib(nibName: DiagnosticEpisodeTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ActTableViewCell.reuseID)
        self.tableView.register(nib2, forCellReuseIdentifier: DiagnosticEpisodeTableViewCell.reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
//        self.idView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "qbkls"))
        configurePatientDetails()
    }
    
    private func configurePatientDetails(){
//        updateLabels()
        
        resultsControllerDelegateAct = TableViewFetchResultAdapter(tableView: self.tableView)
        
        // Setting up actModel
        let rightExpression = NSExpression(forConstantValue: patient)
        let leftExpression = NSExpression(forKeyPath: Act.patientTag)
        let expression = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
        actModel = ActListModel(searchPredicate: expression)
        actModel.resultController.delegate = resultsControllerDelegateAct
        
        // Setting up diagnostic episode model
        let rightExpression2 = NSExpression(forConstantValue: patient)
        let leftExpression2 = NSExpression(forKeyPath: DiagnosticEpisode.patientTag)
        let expression2 = NSComparisonPredicate(leftExpression: leftExpression2, rightExpression: rightExpression2, modifier: .direct, type: .equalTo, options: .caseInsensitive)
        diagnosticEpisodeModel = DiagnosticEpisodeListModel(searchPredicate: expression2)
        diagnosticEpisodeModel.resultController.delegate = resultsControllerDelegateAct
        
        // Setting up action buttons
//        self.patientEditButton.addTarget(self, action: #selector(editPatient), for: .touchUpInside)
        self.tableView.delegate = self
        self.tableView.dataSource = self
//        setupTags()
        setupTabButtons()
    }
    
//    private func setupTags(){
//        let tagsTitlesList = patient?.tags?.compactMap { ($0 as! Tag).tagTitle }
//        let labelsList = tagsTitlesList?.compactMap { (LabelType.bedsideLocationLabel, $0) }
//        if let labelsList = labelsList {
//            tagStackList.setLabels(for: labelsList)
//            tagStackList.tagStack.arrangedSubviews.forEach {($0 as! UIButton).addTarget(self, action: #selector(tagButtonAction), for: .touchUpInside)}
//        }
//    }
    
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
            coordinator?.showAlertController(for: ac)
        }
    }
    
    @objc func editPatient(){
        if let pt = patient {
            coordinator?.showPatientForm(existingPatient: pt, delegate: self)
        }
    }
    
//    private func updateLabels(){
//        self.patientNameLabel.text = patient?.name
//        self.patientAgeLabel.text = patient?.age
//        self.genderLabel.text = patient?.patientGender
//        self.bedlocationLabel.text = patient?.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
//        self.patientBlurbLabel.text = patient?.summaryBlurb ?? "No summary in database."
//    }
}

extension DetailedPatientViewVC: PatientFormDelegate {
    func update(patient: Patient){
//        updateLabels()
    }
}


//***
// MARK: UITableView DataSource methods

extension DetailedPatientViewVC: UITableViewDataSource {
    
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
            cell.model = actModel.resultController.object(at: indexPath)
            cell.configure()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagnosticEpisodeTableViewCell.reuseID) as! DiagnosticEpisodeTableViewCell
            cell.model = diagnosticEpisodeModel.resultController.object(at: indexPath)
            cell.configure()
            return cell
        }
    }
}

//***
// MARK: UITableView Delegate methods

extension DetailedPatientViewVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let patient = patient else {fatalError("patient is nil")}
        if actTabIsSelected {
            let act = actModel.resultController.object(at: indexPath)
            coordinator?.showActForm(patient: patient, existingAct: act, actToPrePopSomeFields: act, existingDiagnosticEpisode: nil)
        } else {
            let diagnosticEpisode = diagnosticEpisodeModel.resultController.object(at: indexPath)
            coordinator?.showDiagnosticEpisodeForm(for: patient, existingAct: nil, existingDiagnosticEpisode: diagnosticEpisode)
        }
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if self.actTabIsSelected{
                let object = self.actModel.resultController.object(at: indexPath)
                self.actModel.dataCoordinator.persistentContainer.viewContext.delete(object)
                self.actModel.dataCoordinator.saveContext()
                self.actModel.loadObjectList()
            }else {
                let object = self.diagnosticEpisodeModel.resultController.object(at: indexPath)
                self.diagnosticEpisodeModel.dataCoordinator.persistentContainer.viewContext.delete(object)
                self.diagnosticEpisodeModel.dataCoordinator.saveContext()
                self.diagnosticEpisodeModel.loadObjectList()
            }
        }
        return [delete]
    }
}

extension DetailedPatientViewVC {
    
    private func setupTabButtons(){
        actTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        clinicalListTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        addToActOrClinicalEpTableButton.addTarget(self, action: #selector(addActOrClinEp), for: .touchUpInside)
    }
    
    private func updateTabButtons(){
        
    }
    
    @objc private func addActOrClinEp(sender: UIButton){
        guard let patient = patient else { fatalError("no valid patient")}
        if actTabIsSelected {
            coordinator?.showActForm(patient: patient, existingAct: nil, actToPrePopSomeFields: nil, existingDiagnosticEpisode: nil)
        } else {
            coordinator?.showDiagnosticEpisodeForm(for: patient, existingAct: nil, existingDiagnosticEpisode: nil)
        }
    }
    
    @objc private func switchTabButtons(sender: UIButton){
        if sender === actTabButton{
            actBottomLine.backgroundColor = .white
            ClinEpBottom.backgroundColor = .lightGray
            actTabIsSelected = true
        } else if sender === clinicalListTabButton {
            actBottomLine.backgroundColor = .lightGray
            ClinEpBottom.backgroundColor = .white
            actTabIsSelected = false
        }
        self.tableView.reloadData()
    }
}

extension DetailedPatientViewVC: EmptyDataSetSource, EmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let myString = "No Data"
        //        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
        let myAttrString = NSAttributedString(string: myString, attributes: nil)
        return myAttrString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "icons8-ambulance")
    }
}
