//
//  OfferCell.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 27/05/21.
//

import UIKit

class OfferCell: UICollectionViewCell {
    
    // MARK:- Outlets
    // Offer View
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var offerImg: UIImageView!
    @IBOutlet weak var lblOfferTitle: UILabel!
    @IBOutlet weak var lblOfferCaption: UILabel!

    
    func setUpCell(_ offer: OfferModel){
        
        // Set Offer View
        offerView.backgroundColor = Config.orange
        offerView.layer.cornerRadius = Config.cornerRadius
        offerView.dropShadow()
        
        // Set Offer image
        offerImg.image = UIImage(named: offer.img)
        offerImg.contentMode = .scaleAspectFill
        
        // Set Offer Title
        lblOfferTitle.text = offer.title
        lblOfferTitle.textColor = Config.darkBlue
        lblOfferTitle.font = medium(Config.body)
        lblOfferTitle.numberOfLines = 1
        
        // Set Offer Caption
        lblOfferCaption.text = offer.caption
        lblOfferCaption.textColor = Config.darkGray
        lblOfferCaption.font = regular(Config.subhead)
        lblOfferCaption.numberOfLines = 1
        
    }
    
    
}
