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
    var model: ActListModel!
    
    // MARK: IBoutlets
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientAgeLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var bedlocationLabel: UILabel!
    @IBOutlet weak var patientBlurbLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tagsStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var patientIdImageButton: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: ActTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: ActTableViewCell.reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.rowHeight = Ac.rowHeight
        
        configurePatientDetails()
        // Do any additional setup after loading the view.
    }

    private func configurePatientDetails(){
        self.patientNameLabel.text = patient?.name
        self.patientAgeLabel.text = patient?.dateOfBirth?.dayMonthYear()
        self.diagnosisLabel.text = patient?.activeDiagnosticEpisode?.primaryDiagnosis
        self.bedlocationLabel.text = patient?.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
        self.patientBlurbLabel.text = patient?.summaryBlurb
        
        let rightExpression = NSExpression(forConstantValue: patient)
        let leftExpression = NSExpression(forKeyPath: Act.patientTag)
        let expression = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
        model = ActListModel(searchPredicate: expression)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupTags()
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
        return model.resultController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.resultController.sections![section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActTableViewCell
        cell.textLabel?.text = model?.resultController.object(at: indexPath).actNature
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let patient = patient else {fatalError("patient is nil")}
        let act = model.resultController.object(at: indexPath)
        coordinator?.showActForm(patient: patient, existingAct: act, actToPrePopSomeFields: nil, existingDiagnosticEpisode: nil)
    }
}
