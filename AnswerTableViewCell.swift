//
//  AnswerTableViewCell.swift
//  Meta Say
//
//  Created by Alex Agarkov on 09.02.2022.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: DesignableView!
    @IBOutlet weak var ansewerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func Selected(_ selected: Bool) {
        if selected {
            self.bgView.backgroundColor = #colorLiteral(red: 0.1188578084, green: 0.7362630367, blue: 1, alpha: 1)
            self.ansewerLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        else
        {
            self.bgView.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9647058824, blue: 0.9803921569, alpha: 1)
            self.ansewerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
