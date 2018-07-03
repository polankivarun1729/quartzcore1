//
//  SMRotaryWheel.swift
//  RotaryWheelProject
//
//  Created by Admin on 8/28/17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import QuartzCore

protocol SMRotaryProtocol {
    func wheelDidChangeValue (newValue: String)
}

class SMRotaryWheel: UIControl {
    
    var delegate: SMRotaryProtocol?
    var container: UIView?
    var numberOfSections: Int = 0
    
    static var deltaAngle: Float = 0
    var startTransform: CGAffineTransform = CGAffineTransform( rotationAngle: CGFloat(0) )
    
//    var angleSize: Double {
//        get{
//            return Double.pi * 2 / Double ( numberOfSections )
//        }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init (frame: CGRect, del: SMRotaryProtocol, sectionsNumber: Int) {
        self.init (frame: frame)
        self.numberOfSections = sectionsNumber
        self.delegate = del
        drawWheel ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    static  var minAlphavalue: CGFloat = 0.6
//    static  var maxAlphavalue: CGFloat = 1.0
//    
    func drawWheel() {
        // 1
        container = UIView (frame: frame)
//        let i = UIView(frame: CGRect(x: 100, y: 500, width: 100, height: 100))
//        i.backgroundColor = UIColor.red
        // 2 this is a class property now, not just a variable in the method
        //let angleSize = CGFloat (2 * Double.pi ) / CGFloat ( numberOfSections );
        // 3
//        for i in 0..<numberOfSections {
//
//            // 4 - Create image view
//            let im = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//            im.backgroundColor = UIColor.red
//            im.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
//            im.layer.position = CGPoint(x: 200,
//                                        y: 200)
//            im.transform = CGAffineTransform(rotationAngle: CGFloat ( angleSize ) * CGFloat (i)  );
//            im.alpha = SMRotaryWheel.minAlphavalue;
//            im.tag = i;
//            if (i == 0){
//                im.alpha = SMRotaryWheel.maxAlphavalue;
//
//            }
//            // 5 - Set sector image
//            let sectorImage = UIView( frame: CGRect(x: 12, y: 15, width: 100  , height: 100))
////            sectorImage.image = UIImage (named: "icon\(i).png")
//            im.addSubview (sectorImage)
//            // 6 - Add image view to container
//            container!.addSubview (im)
//      container?.addSubview(i)
//        }
        
        // 7
        container!.isUserInteractionEnabled = false;
        
        // 7.1 - Add background image
        
        let bg = UIImageView (frame: frame)
//        bg.image = UIImage (named: "bg.png")
        addSubview (bg)
        
       addSubview (container!)
      //  let n = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        let mask = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
        mask.backgroundColor = UIColor.blue
//        mask.image = UIImage (named: "centerButton.png")
        //mask.sizeToFit()

        mask.center = center
        mask.center = CGPoint (x: mask.center.x, y: mask.center.y)
        container?.addSubview (mask)
    }
    
    var currentSector: Int = 0
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // 1 - Get touch position
        let touchPoint = touch.location(in: self)
        // 1.1 - Get the distance from the center
//        let dist = self.calculateDistanceFromCenter (point: touchPoint);
        // 1.2 - Filter out touches too close to the center
//        if (dist < 40 || dist > 100)
//        {
//            // forcing a tap to be on the ferrule
//            print( "ignoring tap \(touchPoint.x), \(touchPoint.y)" );
//            return false;
       // }
    
        // 2 - Calculate distance from center
        let dx = touchPoint.x - container!.center.x;
        let dy = touchPoint.y - container!.center.y;
        // 3 - Calculate arctangent value
        SMRotaryWheel.deltaAngle = Float( atan2(dy,dx) );
        // 4 - Save current transform
        startTransform = container!.transform;
        
        // 5 - Set current sector's alpha value to the minimum value
//        let im = getSectorByValue (currentSector)
//        im?.alpha = SMRotaryWheel.minAlphavalue;
        return true;
    }
    
//    func getSectorByValue (_ value: Int) -> UIImageView? {
//        var res: UIImageView?
//        let views = container!.subviews as? [UIImageView]
//        for im in views! {
//            if im.tag == value {
//                res = im; }
//        }
//        return res;
//    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
//        let radians = atan2f(Float (  container!.transform.b  ), Float (  container!.transform.a)  )
//        print("rad is \(radians)")
        
        let pt = touch.location(in: self)
        let dx = pt.x  - container!.center.x
        let dy = pt.y  - container!.center.y
        let ang = Float ( atan2(dy,dx) )
        let angleDifference = SMRotaryWheel.deltaAngle - ang
        container!.transform = startTransform.rotated( by: CGFloat ( -angleDifference)  )
        return true
    }
    
//    func calculateNewSector (_ radians:Float) -> Int {
//        let x =   Float ( angleSize / 2 + 2 * Double.pi ) - radians
//        return Int (x / Float ( angleSize )  ) % numberOfSections
//    }
    
//    func calculateDistanceFromCenter (point: CGPoint) ->  Float     {
//        let center = CGPoint (x: bounds.size.width/2, y: bounds.size.height/2)
//        let dx = point.x - center.x;
//        let dy = point.y - center.y;
//        return Float ( sqrt(dx*dx + dy*dy) );
//    }

    
}

