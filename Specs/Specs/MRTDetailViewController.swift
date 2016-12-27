//
//  MRTDetailViewController.swift
//  Specs
//
//  Created by Ping-Ying Yen on 2016/12/24.
//  Copyright © 2016年 Ping-Ying Yen. All rights reserved.
//

import UIKit

class MRTDetailViewController: UIViewController {
    
    @IBOutlet weak var lbl_StationName: UILabel!
    @IBOutlet weak var lbl_LineOne: UILabel!
    @IBOutlet weak var lbl_LineTwo: UILabel!

    var station: Station? {
        didSet {
            // Update when the model is changed.
            self.updateLables()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Update when the view is loaded.
        self.updateLables()
    }
    
    func updateLables() {
        // If the view is not loaded yet, don't update
        guard self.isViewLoaded else {
            return
        }
        // content
        let linesOfStation = station!.lines!
        let nameOfLines = Array(linesOfStation.keys)
        
        lbl_LineOne.isHidden = true
        lbl_LineTwo.isHidden = true
        for line in nameOfLines {
            let indexOfLine = nameOfLines.index(of: line)
            var color: UIColor
            switch line {
            case "文湖線":
                color = UIColor(red: 158.0/255.0, green: 101.0/255.0, blue: 46.0/255.0, alpha: 1.0)
            case "淡水信義線":
                color = UIColor(red: 203.0/255.0, green: 44.0/255.0, blue: 48.0/255.0, alpha: 1.0)
            case "新北投支線":
                color = UIColor(red: 248.0/255.0, green: 144.0/255.0, blue: 165.0/255.0, alpha: 1.0)
            case "松山新店線":
                color = UIColor(red: 0.0/255.0, green: 119.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            case "小碧潭支線":
                color = UIColor(red: 206.0/255.0, green: 220.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            case "中和新蘆線":
                color = UIColor(red: 255.0/255.0, green: 163.0/255.0, blue: 0.0/255.0, alpha: 1.0)
            case "板南線":
                color = UIColor(red: 0.0/255.0, green: 94.0/255.0, blue: 184.0/255.0, alpha: 1.0)
            case "貓空纜車":
                color = UIColor(red: 119.0/255.0, green: 185.0/255.0, blue: 51.0/255.0, alpha: 1.0)
            default:
                color = UIColor.black
            }
            
            if indexOfLine == 0 {
                lbl_LineOne.isHidden = false
                lbl_LineOne.backgroundColor = color
                lbl_LineOne.text = line
            }
            else {
                lbl_LineTwo.isHidden = false
                lbl_LineTwo.backgroundColor = color
                lbl_LineTwo.text = line
            }
        }
        
        // Update title of the navigation bar
        self.navigationItem.title = station?.name
        
        // Update labels
        self.lbl_StationName.text = station?.name


    }
}
