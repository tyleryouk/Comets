//
//  ModalScrollView.swift
//  TrumpVsEveryone
//
//  Created by Darren Branford on 10/04/2016.
//  Copyright © 2016 Tyler Youk. All rights reserved.
//

import SpriteKit

class ModalScrollView: ModalView, UIGestureRecognizerDelegate {
    let scrollingNode = SKNode()
    var gestureRecognizer: UIPanGestureRecognizer!
    var yOffset: CGFloat = 0
    var maxYPosition: CGFloat = 0
    var minYPosition: CGFloat {
        get {
            let rectSize = modalBackground.frame.size
            let minPosition : CGFloat = (rectSize.height - scrollingNode.calculateAccumulatedFrame().size.height - yOffset - 100)
            
            return -minPosition
        }
    }
    
    //MARK - Overrides
    
    override init(size: CGSize) {
        super.init(size: size)
        
        let baseNode = SKSpriteNode(color: modalBackground.fillColor, size: CGSize(width: size.width - 40, height: size.height - 40))
        let maskNode = baseNode.copy() as! SKSpriteNode
        let cropNode = SKCropNode()
        
        cropNode.maskNode = maskNode
        cropNode.addChild(baseNode)
        baseNode.addChild(scrollingNode)
        
        modalBackground.addChild(cropNode)
        
        yOffset = scrollingNode.calculateAccumulatedFrame().origin.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addChild(node: SKNode) {
        super.addChild(node)
        
        yOffset = scrollingNode.calculateAccumulatedFrame().origin.y
    }
    
    //MARK - Scrolling
    
    func scrollForTranslation(theTranslation: CGPoint) {
        var newPosition = CGPoint(x: scrollingNode.position.x, y: scrollingNode.position.y - theTranslation.y)
        if newPosition.y < maxYPosition {
            newPosition = CGPoint(x: newPosition.x, y: maxYPosition)
        }
        if newPosition.y > minYPosition {
            newPosition = CGPoint(x: newPosition.x, y: minYPosition)
        }
        scrollingNode.position = newPosition
    }
    
    //MARK - Gesture handling
    
    func addGestureRecognizerToView(theView: UIView) {
        if gestureRecognizer == nil {
            gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            gestureRecognizer.delegate = self
            theView.addGestureRecognizer(gestureRecognizer)
        }
        
    }
    
    func removeGestureRecognizerFromView(theView: UIView) {
        if gestureRecognizer != nil {
            theView.removeGestureRecognizer(gestureRecognizer!)
            gestureRecognizer = nil
        }
    }
    
    func handleGesture(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .Changed {
            let translation: CGPoint = recognizer.translationInView(recognizer.view)
            scrollForTranslation(translation)
            recognizer.setTranslation(CGPointZero, inView: recognizer.view)
            
        }
    }
    
    //MARK - UIGestureRecognizerDelegate
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        let touchPoint: CGPoint = touch.locationInNode(scene!)
        if !CGRectContainsPoint(modalBackground.frame, touchPoint) {
            
            return false
        }
        
        return true
    }
}