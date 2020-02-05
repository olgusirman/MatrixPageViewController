//
//  ViewController.swift
//  LinkedPageExample
//
//  Created by Olgu on 28.01.2020.
//  Copyright © 2020 Aspendos IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var indexLabel: UILabel!
    
    var node: Node = Node(x: 0, y: 0) {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random
        updateUI()
    }
    
    fileprivate func updateUI() {
        
        guard isViewLoaded else { return }
        indexLabel.text = node.description
    }
    
}

