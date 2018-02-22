//
//  MenuCell.swift
//  On-Demand Resources Example
//
//  Created by Ricardo Rachaus on 15/02/18.
//  Copyright © 2018 Apple Developer Academy UCB. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    /// Label that shows download progress.
    @IBOutlet weak var isDownloaded: UILabel!
    /// Progress view that shows download progress.
    @IBOutlet weak var progressView: UIProgressView!

}
