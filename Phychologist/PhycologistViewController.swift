//
//  ViewController.swift
//  Phychologist
//
//  Created by yanyin on 07/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class PhycologistViewController: UIViewController
{
    
    @IBAction func nothing(_ sender: UIButton) {
        performSegue(withIdentifier: "nothing", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destination = segue.destination as? UIViewController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
        }
        
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }
   
}

