# AYPopupPickerView

A Popup PickerView or DatePickerView

[![Swift 5](https://img.shields.io/badge/Swift-5-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AYPopupPickerView.svg?style=flat?style=flat)](https://cocoapods.org/pods/AYPopupPickerView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager)
[![Platform](https://img.shields.io/cocoapods/p/RxFlow.svg?style=flat)](https://cocoapods.org/pods/AYPopupPickerView)
[![License](https://img.shields.io/cocoapods/l/RxFlow.svg?style=flat)](https://cocoapods.org/pods/AYPopupPickerView)

![image](https://github.com/Aiur3908/AYPopupPickerView/blob/master/README/Demo.gif)

## Installation

#### CocoaPods
```
pod 'AYPopupPickerView'
```
#### Carthage
```
github "Aiur3908/AYPopupPickerView"
```
#### Swift Package Manager
```
File -> Swift Packages -> Add Package Dependency

https://github.com/Aiur3908/AYPopupPickerView
```

#### Manually
Drag and drop Sources folder to your project.

## Usage

### AYPopupPickerView

```Swift
let itemsTitle = ["Apple", "Avocado", "Banana", "Cherry", "Coconut", "Grape"]
let popupPickerView = AYPopupPickerView()
popupPickerView.display(itemTitles: itemsTitle, doneHandler: {
    let selectedIndex = popupPickerView.pickerView.selectedRow(inComponent: 0)
    print(itemsTitle[selectedIndex])
})
```

### AYPopupDatePickerView

```Swift
let popupDatePickerView = AYPopupDatePickerView()
popupDatePickerView.display(defaultDate: Date(), doneHandler: { date in
    print(date)
})
```

## Custom 

### AYPopupPickerView

```Swift
public var pickerView: UIPickerView!
public var doneButton: UIButton!
public var cancelButton: UIButton!
public var headerView: UIView!
```
### AYPopupDatePickerView

```Swift
public var datePickerView: UIDatePicker!
public var doneButton: UIButton!
public var cancelButton: UIButton!
public var headerView: UIView!
```
#### Example

```Swift
let customPopupPickerView = AYPopupPickerView()
customPopupPickerView.headerView.backgroundColor = UIColor.green
customPopupPickerView.doneButton.setTitle("OK", for: .normal)
customPopupPickerView.doneButton.setTitleColor(.red, for: .normal)
customPopupPickerView.cancelButton.setTitleColor(.blue, for: .normal)
```

```Swift
let customPopupDatePickerView = AYPopupDatePickerView()
customPopupDatePickerView.datePickerView.datePickerMode = .date
```

## Multiple Component

You can implementation UIPickerViewDataSource & UIPickerViewDelegate in your ViewController

```Swift
class ViewController: UIViewController {
    
    let popupPickerView = AYPopupPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        popupPickerView.pickerView.dataSource = self
        popupPickerView.pickerView.delegate = self
    }

    @IBAction func display(_ sender: Any) {
        popupPickerView.display(doneHandler: {
            
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
```

## Default Select

#### Single Component

```Swift
popupPickerView.display(itemTitles: itemsTitle, defaultIndex: 1, doneHandler: {

})
```

#### Multiple Component

```Swift
//defaultSelects: [(row: Int, component: Int)]
popupPickerView.display(with: [(2,0), (1,1)], doneHandler: {

})
```

### Author

Jerry You
Email: Aiur3908@gmail.com

### LICENSE
AYPopupPickerView is released under the MIT license. See [LICENSE](https://github.com/Aiur3908/AYPopupPickerView/blob/master/LICENSE) for details.



