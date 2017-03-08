//
//  HappinessViewController.swift
//  Happiness
//
//  Created by yanyin on 05/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    var happiness: Int = 25 { //0 = very sad, 100 = estatic
        didSet{
            happiness = min(max(happiness, 0), 100)
            print("happiness = \(happiness)")
            updateUI()
        }
        
    }
    
    func updateUI() {
        faceView?.setNeedsDisplay()
        print("updateUI()")
        //这里的问号干吗用，老师说了没听懂，如果不放的话会crash，但是我不懂原理
        title = "\(happiness)"
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        print("smilinessForFaceView")
        return Double(happiness - 50) / 50
    }
    
    private struct Constant {
        static let HappinessGestureScale: CGFloat = 4
    }
    
//    func changeHappiness(gesture: UIPanGestureRecognizer)  {
//        switch gesture.state {
//        case .ended: fallthrough
//        case .changed:
//            let translation = gesture.translation(in: faceView)
//            let happinessChange = -Int(translation.y / Constant.HappinessGestureScale)
//            if happinessChange != 0 {
//                happiness += happinessChange
//                gesture.setTranslation(CGPoint.zero, in: faceView)
//            }
//        default: break
//        }
//    }

    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended: fallthrough
        case .changed:
            let translation = gesture.translation(in: faceView)
            let happinessChange = -Int(translation.y / Constant.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                print("changeHappiness")
                gesture.setTranslation(CGPoint.zero, in: faceView)
            }
        default: break
        }

    }
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            //didset不懂
            faceView.dataSouce = self
            //表示把自己当做代理？传入FaceView，返回Double？
            print("faceView.dataSouce = self")
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.scale(gesture:))))
            print("Pinch")
            //FaceView.scale(gesture:)就相当于scale()? #selector(）表示啥？
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.changeHappiness(gesture:))))
            
        }
    
    }
    
}
