//
//  createGroup.swift
//  travel app new
//
//  Created by tusher on 11/20/15.
//  Copyright © 2015 tusher. All rights reserved.
//

import UIKit


class createGroup: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var txtGroupName: UITextField!
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var txtMemberNumber: UITextField!
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var btnCreateGroup: UIButton!
    @IBOutlet var placeholderView: UIView!
    
    @IBOutlet weak var backView: UIView!
    @IBAction func valueChanged(sender: UIStepper) {
        let value = Int(sender.value)
        
        txtMemberNumber.text=value.description
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtGroupName.delegate=self
        txtDate.delegate=self
        txtMemberNumber.delegate=self
        
       
        self.backView.viewWithTag(1)?.hidden = true
        
        self.placeholderView.viewWithTag(2)?.hidden=true
        txtDate.addTarget(self, action: "myTargetEditingDidBeginFunction:", forControlEvents: UIControlEvents.EditingDidBegin)
       // let tap = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard"))
        
       // self.view .addGestureRecognizer(tap)
    
    }
    
    
    func myTargetEditingDidBeginFunction(textField: UITextField) {
        txtDate.text=""
        self.backView.viewWithTag(1)?.hidden = false
        
        self.placeholderView.viewWithTag(2)?.hidden=false
    }
    
    func didSelectDate(date: NSDate) {
       
     
        
    }
       func dismissKeyboard(){
        [txtGroupName .resignFirstResponder()]
        [txtDate .resignFirstResponder()]
        [txtMemberNumber .resignFirstResponder()]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text="Location"+indexPath.row.description
       
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}