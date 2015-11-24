//
//  Workout.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/8/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class Workout{
    var tag: String
    var date: NSDate
    var exercises: [Exercise]
    
    init(){
        self.tag = ""
        self.date = NSDate()
        self.exercises = []
    }
    
    
    
}

class Exercise{
    
    var name: String = "Exercise"
    var sets: Int = 0
    var reps: Int = 0
    var weight: Int = 0
    
    init(){
        self.name = "Exercise"
        self.sets = 0
        self.reps = 0
        self.weight = 0
    }
    
    init(exerciseName: String, sets: Int, reps: Int, weight: Int){
        self.name = exerciseName
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}
