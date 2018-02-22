//
//  CelebrityViewController.swift
//  On-Demand Resources Example
//
//  Created by Ricardo Rachaus on 15/02/18.
//  Copyright © 2018 Apple Developer Academy UCB. All rights reserved.
//

import UIKit

class CelebrityViewController: UIViewController {

    /// Image of the celebrity to be displayed.
    @IBOutlet weak var celebrityImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        celebrityImage.image = UIImage(named: navigationItem.title!)
    }

}
