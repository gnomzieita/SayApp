//
//  detailTableViewCell.swift
//  Meta Say
//
//  Created by Alex Agarkov on 28.02.2022.
//

import UIKit

class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var answeL: UILabel!
    @IBOutlet weak var numL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ data:[String:Any]) {
        self.titleL.text = data["question"] as? String ?? ""
        self.answeL.text = data["answer"] as? String ?? ""
        self.numL.text = "\(data["questionID"] as! Int)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
