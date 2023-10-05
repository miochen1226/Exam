//
//  ArticleTableViewCell.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet var ivImage: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
