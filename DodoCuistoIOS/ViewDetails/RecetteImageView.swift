//
//  RecetteImageView.swift
//  DodoCuistoIOS
//
//  Created by MacBook Pro on 27/04/2021.
//

import UIKit

class RecetteImageView: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var previewImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
