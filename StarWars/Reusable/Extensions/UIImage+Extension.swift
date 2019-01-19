//
//  UIImage+Extension.swift
//  StarWars
//
//  Created by UreyMt on 1/20/19.
//  Copyright © 2019 Urey Mt. All rights reserved.
//

import UIKit
import QuartzCore
import Accelerate
import Photos

public extension UIImage {
    public convenience init?(named name: String) {
        self.init(named: name, in: nil, compatibleWith: nil)
    }
    public class func imageFromColor(_ color: UIColor?) -> UIImage? {
        var image: UIImage?
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            if let color = color {
                color.setFill()
            } else {
                UIColor.white.setFill()
            }
            context.fill(rect)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image
    }
    
    //Mark: +
    public func imageRotatedByDegrees(_ degrees: CGFloat) -> UIImage {
        var newImage: UIImage?
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let t: CGAffineTransform = CGAffineTransform(rotationAngle: radians(degrees))
        rotatedViewBox.transform = t
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, 1.0) //self.scale removed for memory usage
        if let bitmap: CGContext = UIGraphicsGetCurrentContext() {
            // Move the origin to the middle of the image so we will rotate and scale around the center.
            bitmap.translateBy(x: rotatedSize.width/2, y: rotatedSize.height/2)
            
            //   // Rotate the image context
            bitmap.rotate(by: radians(degrees))
            
            // Now, draw the rotated/scaled image into the context
            bitmap.scaleBy(x: 1.0, y: -1.0)
            if let cgImage = self.cgImage {
                bitmap.draw(cgImage, in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
                newImage = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
        }
        return (newImage != nil) ? newImage! : self
    }
    public func imageWithColor(_ color1: UIColor) -> UIImage {
        var newImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1.0) //self.scale removed for memory usage
        color1.setFill()
        
        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.setBlendMode(CGBlendMode.normal)
            
            let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
            if let cgImage = self.cgImage {
                context.clip(to: rect, mask: cgImage)
                context.fill(rect)
                newImage = UIGraphicsGetImageFromCurrentImageContext()
            }
            UIGraphicsEndImageContext()
        }
        return (newImage != nil) ? newImage! : self
    }
}
