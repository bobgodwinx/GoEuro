//
//  SearchViewController.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var dateTextField:UITextField!
    @IBOutlet weak var datePickerHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var searchBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
