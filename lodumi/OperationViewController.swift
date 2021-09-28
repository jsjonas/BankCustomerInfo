//
//  operationIdClass.swift
//  lodumi
//
//  Created by Jonas S on 02/09/2021.
//

import Foundation
import UIKit

class operationIdViewController: ViewController {
    var operationId = CUnsignedLong()

    
    @IBOutlet weak var opIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        opIdLabel.text = "\(operationId)"

    }
}
