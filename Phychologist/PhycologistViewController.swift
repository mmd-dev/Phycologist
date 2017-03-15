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
        //sender： nil是啥，老实说这里是啥都行……懵逼脸
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var destination = segue.destination as? UIViewController
        //为啥destination既是UIViewController又是UINavigationController？
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
    init (code aDecoder: NSCoder)
    
    override func awakeFromNib() {
        NSLog("awakeFromNib")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("viewDidLoad()")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLog("viewWillApear(animated = \(animated))")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NSLog("viewDidApear(animated = \(animated))")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NSLog("viewWillApear(animated = \(animated))")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NSLog("viewDidApear(animated = \(animated))")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        NSLog("viewWillLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLog("viewDidLayoutSubviews() bounds.size = \(view.bounds.size)")
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        NSLog("viewWillTransitionToSize")
        coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext!) -> Void in self.NSLog("viewWillTransitionToSize") }, completion: { context -> Void in self.NSLog("viewWillTransitionToSize") } )
    }
}
