//
//  BeerBoxCell.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit
import SDWebImage

class BeerBoxCell: UITableViewCell {
    
    // MARK:- Outlets
    // Offer View
    @IBOutlet weak var beerImg: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerSubtitle: UILabel!
    @IBOutlet weak var beerCaption: UILabel!
    @IBOutlet weak var beerMoreInfo: UILabel!
    
    
    func setUpCell(_ beer: BeerBoxElement){
        
        // Set backgroundColor
        contentView.backgroundColor = .clear
        
        // Set beer Image
        beerImg.contentMode = .scaleAspectFill
        if let url = URL(string: beer.imageUrl ?? "" ){
            beerImg.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
        }
        
        // Set beer Title
        beerTitle.text = beer.name
        beerTitle.textColor = Config.white
        beerTitle.font = medium(Config.body)
        beerTitle.numberOfLines = 1
        
        // Set beer Subtitle
        beerSubtitle.text = beer.tagline
        beerSubtitle.textColor = Config.gray
        beerSubtitle.font = regular(Config.subhead)
        beerSubtitle.numberOfLines = 1
        
        // Set beer Caption
        beerCaption.text = beer.descriptionField
        beerCaption.textColor = Config.gray
        beerCaption.font = regular(Config.subhead)
        beerCaption.numberOfLines = 2
        
        // Set beer MoreInfo
        beerMoreInfo.text = "More info".uppercased()
        beerMoreInfo.textColor = Config.orange
        beerMoreInfo.font = semiBold(Config.body)
        beerMoreInfo.numberOfLines = 1
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
