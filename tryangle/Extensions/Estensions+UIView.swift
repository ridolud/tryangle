//
//  Estensions+UIView.swift
//  tryangle
//
//  Created by Faridho Luedfi on 10/07/19.
//  Copyright © 2019 mc2kel7. All rights reserved.
//

import UIKit

extension UIView {
    
    /*
     // MARK: - Constraint
     //
     // Generate constraint
     */
    func fillSuperview() {
        setAnchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func setCenterY(toView view: UIView!) {
        if let view = view {
            centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func setCenterX(toView view: UIView!) {
        if let view = view {
            centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
    
    func setCenter(toView view: UIView!) {
        setCenterX(toView: view)
        setCenterY(toView: view)
    }
    
    func setAnchorSize(to view: UIView!) {
        if let view = view {
            widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
    }
    
    func setAnchor(
        top: NSLayoutYAxisAnchor?,
        leading: NSLayoutXAxisAnchor?,
        bottom: NSLayoutYAxisAnchor?,
        trailing: NSLayoutXAxisAnchor?,
        padding: UIEdgeInsets = .zero,
        size: CGSize = .zero
        ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
    /*
     // MARK: - Point
     //
     // Generate Point
     */
    
    func grabRandomPoint(from view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0 ) -> CGPoint {
        view.clipsToBounds = true
        // x coordinate between MinX (left) and MaxX (right):
        let minX = view.bounds.minX + offsetX
        let maxX = view.bounds.maxX + offsetX
        let minY = view.bounds.minY + offsetY
        let maxY = view.bounds.maxY + offsetY
        
        let randomX = CGFloat.random(in: minX ... maxY)
        // y coordinate between MinY (top) and MidY (middle):
        let randomY = CGFloat.random(in: minY ... maxX)
        let randomPoint = CGPoint(x: randomX, y: randomY)
        
        return randomPoint
    }
    
    /*
     * Paralax
     */
    
    func applyMotionEffect(_ magnitude: Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        
        self.addMotionEffect(group)
    }
    
    
}
