//
//  NewPatientForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//


import UIKit
import CoreData
import Eureka
import EmptyDataSet_Swift

class PatientForm2: KarlaForm {

    @IBOutlet weak var actBottomLine: UIView!
    @IBOutlet weak var actRightView: UIView!
    @IBOutlet weak var ClinEpBottom: UIView!
    @IBOutlet weak var clinicalListTabButton: UIButton!
    @IBOutlet weak var actTabButton: UIButton!
    @IBOutlet weak var infoTabButton: UIButton!
    @IBOutlet weak var addToActOrClinicalEpTableButton: UIButton!
    
    var actModel: ActListModel!
    var diagnosticEpisodeModel: DiagnosticEpisodeListModel!
    var resultsControllerDelegateAct: TableViewFetchResultAdapter!
    var tabSelected: TabSelection = .info

    var existingPatient: Patient?
    var listToLink: ClinicalList?
    var quickParser: QuickParser!
    var delegate: PatientFormDelegate?

    
    var nameEntry: String? {
        didSet{
            guard let nameRow = form.rowBy(tag: Patient.nameTag) as? TextRow else {return}
            nameRow.value = nameEntry
            nameRow.reload()
        }
    }
    var dateValue: Date? {
        didSet{
            guard let dateOfBirthRow = form.rowBy(tag: Patient.birthdateTag) as? DateRow else {return}
            dateOfBirthRow.value = dateValue
            dateOfBirthRow.reload()
        }
    }
    var genderValue: String? {
        didSet{
            guard let genderRow = form.rowBy(tag: Patient.genderTag) as? SegmentedRow<String> else {return}
            genderRow.value = genderValue
            genderRow.reload()
            
        }
    }
    
    init(existingPatient: Patient?){
        self.existingPatient = existingPatient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Patient form"
        initializeForm()
        quickParser = QuickParser(form: self.form)
        setupTabTables()
        setupEmptyDataScreensModule()
    }
    
    @objc override func saveEntries(){
        objectToSave = existingPatient ?? getNewPatientInstance()
        if let list = listToLink, let patientToSave = objectToSave as? Patient { patientToSave.addToActiveWorkLists(list) }
        super.saveEntries()
        delegate?.update(patient: objectToSave as! Patient)
    }
    
    func getNewPatientInstance() -> Patient {
        let newPatient = Patient(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newPatient)
        return newPatient
    }
}


//**
// MARK: SETUP TAB TABLEVIEW

