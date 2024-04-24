//
//  MyTvCell.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 25/04/24.
//

import UIKit

protocol MyTableViewCellDelegate: AnyObject {
    func didTapLikeButton(cell: MyTvCell)
}

class MyTvCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var myImgView: UIImageView!
    
    @IBOutlet weak var heading1: UILabel!
    @IBOutlet weak var heading2: UILabel!
    @IBOutlet weak var heading3: UILabel!
    @IBOutlet weak var likeImgView: UIImageView!
    
    weak var delegate: MyTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.borderWidth = 0.5
        self.mainView.layer.borderColor = CGColor(red: 83.0/255.0, green: 83.0/255.0, blue: 83.0/255.0, alpha: 0.5)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func likeBtnTapped(_ sender: Any) {
        print("like btn tapped")
        delegate?.didTapLikeButton(cell: self)
    }
    
}
