//
//  ViewController.swift
//  Demo
//
//  Created by JerryYu on 2020/8/14.
//  Copyright © 2020 DolphinBro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let singleComponetPopupPickerView = AYPopupPickerView()
    let multipleComponentPopupPickerView = AYPopupPickerView()
    let popupDatePickerView = AYPopupDatePickerView()
    let customPopupPickerView = AYPopupPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singleComponetPickerViewButtonTapped(_ sender: Any) {
        let itemsTitle = ["Apple", "Avocado", "Banana", "Cherry", "Coconut", "Grape"]
        singleComponetPopupPickerView.display(itemTitles: itemsTitle, doneHandler: {
            let selectedIndex = self.singleComponetPopupPickerView.pickerView.selectedRow(inComponent: 0)
            print("\(itemsTitle[selectedIndex])")
        })
    }
    
    @IBAction func multipleComponentPickerViewButtonTapped(_ sender: Any) {
        multipleComponentPopupPickerView.pickerView.dataSource = self
        multipleComponentPopupPickerView.pickerView.delegate = self
        multipleComponentPopupPickerView.display(doneHandler: {
            let component0 = self.multipleComponentPopupPickerView.pickerView.selectedRow(inComponent: 0)
            let component1 = self.multipleComponentPopupPickerView.pickerView.selectedRow(inComponent: 1)
            print("\(component0), \(component1)")
        })
    }
    
    @IBAction func datePickerViewButtonTapped(_ sender: Any) {
        popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
            print("\(date)")
        })
    }
    
    @IBAction func customPopupPickerViewButtonTapped(_ sender: Any) {
        customPopupPickerView.headerView.backgroundColor = UIColor.green
        customPopupPickerView.doneButton.setTitle("OK", for: .normal)
        customPopupPickerView.doneButton.setTitleColor(.red, for: .normal)
        customPopupPickerView.cancelButton.setTitleColor(.blue, for: .normal)
        customPopupPickerView.display(itemTitles: ["A", "B", "C"], doneHandler: {
            
        })
    }
    
    
        
}

extension ViewController: UIPickerViewDataSource & UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
}

