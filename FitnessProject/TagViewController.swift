//
//  TagViewController.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/22/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class TagViewController : UIViewController {
    
    var delegate: TagDelegate?
    var index: Int!
    
    @IBOutlet weak var tagTextField: UITextField!
    
    init() {
        super.init(nibName: "WorkoutTagEditor", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //TODO update the tag on the workout
    @IBAction func addTag(sender: UIButton) {
        delegate?.updateTag(tagTextField!.text!, index: index)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

protocol TagDelegate {
    func updateTag(entryTag: String, index: Int)
}
