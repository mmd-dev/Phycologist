//
//  FaceView.swift
//  Happiness
//
//  Created by yanyin on 05/03/2017.
//  Copyright © 2017 yanyin. All rights reserved.
//

import UIKit

protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView //为什么这里不需要写协议？
// 解答：
// 因为如果这边写了协议，就是表示FaceView实现了FaceViewDataSource这个协议，那么在给faceView.dataSource赋值的时候
// 就会发生 faceView.dataSource = <...> 这里的<...>可能就必须是FaceView类的实例了噢
{
    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet {setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blue { didSet {setNeedsDisplay() } }
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet {setNeedsDisplay() } }
    
    
    var faceCenter: CGPoint {
        return convert(center, to: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    weak var dataSouce: FaceViewDataSource?
    
    
    func scale(gesture: UIPinchGestureRecognizer) {
        if gesture.state == .changed {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
        
    override func draw(_ rect: CGRect) {
        
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        print("drawface")
        
        bezierPathForEye(whichEye: .Left).stroke()
        bezierPathForEye(whichEye: .Right).stroke()
        print("draweye")
        
        let smiliness = dataSouce?.smilinessForFaceView(sender: self) ?? 0.0
        print("\(smiliness)")
        //self是FaceView？
        let smilePath = bezierPathForSmile(fractionOfMaxSmile: smiliness)
        smilePath.stroke()
        print("drawsmile")
    }
        
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffSetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeperationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRadiusRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRadiusRatio: CGFloat = 3
        static let FaceRadiusToMouthOffSetRadiusRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right}
    
    private func  bezierPathForEye(whichEye: Eye) -> UIBezierPath{
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffSetRatio
        let eyeHorizontalSeperation = faceRadius / Scaling.FaceRadiusToEyeSeperationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeperation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeperation / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath{
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRadiusRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRadiusRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffSetRadiusRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
        
    }
    

}
