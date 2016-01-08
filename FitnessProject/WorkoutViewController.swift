//
//  MasterViewController.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/1/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//
// TODO Fix back navigation once inside of a workout

import UIKit

class WorkoutViewController: UITableViewController, TagDelegate, RemoveExerciseDelegate {

    var detailViewController: DetailViewController? = nil
    var objects: [Workout] = []


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        let newWorkout = Workout()
        objects.insert(newWorkout, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showExercises" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ExerciseViewController
                controller.delegate = self
                controller.workoutIndex = indexPath.row
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("workoutCell", forIndexPath: indexPath) as! WorkoutCell

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
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    @IBAction func editWorkoutTag(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.Began{
            let location = sender.locationInView(self.tableView)
            let index = self.tableView.indexPathForRowAtPoint(location)
            
            if(index != nil){
                let tagViewController = TagViewController()
                tagViewController.delegate = self
                tagViewController.index = index?.row
                if (UIDevice.currentDevice().userInterfaceIdiom ==  UIUserInterfaceIdiom.Pad) {
                    let popover = UIPopoverController(contentViewController: tagViewController)
                    popover.popoverContentSize = CGSize(width: 300, height: 400)
                    //popover.presentPopoverFromRect(sender, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
                }
                else{
                    self.presentViewController(tagViewController, animated: true,   completion: nil)
                }
            }
        }
        
    }
    
    func updateTag(entryTag: String, index: Int) {
        objects[index].tag = entryTag
        tableView.reloadData()
    }
    
    func removeExercise(workoutIndex: Int, exerciseIndex: Int){
        objects[workoutIndex].exercises.removeAtIndex(exerciseIndex)
    }

}

