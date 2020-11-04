//
//  AYPopupPickerViewController.swift
//
//  Created by JerryYu on 2020/8/13.
//  Copyright © 2020 DolphinBro. All rights reserved.
//

import UIKit

public class AYPopupPickerView: UIView {
    
    private var itemTitles: [String]?
    private var doneHandler: (() -> Void)?
    private var pickerViewBottomConstraint: NSLayoutConstraint!

    public var pickerView: UIPickerView!
    public var doneButton: UIButton!
    public var cancelButton: UIButton!
    public var headerView: UIView!

    //MARK: - Init
    
    public init() {
        super.init(frame: .zero)
        setup()
        setupPickerView()
        setupHeaderView()
        setupCancelArea()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Setup
    
    private func setup() {
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    private func setupPickerView() {
        pickerView = UIPickerView(frame: .zero)
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerViewBottomConstraint = pickerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 500)
        pickerViewBottomConstraint.isActive = true
        pickerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pickerView.backgroundColor = .white
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupHeaderView() {
        headerView = UIView(frame: .zero)
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: pickerView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headerView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        
        doneButton = UIButton(type: .system)
        headerView.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(done), for: .touchUpInside)
        
        cancelButton = UIButton(type: .system)
        headerView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    private func setupCancelArea() {
        let cancelAreaButton = UIButton(frame: .zero)
        addSubview(cancelAreaButton)
        cancelAreaButton.translatesAutoresizingMaskIntoConstraints = false
        cancelAreaButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cancelAreaButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cancelAreaButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cancelAreaButton.bottomAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        cancelAreaButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    //MARK: - Action
    
    @objc private func done() {
        doneHandler?()
        doneHandler = nil
        dismissAnimation()
    }
    
    @objc private func cancel() {
        doneHandler = nil
        dismissAnimation()
    }
    
    //MARK: - Display & Dismiss
    
    public func display(itemTitles: [String], defaultIndex: Int = 0, doneHandler: @escaping (() -> Void)) {
        self.itemTitles = itemTitles
        self.doneHandler = doneHandler
        pickerView.reloadAllComponents()
        pickerView.selectRow(defaultIndex, inComponent: 0, animated: true)
        addToKeyWindow()
        displayAnimation()
    }
    
    public func display(with defaultSelects: [(row: Int, component: Int)]? = nil, doneHandler: @escaping (() -> Void)) {
        self.doneHandler = doneHandler
        pickerView.reloadAllComponents()
        if let defaultSelects = defaultSelects {
            for defaultSelect in defaultSelects {
                pickerView.selectRow(defaultSelect.row, inComponent: defaultSelect.component, animated: false)
            }
        }
        addToKeyWindow()
        displayAnimation()
    }
    
    private func addToKeyWindow() {
        guard let keyWindow = UIWindow.keyWindow else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        keyWindow.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: keyWindow.topAnchor),
            leftAnchor.constraint(equalTo: keyWindow.leftAnchor),
            bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor),
            rightAnchor.constraint(equalTo: keyWindow.rightAnchor)
        ])
        setNeedsLayout()
        layoutIfNeeded()
    }
        
    private func displayAnimation() {
        pickerViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
    
    private func dismissAnimation() {
        pickerViewBottomConstraint.constant = 500
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
}

extension AYPopupPickerView: UIPickerViewDataSource & UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemTitles?.count ?? 0
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemTitles?[row]
    }
}
