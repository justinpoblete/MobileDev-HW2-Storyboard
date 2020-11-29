//
//  ViewController.swift
//  ClaimClient
//
//  Created by Justin Poblete on 11/25/20.
//  Copyright © 2020 Justin Poblete. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var claimTitle: UITextField!
    @IBOutlet var claimDate: UITextField!
    @IBOutlet var statusMessage: UILabel!
    @IBAction func addTapped(_ sender: UIButton){
        print("ADD was tapped")
        let cT = claimTitle.text as String?
        let cD = claimDate.text as String?
        let claim = ClaimService()
        
        if cT!.isEmpty && cD!.isEmpty{
            statusMessage.text = "Nothing Entered"
        }
        else if cT!.isEmpty {
            statusMessage.text = "Enter Claim Title"
        }
        else if cD!.isEmpty {
            statusMessage.text = "Enter Date"
        }
        else {
            let cObj = Claim(title: cT!, date: cD!)
            claim.addClaim(cObj: cObj, completion: { value in
                if value{
                    self.statusMessage.text = "Claim \(cT!) was successfully created"
                    self.claimTitle.text = ""
                    self.claimDate.text = ""
                }
                else{
                    self.statusMessage.text = "Claim \(cT!) failed to be created"
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        claimTitle.returnKeyType = .done
        // Do any additional setup after loading the view.
    }

}

