//
//  PatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import CoreData

class PatientTableViewCell: UITableViewCell {
    
    // STATIC attributes
    static let cellHeight: CGFloat = 150
    
    // MARK: IBOUTLETS
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var UserImageIcon: UIImageView!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientDetailsLabel: UILabel!
    @IBOutlet weak var tagListStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var changeBedButton: UIButton!
    
    
    // MARK: other variables:
    var patient: Patient?
    var coordinator: PatientsCoordinator?
    var tagStackList: ButtonTagStackList?
    var tagListModel: TagsListModel?
    var delegate: PatientsListTVCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.layer.cornerRadius = 5.0
        self.mainBackgroundView.layer.cornerRadius = 5.0
        self.mainBackgroundView.layer.masksToBounds = true
        self.mainBackgroundView.layer.borderWidth = 0.5
        self.mainBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupTags(){
        //        let tagsTitlesList = tagListModel?.resultController.fetchedObjects?.compactMap{ $0.tagTitle}
        let tags = patient!.tags
        let tagsTitlesList = tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.bedsideLocationLabel, $0) }
        tagStackList = ButtonTagStackList(stack: tagListStack)
        if let labelsList = labelsList {
            tagStackList?.setLabels(for: labelsList)
            tagStackList?.tagStack.arrangedSubviews.forEach { butn in
                let button = butn as! UIButton
                button.addTarget(self, action: #selector(tagButtonAction2), for: .touchUpInside)
            }
        }
    }
    
    func configure(){
        if let patient = patient {
            //            tagListModel?.resultController.delegate = self
            setupButtons()
            setupTags()
            self.patientNameLabel.text = patient.name
        }
    }
    
    func setupButtons(){
        addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
        addTagButton.addTarget(self, action: #selector(showTagForm), for: .touchUpInside)
    }
    
    @objc func showActForm(){
        if let pt = patient {coordinator?.showAddActForm(patient: pt)}
    }
    @objc func showTagForm(){
        if let pt = patient {coordinator?.showTagForm(for: pt, existingTag: nil)}
    }
    @objc func showTagForm2(){
        //            delegate?.editTagLabel(patient: patient!, labelTitle: labelTitle)
        let predicate = NSPredicate(format: "tagTitle == %@", "Aaa")
        let tag = patient!.tags?.filtered(using: predicate)
        let chosen = tag?.first as! Tag
        coordinator?.showTagForm(for: patient!, existingTag: chosen)
    }
    
    @objc func tagButtonAction2(sender: UIButton){
        if let labelTitle = sender.titleLabel?.text {
            //            delegate?.editTagLabel(patient: patient!, labelTitle: labelTitle)
            let predicate = NSPredicate(format: "tagTitle == %@", labelTitle)
            let tag = patient!.tags?.filtered(using: predicate)
            let chosen = tag?.first as! Tag
            coordinator?.showTagForm(for: patient!, existingTag: chosen)
        }
    }
    
}

extension PatientTableViewCell{
    
    // idea to fix this: make basepatientlisttvc the delegate of cell
    // make delegate handle the tag editing and deleting, pass to it the tag label
    // and let delegate figure out the rest
    @objc func tagButtonAction(sender: UIButton){
        print("GESTS CALLED")
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Edit tag title", style: .default) {_ in
            let tag = self.tagListModel?.resultController.fetchedObjects?.first(where: {$0.tagTitle == sender.titleLabel?.text})
            self.coordinator?.showTagForm(for: self.patient!, existingTag: tag)
        })
        ac.addAction(UIAlertAction(title: "Delete tag", style: .destructive) {_ in})
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        coordinator?.showTagActions(for: ac)
    }
}

//extension PatientTableViewCell: NSFetchedResultsControllerDelegate{
//    
//}
