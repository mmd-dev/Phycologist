//
//  DiagnosedHappiness.swift
//  Phychologist
//
//  Created by yanyin on 08/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController: HappinessViewController, UIPopoverPresentationControllerDelegate
{
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
            print("didSet happiness")
        }
    }
    
    private let defaults = UserDefaults.standard
    //UserDefaults.standard看了链接没看懂
    
    var diagnosticHistory: [Int] {
        get { return defaults.object(forKey: History.DefaultsKey) as? [Int] ?? [] }
        set { defaults.set(newValue, forKey: History.DefaultsKey) }
    }
    //上面整个关于default不太懂，只知道set、object、standard都是UserDefaults的属性或者方法
    
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destination as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
