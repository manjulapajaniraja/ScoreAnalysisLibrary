//
//  RangeRepresentationCell.swift
//  StatsData
//
//  Created by Manjula Pajaniraja on 03/03/21.
//

import UIKit

class RangeRepresentationCell: UITableViewCell {
    
    static let reuseIdentifierId = "RangeRepresentationCell"

    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var userRangeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userRangeLabel.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(details: RangeDetails) {
        guard let low = details.low, let high = details.high, let percentage = details.percentage else { return }
        rangeLabel.text = String(low) + " - " + String(high)
        percentageLabel.text = String(percentage) + "%"
        //set random background color
        let redValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        rangeLabel.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        userRangeLabel.isHidden = true
    }
    
    func enableUserRange(range: Int) {
        userRangeLabel.text = String(range)
        userRangeLabel.backgroundColor = .white
        userRangeLabel.isHidden = false
        userRangeLabel.layer.cornerRadius = 10.0
        userRangeLabel.layer.masksToBounds = true
        
    }
    
}
