//
//  ExerciseCell.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/23/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    private var exercise: Exercise?
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    func setup(exercise: Exercise){
        self.exercise = exercise
        exerciseNameLabel.text = exercise.name
        setsLabel.text = String(exercise.sets)
        repsLabel.text = String(exercise.reps)
        if exercise.weight == 0{
            weightLabel.text = "Body Weight"
        }
        else{
            weightLabel.text = String(exercise.weight)
        }
    }
    
}