extension PatientForm2{
    private func setupTabTables(){
        let nib = UINib(nibName: ActTableViewCell.nibName, bundle: nil)
        let nib2 = UINib(nibName: DiagnosticEpisodeTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ActTableViewCell.reuseID)
        self.tableView.register(nib2, forCellReuseIdentifier: DiagnosticEpisodeTableViewCell.reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        initializeActAndEpisodeModels()
        setupTabButtons()
        
    }
    
    private func initializeActAndEpisodeModels(){
        resultsControllerDelegateAct = TableViewFetchResultAdapter(tableView: self.tableView)
        print("huhuhuh")
        // Setting up actModel
        let rightExpression = NSExpression(forConstantValue: existingPatient)
        let leftExpression = NSExpression(forKeyPath: Act.patientTag)
        let expression = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
        actModel = ActListModel(searchPredicate: expression)
        actModel.resultController.delegate = resultsControllerDelegateAct
        
        // Setting up diagnostic episode model
        let rightExpression2 = NSExpression(forConstantValue: existingPatient)
        let leftExpression2 = NSExpression(forKeyPath: DiagnosticEpisode.patientTag)
        let expression2 = NSComparisonPredicate(leftExpression: leftExpression2, rightExpression: rightExpression2, modifier: .direct, type: .equalTo, options: .caseInsensitive)
        diagnosticEpisodeModel = DiagnosticEpisodeListModel(searchPredicate: expression2)
        diagnosticEpisodeModel.resultController.delegate = resultsControllerDelegateAct
    }
    
    private func setupTabButtons(){
        infoTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        actTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        clinicalListTabButton.addTarget(self, action: #selector(switchTabButtons), for: .touchUpInside)
        addToActOrClinicalEpTableButton.addTarget(self, action: #selector(addActOrClinEp), for: .touchUpInside)
    }
    
    @objc private func addActOrClinEp(sender: UIButton){
        guard let patient = existingPatient else { fatalError("no valid patient")}
        switch tabSelected{
        case .info:
            return
        case .act:
            coordinator?.showActForm(patient: patient, existingAct: nil, actToPrePopSomeFields: nil, existingDiagnosticEpisode: nil)
        case .episode:
            coordinator?.showDiagnosticEpisodeForm(for: patient, existingAct: nil, existingDiagnosticEpisode: nil)
        }
    }
    
    @objc private func switchTabButtons(sender: UIButton){
        if sender === actTabButton{
            actBottomLine.backgroundColor = .white
            ClinEpBottom.backgroundColor = .lightGray
            tabSelected = .act
        } else if sender === clinicalListTabButton {
            actBottomLine.backgroundColor = .lightGray
            ClinEpBottom.backgroundColor = .white
            tabSelected = .episode
        } else if sender === infoTabButton{
            tabSelected = .info
        }
        self.tableView.reloadData()
    }
    
    //***
    // MARK: TABS TABLEVIEW DATASOURCE
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        switch tabSelected {
        case .info:
            return super.numberOfSections(in: tableView)
        case .act:
            return actModel?.resultController.sections?.count ?? 0
        case .episode:
            return diagnosticEpisodeModel?.resultController.sections?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabSelected{
        case .info:
            return super.tableView(tableView, numberOfRowsInSection: section)
        case .act:
            return actModel?.resultController.sections![section].numberOfObjects ?? 0
        case .episode:
            return diagnosticEpisodeModel?.resultController.sections![section].numberOfObjects ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabSelected{
        case .info:
            return super.tableView(tableView, estimatedHeightForRowAt: indexPath)
        case .act, .episode:
            return CGFloat(integerLiteral: 44)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tabSelected{
        case .info:
            return super.tableView(tableView, heightForRowAt: indexPath)
        case .act, .episode:
            return CGFloat(integerLiteral: 44)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch tabSelected{
        case .info:
            return super.tableView(tableView, canEditRowAt: indexPath)
        case .act, .episode:
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabSelected{
        case .info:
            return super.tableView(tableView, cellForRowAt: indexPath)
        case .act:
            let cell = tableView.dequeueReusableCell(withIdentifier: ActTableViewCell.reuseID) as! ActTableViewCell
            cell.model = actModel.resultController.object(at: indexPath)
            cell.configure()
            return cell
        case .episode:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagnosticEpisodeTableViewCell.reuseID) as! DiagnosticEpisodeTableViewCell
            cell.model = diagnosticEpisodeModel.resultController.object(at: indexPath)
            cell.configure()
            return cell
        }
    }
    
    //**
    // MARK: TAB TABLEVIEW DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let patient = existingPatient else {fatalError("patient is nil")}
        
        switch tabSelected {
        case .info:
            super.tableView(tableView, didSelectRowAt: indexPath)
        case .act:
            let act = actModel.resultController.object(at: indexPath)
            coordinator?.showActForm2(nc: self.navigationController, patient: patient, existingAct: act, actToPrePopSomeFields: act, existingDiagnosticEpisode: nil)
        case .episode:
            let diagnosticEpisode = diagnosticEpisodeModel.resultController.object(at: indexPath)
            coordinator?.showDiagnosticEpisodeForm2(nc: self.navigationController,for: patient, existingAct: nil, existingDiagnosticEpisode: diagnosticEpisode)
        }
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        switch tabSelected{
        case .info:
            return nil
        case .act, .episode:
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                switch self.tabSelected {
                case .act:
                    let object = self.actModel.resultController.object(at: indexPath)
                    self.actModel.dataCoordinator.persistentContainer.viewContext.delete(object)
                    self.actModel.dataCoordinator.saveContext()
                    self.actModel.loadObjectList()
                case .episode:
                    let object = self.diagnosticEpisodeModel.resultController.object(at: indexPath)
                    self.diagnosticEpisodeModel.dataCoordinator.persistentContainer.viewContext.delete(object)
                    self.diagnosticEpisodeModel.dataCoordinator.saveContext()
                    self.diagnosticEpisodeModel.loadObjectList()
                case .info:
                    return
                }
            }
            return [delete]
        }
    }
    
}

//**
// MARK: EURKA FORM FIELDS

extension PatientForm2{
    private func initializeForm(){
        form +++ Section()
            
            <<< TextRow(){ row in
                row.placeholder = "FIRST LAST YYMM DDXX Y0Y0Y0"
                }.onChange { row in
                    if row.value == "" || row.value == nil {
                        return
                    }
                    self.quickParser.parse(textToParse: row.value!)
                    self.nameEntry = self.quickParser.nameValue
                    self.dateValue = self.quickParser.parsedDateOfBirthValue
                    self.genderValue = self.quickParser.gender
            }
            
            +++ Section("Direct form entry")
            <<< ImageRow(){ row in
                row.title = "Photo ID"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Nom, prenom, ou nickname"
                row.tag = Patient.nameTag
                row.value = existingPatient?.name
                }.onChange{ [unowned self] row in
                    if row.value == nil { self.navigationItem.rightBarButtonItems?[0].isEnabled = false }
                    else { self.navigationItem.rightBarButtonItems?[0].isEnabled = true }
            }
            <<< SegmentedRow<String>() { row in
                row.options = ["M", "F"]
                row.title = "Gender"
                row.tag = Patient.genderTag
                row.value = existingPatient?.patientGender
                }.cellUpdate { (cell, row) in
                    cell.setControlWidth(width: 80)
            }
            <<< DateRow(){ row in
                row.title = "Date of Birth"
                row.tag = Patient.birthdateTag
                row.value = existingPatient?.dateOfBirth
            }
            <<< TextRow(){ row in
                row.title = "NAM"
                row.placeholder = "Numero d'assurance maladie"
                row.tag = Patient.sinTag
                row.value = existingPatient?.sin
            }
            <<< TextRow(){ row in
                row.title = "Postal Code"
                row.placeholder = "code postal"
                row.tag = Patient.postalCodeTag
                row.value = existingPatient?.postalCode
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter patient note. Using dictation speeds up entry"
                row.tag = Patient.blurbTag
                row.value = existingPatient?.summaryBlurb
        }
    }
}

//**
// MARK : EMPTY DATA SCREEN EXTENSION

extension PatientForm2: EmptyDataSetSource, EmptyDataSetDelegate {
    
    private func setupEmptyDataScreensModule(){
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
    }

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

enum TabSelection{
    case info
    case act
    case episode
}
