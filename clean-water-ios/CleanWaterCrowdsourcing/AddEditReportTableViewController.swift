//
//  AddEditReportTableViewController.swift
//  CleanWaterCrowdsourcing
//
//  Created by Wenqi He on 7/11/17.
//  Copyright © 2017 Wenqi He. All rights reserved.
//

import UIKit
import CoreLocation

class AddEditReportTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var appDelegate: AppDelegate!
    
    let waterQualityLevels = WaterQuality.allValues
    var waterReport: WaterReport!
    var isEditingExistingReport: Bool!


    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var waterQualityTextField: UITextField!
    @IBOutlet weak var deleteReportButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Configures input fields
        latitudeTextField.text = String(waterReport.coordinate.latitude)
        longitudeTextField.text = String(waterReport.coordinate.longitude)
        waterQualityTextField.text = waterReport.quality.rawValue
        
        // Configures the picker view
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        waterQualityTextField.inputView = picker
        
        // Configures the tool bar for input views
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                         action: #selector(keyboardDoneButtonPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
        toolBar.isUserInteractionEnabled = true
        
        latitudeTextField.inputAccessoryView = toolBar
        longitudeTextField.inputAccessoryView = toolBar
        waterQualityTextField.inputAccessoryView = toolBar
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Done button press handler
    func keyboardDoneButtonPressed() {
        self.view.endEditing(true)
    }

    @IBAction func editingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        if text.isEmpty {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        appDelegate.ref.child("reports").child(String(waterReport.reportId))
            .setValue(nil)
        self.dismissViewController()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        appDelegate.ref.child("reports").child(String(waterReport.reportId))
            .setValue(["latitude": Double(latitudeTextField.text ?? "")!,
                       "longitude": Double(longitudeTextField.text ?? "")!,
                       "quality": waterQualityTextField.text!])
        self.dismissViewController()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismissViewController()
    }
    
    // Helper method
    func dismissViewController() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table view data source methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isEditingExistingReport {
            return 4
        } else {
            return 3
        }
    }
    
    // Picker view delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return waterQualityLevels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return waterQualityLevels[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        waterQualityTextField.text = waterQualityLevels[row].rawValue
    }

}
