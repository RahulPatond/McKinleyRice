//
//  ContactListCellTableViewCell.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit

struct ContactListCellTableViewCellConstant {
    static let ContactListCellColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    static let ContactListAlternatCellColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    
    static let ContactListSelectedCellColor = UIColor(red: 191/255.0, green: 161/255.0, blue: 226/255.0, alpha: 1.0)
    static let AvtarColorLayer = CGColor(red: 191/255.0, green: 161/255.0, blue: 226/255.0, alpha: 1.0)
    static let OnlineStatusColor = UIColor(red: 115/255.0, green: 206/255.0, blue: 112/255.0, alpha: 1.0)
    static let OflineStatusColor = UIColor(red: 236/255.0, green: 92/255.0, blue: 104/255.0, alpha: 1.0)
}

class ContactListCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avtarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var onlineStatusView: UIView!
    
    let colorLayer = CALayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    static func identifier() -> String {
         return "ContactListCellTableViewCell"
     }
     
     static func nib() -> UINib {
         let nib = UINib(nibName: "ContactListCellTableViewCell", bundle: nil)
         return nib
     }
    
    private func setupUI() {
        colorLayer.frame = avtarImageView.bounds
        colorLayer.backgroundColor = ContactListCellTableViewCellConstant.AvtarColorLayer // Set your desired color
        colorLayer.opacity = 0.5 // Adjust the opacity as needed
        avtarImageView.layer.addSublayer(colorLayer)
        
        onlineStatusView.layer.cornerRadius = 6
    }
    func configure(user: User) {
        nameLabel.text = "\(user.first_name ?? "") " + "\(user.last_name ?? "")"
        companyNameLabel.text = "McKinley Rice"
        
        Task {
            if let imageStr = user.avatar {
                if let image = await APIManager.shared.retrieveImageFromCache(imagePath: imageStr) {
                    DispatchQueue.main.async {
                        self.avtarImageView?.image = image
                    }
                } else {
                    let image = await APIManager.shared.loadImage(from: imageStr)
                    DispatchQueue.main.async {
                        self.avtarImageView?.image = image
                    }
                }
            } else {
                avtarImageView?.image = UIImage(named: AppConstant.noImage)
            }
        }
    }
    
    func configureColor(isSelected: Bool, indexPath: IndexPath) {
        
        if isSelected {
            self.backgroundColor = ContactListCellTableViewCellConstant.ContactListSelectedCellColor
            colorLayer.backgroundColor = .none
        } else {
            
            self.backgroundColor = (indexPath.row % 2 == 0) ? ContactListCellTableViewCellConstant.ContactListCellColor : ContactListCellTableViewCellConstant.ContactListAlternatCellColor
            colorLayer.backgroundColor = ContactListCellTableViewCellConstant.AvtarColorLayer
        }
    }
}
