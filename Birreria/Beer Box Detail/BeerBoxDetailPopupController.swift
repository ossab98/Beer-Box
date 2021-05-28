//
//  BeerBoxDetailPopupController.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 27/05/21.
//

import UIKit

class BeerBoxDetailPopupController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var popViewBackground: UIView!
    @IBOutlet weak var beerImg: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerSubtitle: UILabel!
    @IBOutlet weak var beerCaption: UILabel!
    @IBOutlet weak var bookmarkImg: UIImageView!
    
    // MARK: - Properties
    var entity: BeerBoxElement!
    
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showAnimate()
        setUpView()
        addGesture()
    }
    
    // didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}


// MARK: - Func Helper
extension BeerBoxDetailPopupController {
    
    func addGesture(){
        self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismiss(_ sender: UITapGestureRecognizer){
        removeAnimate()
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished){
                self.view.removeFromSuperview()
                self.dismiss(animated: true, completion: nil)
            }
        });
    }
    
}


// MARK:- Func SetUpView
extension BeerBoxDetailPopupController {
    
    func setUpView(){
        
        // Set backgroundColor View
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Set Search View
        popViewBackground.backgroundColor = Config.darkBlue
        popViewBackground.layer.cornerRadius = Config.cornerRadius
        popViewBackground.dropShadow()
        
        // Set bookmark image
        bookmarkImg.image = UIImage(named: "bookmark")
        bookmarkImg.contentMode = .scaleAspectFill
        
        // Set beer Image
        beerImg.contentMode = .scaleAspectFit
        if let url = URL(string: entity.imageUrl ?? "" ){
            beerImg.sd_setImage(with: url, placeholderImage: UIImage(named: "place-holder"))
        }
        
        // Set beer Title
        beerTitle.text = entity.name
        beerTitle.textColor = Config.white
        beerTitle.font = medium(Config.title)
        beerTitle.numberOfLines = 0
        
        // Set beer Subtitle
        beerSubtitle.text = entity.tagline
        beerSubtitle.textColor = Config.gray
        beerSubtitle.font = regular(Config.body)
        beerSubtitle.numberOfLines = 0
        
        // Set beer Caption
        beerCaption.text = entity.descriptionField
        beerCaption.textColor = Config.gray
        beerCaption.font = regular(Config.subhead)
        beerCaption.numberOfLines = 0
    }
}
