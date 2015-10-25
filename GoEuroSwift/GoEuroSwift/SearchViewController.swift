//
//  SearchViewController.swift
//  GoEuroSwift
//
//  Created by Bob Godwin Obi on 10/16/15.
//  Copyright © 2015 Bob Godwin Obi. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, ManagerDelegate, UITextFieldDelegate, LocationManagerDelegate {
    
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var arrivalTextField: UITextField!
    @IBOutlet weak var dateTextField:UITextField!
    @IBOutlet weak var datePickerHeightConstraint:NSLayoutConstraint!
    @IBOutlet weak var datePicker:UIDatePicker!
    @IBOutlet weak var searchBtn:UIButton!
    private (set)var currentLocations:[Location]?
    var selectedLocation:Location?
    /**
     conforming to protocol property in managerDelegate
     */
    var protocolProperty:String?

    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.sharedInstance.delegate = self
        Manager.sharedInstance.locationManager.delegate = self
        Manager.sharedInstance.locationManager.requestCurrentLocation()
        /**
         setting a protocolProperty
         */
        protocolProperty = "hello I am a protocolProperty"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureTextField(departureTextField)
        configureTextField(arrivalTextField)
        configureTextField(dateTextField)
        navigationController?.navigationBarHidden = true
        datePickerHeightConstraint.constant = 0.0
        configureSearchButton()
    }
    
    func configureTextField(textField:UITextField){
        if textField == dateTextField {
            textField.layer.borderColor = Manager.sharedInstance.geRoyalBlueColor.CGColor
            textField.text = Manager.sharedInstance.dateFormatter.stringFromDate(NSDate())
            /**
             Testing associated objects
             */
            textField.cellIndexPath = NSIndexPath(forRow: 0, inSection: 34)
        }
        textField.delegate = self
        textField.layer.borderColor = Manager.sharedInstance.geAliceBlueColor.CGColor
        textField.layer.borderWidth = 1.00
        textField.layer.cornerRadius = 7.00
        let leftPaddingView = UIView(frame: CGRectMake(0, 0, 10, 42))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .Always;
        
        if textField == arrivalTextField {
            textField.rightView = UIImageView(image: UIImage(named: "Disclosure"))
            textField.rightViewMode = .Always
        }
    }
    
    func configureSearchButton(){
        guard departureTextField.text?.characters.count > 0 && arrivalTextField.text?.characters.count > 0 && dateTextField.text?.characters.count > 0 else {
            searchBtn.backgroundColor = Manager.sharedInstance.geGrayColor
            searchBtn.userInteractionEnabled = false
            searchBtn.enabled = false
            return
        }
        searchBtn.backgroundColor = Manager.sharedInstance.geRoyalBlueColor
        searchBtn.userInteractionEnabled = true
        searchBtn.enabled = true
    }
    
    // MARK: - Prepare for segue.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier
        {
        case kSegue.LocationsTableViewControllerSegue:
            guard currentLocations?.count > 0 else {
                return
            }
            guard let locationsTableViewController = segue.destinationViewController as? LocationsTableViewController else {
                return
            }
            locationsTableViewController.dataSource!.locations = currentLocations
            
        default:break
        }
    }
    
    @IBAction func unwindFromLocationsTableViewController(sender: UIStoryboardSegue) {
        guard let locationsTableViewController = sender.sourceViewController as? LocationsTableViewController else {
            return
        }
        
        arrivalTextField.text = locationsTableViewController.selectedLocation?.fullname
    }
    
    //MARK: - PerformSearchWithString
    
    func performSearchWithString(string:String) {
        //TODO:- do stuffs
        guard string.characters.count > 0 else {
            //FIXME: Handle error
            return
        }
        
        dispatch_async(Manager.sharedInstance.concurrentQueue, {
            let searchString = string.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
            let query = Query(locale:"DE", term:searchString)
            Manager.sharedInstance.fetchLocationsWithQuery(query)
        })
    }
    
    //MARK: - Present error
    
    func presentAlertViewWithError(errorMessage:String) {
        let alertViewController = UIAlertController(title: "Location error", message: errorMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertViewController.addAction(okAction)
        presentViewController(alertViewController, animated: true, completion: nil)
    }
    
    //MARK: - UIDatePicker changed value
    
    @IBAction func datePickerValueDidChange(sender: AnyObject) {
        guard let datePicker = sender as? UIDatePicker else {
            return
        }
        
        dateTextField.text = Manager.sharedInstance.dateFormatter.stringFromDate(datePicker.date)
    }

    //MARK: - searchLocations
    
    @IBAction func searchLocations(sender: AnyObject){
        UIAlertView.init(title: "GoEuro", message: "Search is not yet implemented", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    //MARK: - ManagerDelegate 
    
    func managerDidFinishFetchingLocations(locations: [Location]) {
        guard locations.count > 0 else {
            return
        }
        currentLocations = locations
        let location = locations[0]
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.arrivalTextField.text = location.fullname
            strongSelf.configureSearchButton()
        }
    }
    
    func managerDidFailFetchingLocationsWithError(error: CommunicatorError) {
        presentAlertViewWithError(error.description)
    }
    
    //MARK: - LocationManagerDelegate
    
    func locationDidFindCurrentLocality(locality: String) {
        departureTextField.text = locality
        dispatch_async(Manager.sharedInstance.concurrentQueue, {
            let query = Query(locale:"DE", term:locality)
            Manager.sharedInstance.fetchLocationsWithQuery(query)
        })
    }
    
    func locationDidChangeAuthorizationStatus(authorizationStatus: CLAuthorizationStatus) {
        var message:String?
        
        switch authorizationStatus {
        case .NotDetermined:
            message = "Can't determine authorization status"
        case .Restricted:
            message = "Authorization restricted"
        case .Denied:
            message = "Authorization denied"
        default:break;
        }

        guard let errorMessage = message else {
           return
        }
        
        presentAlertViewWithError(errorMessage)
    }
    
    func locationDidFailFindingCurrentLocalityWithError(error: LocationError) {
        presentAlertViewWithError(error.description)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            if textField == departureTextField {
                performSearchWithString(departureTextField.text!)
            }
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        observeTextField(textField)
        if textField == dateTextField || textField == arrivalTextField {
            textField.resignFirstResponder()
            textField.tintColor = UIColor.clearColor()
            
            if textField == dateTextField {
                print(textField.cellIndexPath)
                switch datePickerHeightConstraint.constant {
                case 0.00:
                    datePickerHeightConstraint.constant = 139.00
                case 139.00:
                    datePickerHeightConstraint.constant = 0.00
                default:break
                }
            } else if textField == arrivalTextField {
                performSegueWithIdentifier(kSegue.LocationsTableViewControllerSegue, sender: self)
            }
        }
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    
    //MARK: - UITextField observer
    
    func observeTextField(textField: UITextField) {
        NSNotificationCenter.defaultCenter().addObserverForName(UITextFieldTextDidChangeNotification, object: nil, queue:NSOperationQueue.mainQueue()) { [weak self] (note:
            NSNotification!) in
            guard let strongSelf = self else {
                return
            }
            /**
             Update the search button based on textFields
             */
            strongSelf.configureSearchButton()
        }
    }
    
    //MARK: - TouchesBegan

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /**
         Force the keyboard to dismiss
         */
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
}
