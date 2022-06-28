//
//  TableViewCell.swift
//  OmdbApp
//
//  Created by Cem Sertkaya on 28.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var insider: UITextView!
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ vm : MovieViewModel)
    {
        name.text = vm.name
        category.text = vm.category
        insider.text = vm.insider
        photo.image = vm.image
    }

}
