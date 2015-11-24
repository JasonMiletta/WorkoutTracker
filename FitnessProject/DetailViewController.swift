//
//  DetailViewController.swift
//  FitnessProject
//
//  Created by Jason Michael Miletta on 4/1/15.
//  Copyright (c) 2015 Jason Michael Miletta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var exercisePicker: UIPickerView!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var setStepper: UIStepper!
    @IBOutlet weak var repStepper: UIStepper!
    
    @IBOutlet weak var weightSlider: UISlider!
    
    var pickerViewData: [String] = ["Bench Press", "Decline Bench Press", "Incline Bench Press", "Incline Shoulder Raise", "Chest Press", "Shoulder Press", "Military Press", "Chest Dip", "Flies", "Push-up"]
    
    var delegate: ExerciseDelegate?
    var index: Int?
    
    var exerciseName: String = "Bench Press"
    
    var detailItem: Exercise? {
        didSet {
            // Update the view.
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        
        if let exerciseItem = detailItem{
            setsLabel.text = String(exerciseItem.sets)
            setStepper.value = Double(exerciseItem.sets)
            repsLabel.text = String(exerciseItem.reps)
            repStepper.value = Double(exerciseItem.reps)
            weightLabel.text = String(exerciseItem.weight)
            weightSlider.value = Float(exerciseItem.weight)
            pickerViewData.insert(String(exerciseItem.name), atIndex: 0)
        }
        
        exercisePicker.dataSource = self
        exercisePicker.delegate = self
        setStepper.minimumValue = 0
        setStepper.autorepeat = true
        repStepper.minimumValue = 0
        repStepper.autorepeat = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerViewData[row]
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        exerciseName = pickerViewData[row]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadChestExercises(sender: UIButton) {
        pickerViewData = ["Bench Press", "Decline Bench Press", "Incline Bench Press", "Incline Shoulder Raise", "Chest Press", "Shoulder Press", "Military Press", "Chest Dip", "Flies", "Push-up"]
        exercisePicker.reloadAllComponents()
        exerciseName = pickerViewData[0]
    }
    
    @IBAction func loadBackExercises(sender: UIButton) {
        pickerViewData = ["Pull Ups", "Reverse Flys", "Lat Pull", "Rows", "Back Extentions", "Pulldown", "Shrug"]
        exercisePicker.reloadAllComponents()
        exerciseName = pickerViewData[0]
    }
    
    @IBAction func loadArmExercises(sender: UIButton) {
        pickerViewData = ["Triceps Dip", "Kickback", "Close Grip Bench Press", "Close Grip Push-up", "Curl", "Preacher Curl", "Concentration Curl"]
        exercisePicker.reloadAllComponents()
        exerciseName = pickerViewData[0]
    }
    
    @IBAction func loadLegExercises(sender: UIButton) {
        pickerViewData = ["Calf Raise", "Lunge", "Squat", "Step-up", "Split Squat"]
        exercisePicker.reloadAllComponents()
        exerciseName = pickerViewData[0]
    }
    
    @IBAction func setStepperChanged(sender: UIStepper) {
        setsLabel.text = Int(sender.value).description
        
    }
    
    @IBAction func repStepperChanged(sender: UIStepper) {
        repsLabel.text = Int(sender.value).description
    }
    
    @IBAction func weightSliderChanged(sender: UISlider) {
        if sender.value == sender.minimumValue{
            weightLabel.text = "Body Weight"
        }
        else{
            weightLabel.text = "\(Int(sender.value))"
        }
    }
    
    @IBAction func addExercise(segue:UIStoryboardSegue) {
        let setsInt: Int = Int(setStepper.value)
        let repsInt: Int = Int(repStepper.value)
        let weightInt: Int = Int(weightSlider.value)
        if let indexNumber = index{
            delegate?.updateExercise(indexNumber, exerciseName: exerciseName, sets: setsInt, reps: repsInt, weight: weightInt)
        } else {
            delegate?.addExercise(exerciseName, sets: setsInt, reps: repsInt, weight: weightInt)
        }
    }
}

protocol ExerciseDelegate {
    func addExercise(exerciseName: String, sets: Int, reps: Int, weight: Int)
    func updateExercise(index: Int, exerciseName: String, sets: Int, reps: Int, weight: Int)
}

