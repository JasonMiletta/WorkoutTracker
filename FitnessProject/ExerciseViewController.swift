//
//  ExerciseViewController.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/22/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class ExerciseViewController: UITableViewController, ExerciseDelegate {
    
    var objects: [Exercise] = []
    
    var workoutIndex: Int?
    var delegate: RemoveExerciseDelegate?
    
    var detailItem: Workout? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        if let workout = detailItem{
            objects = workout.exercises
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showNewExercise" {
            let controller = segue.destinationViewController as! DetailViewController
            controller.delegate = self
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        if segue.identifier == "showEditExercise" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as Exercise
                let controller = segue.destinationViewController as! DetailViewController
                controller.delegate = self
                controller.detailItem = object
                controller.index = indexPath.row
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ExerciseCell
        
        let object = objects[indexPath.row]
        
        cell.setup(object)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            delegate?.removeExercise(workoutIndex!, exerciseIndex: indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func addExercise(exerciseName: String, sets: Int, reps: Int, weight: Int) {
        let exercise: Exercise = Exercise(exerciseName: exerciseName, sets: sets, reps: reps, weight: weight)
        objects.append(exercise)
        detailItem?.exercises.append(exercise)
        self.tableView.reloadData()
    }
    
    func updateExercise(index: Int, exerciseName: String, sets: Int, reps: Int, weight: Int){
        objects[index].name = exerciseName
        objects[index].sets = sets
        objects[index].reps = reps
        objects[index].weight = weight
        self.tableView.reloadData()
    }
    
    @IBAction func closeExerciseDetail(segue:UIStoryboardSegue){
        
    }
}

protocol RemoveExerciseDelegate {
    func removeExercise(workoutIndex: Int, exerciseIndex: Int)
}
