//
//  ViewController.swift
//  A5_P1_Kim_YongHwan
//
//  Created by YongHwan Kim on 10/28/19.
//  Copyright © 2019 YongHwan Kim. All rights reserved.

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var deptAbbr: UITextField!
    @IBOutlet weak var courseNum: UITextField!
    @IBOutlet weak var coureTitle: UITextField!
    @IBAction func bgGesture(_ sender: UITapGestureRecognizer) {
        deptAbbr.resignFirstResponder()
        courseNum.resignFirstResponder()
        coureTitle.resignFirstResponder()
    }
    
    var deptAbbrResult = ""
    var courseNumResult: Int16 = 0
    var courseTitleResult = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deptAbbr.delegate = self
        deptAbbr.becomeFirstResponder()
        
        courseNum.delegate = self
        courseNum.becomeFirstResponder()
        
        coureTitle.delegate = self
        coureTitle.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let isBlank: Bool
        var isEmptyText: Bool = false

        if deptAbbr.text!.isEmpty || courseNum.text!.isEmpty || coureTitle.text!.isEmpty{
            isEmptyText = true
        }
        
        if let courseTitleText = coureTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines), let courseNumText = courseNum.text?.trimmingCharacters(in: .whitespacesAndNewlines), let deptAbbrText = deptAbbr.text?.trimmingCharacters(in: .whitespacesAndNewlines), courseTitleText.count > 0, courseNumText.count > 0, deptAbbrText.count > 0 {
            isBlank = false
        }
        else{
            isBlank = true
        }
        
        if(!isBlank && !isEmptyText)
        {
            deptAbbrResult = deptAbbr.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Bad DeptAbbr"
            courseNumResult = Int16(courseNum.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "-1")!
            courseTitleResult = coureTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Bad Title"
        }
        else
        {
            deptAbbrResult = "Bad DeptAbbr"
            courseNumResult = Int16("-1")!
            courseTitleResult = "Bad Title"
        }   
    }
    
    
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "1234567890"
        let allowedCharacterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharacterSet = CharacterSet(charactersIn: string)
        
        /*let alert = UIAlertController(title: "Warning", message: "Only Numbers are allowed", preferredStyle: T##UIAlertController.Style)*/
        
        return allowedCharacterSet.isSuperset(of: typedCharacterSet)
    }*/
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

