//
//  PetDetailsViewController.swift
//  Ruff-Ruff
//
//  Created by Likhon Gomes on 6/29/18.
//  Copyright © 2018 ruffRuff. All rights reserved.
//

import UIKit

class PetDetailsViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var nameData:String = ""
    var ageData:String = ""
    var priceData:String = ""
    var locationData:String = ""
    var descriptionData:String = ""
    var dogImage:Array<UIImage> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("dfgdf\(nameData)")
        imageView.image = dogImage[0]
        nameLabel.text = nameData
        ageLabel.text = ageData
    }

    
}
