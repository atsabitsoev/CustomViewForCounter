//
//  CounterView.swift
//  CustomViewForCounter
//
//  Created by Ацамаз Бицоев on 22/04/2019.
//  Copyright © 2019 Ацамаз Бицоев. All rights reserved.
//

import UIKit

@IBDesignable
class CounterView: UIView {
    
    @IBInspectable var count: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var radiusOfCircle: CGFloat = 36 {
        didSet {
            setNeedsDisplay()
        }
    }
    @IBInspectable var regularInset: CGFloat = 20 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    @IBInspectable var mainColor: UIColor = #colorLiteral(red: 0.003921568627, green: 0.6784313725, blue: 0.7568627451, alpha: 1)
    @IBInspectable var additionalColor: UIColor = #colorLiteral(red: 0, green: 0.6588235294, blue: 0.737254902, alpha: 1)
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    var shadowOffset = CGSize(width: 0, height: 2)
    @IBInspectable var shadowRadius: CGFloat = 4
    
    
    

    override func draw(_ rect: CGRect) {
        drawCircles(count: count)
    }

    
    private func drawCircles(count: Int) {
        
        let masCenterPoints = getMasCenterPoints()
        for centerPoint in masCenterPoints {
            drawCircle(centerPoint: centerPoint)
        }
        
    }
    
    private func getMasCenterPoints() -> [CGPoint] {
        
        var masCenters: [CGPoint] = []
        
        if count % 2 == 0 {
            
            for i in 0..<count {
                
                let multiplier: CGFloat = CGFloat(i) - CGFloat(count) / 2
                var currentInset: CGFloat = 0
                if multiplier < 0 {
                    currentInset = CGFloat(self.regularInset * (multiplier + 1 / 2))
                } else {
                    currentInset = CGFloat(self.regularInset * ((multiplier + 1) - 1 / 2))
                }
                
                masCenters.append(CGPoint(x: self.center.x + currentInset, y: self.center.y))
            }
            
        } else {
            
            for i in 0..<count {
                
                let multiplier: CGFloat = CGFloat(i) - ((CGFloat(count) - 1) / 2)
                let currentInset: CGFloat = CGFloat(regularInset * multiplier)
                masCenters.append(CGPoint(x: self.center.x + currentInset, y: self.center.y))
                
            }
            
        }
        
        return  masCenters
    }
    
    private func drawCircle(centerPoint: CGPoint) {
        
        let context = UIGraphicsGetCurrentContext()!
        
        let rectOfCircle = CGRect(x: centerPoint.x - radiusOfCircle - self.frame.minX,
                                  y: centerPoint.y - radiusOfCircle - self.frame.minY,
                                  width: radiusOfCircle * 2,
                                  height: radiusOfCircle * 2)
        print(rectOfCircle)
        let bezierPath = UIBezierPath(ovalIn: rectOfCircle)
        context.saveGState()
        context.setShadow(offset: shadowOffset, blur: shadowRadius, color: shadowColor.cgColor)
        mainColor.setFill()
        bezierPath.fill()
        context.restoreGState()
        
        drawArcs(centerPoint: centerPoint)
    }
    
    private func drawArcs(centerPoint: CGPoint) {
        
        let center = CGPoint(x: centerPoint.x - self.frame.minX, y: centerPoint.y - self.frame.minY)
        let startAngles: [CGFloat] = [.pi / 12,
                                      .pi / 12 + .pi / 2,
                                      .pi / 12 + .pi,
                                      .pi / 12 + 3 * .pi / 2]
        let endAngles: [CGFloat] = [5 * .pi / 12,
                                    5 * .pi / 12 + .pi / 2,
                                    5 * .pi / 12 + .pi,
                                    5 * .pi / 12 + 3 * .pi / 2]
        
        //Drawing Arcs
        for i in 0..<startAngles.count {
            let arcsPath = UIBezierPath(arcCenter: center,
                                        radius: radiusOfCircle * 0.75 / 2,
                                        startAngle: startAngles[i],
                                        endAngle: endAngles[i],
                                        clockwise: true)
            arcsPath.lineWidth = radiusOfCircle * 0.75
            additionalColor.setStroke()
            arcsPath.stroke()
        }
    }
    
    
}
