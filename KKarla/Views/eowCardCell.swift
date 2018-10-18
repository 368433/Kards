//
//  eowCardCell.swift
//  KKarla
//
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class eowCardCell: UITableViewCell {

    var patientEOW: PatientEOW!
    
    @IBOutlet weak var actListTable: UITableView!
    @IBOutlet weak var patientIDImage: UIImageView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var admissionDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        actListTable.delegate = self
//        actListTable.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(){
        patientIDImage.image = UIImage(named: patientEOW.photoIDName)
        
    }
    
}

extension eowCardCell: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patientEOW?.actsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actLineCell", for: indexPath)
        return cell
    }

}

