//
//  TVShowTableViewCell.swift
//  Life Plus
//
//  Created by Habibur Rahman on 5/3/23.
//

import UIKit

class TVShowTableViewCell: UITableViewCell {
    @IBOutlet var poster: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var network: UILabel!
    var tvShows: TVShow?
}
