//
//  WorkoutCell.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/23/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class WorkoutCell: UITableViewCell {
    
    private var workout: Workout?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var entryTagLabel: UILabel!
    
    func setup(workout: Workout){
        self.workout = workout
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy - hh:mm"
        let dateString = dateFormatter.stringFromDate(workout.date)
        dateLabel.text = dateString
        
        entryTagLabel.text = workout.tag
    }
}
