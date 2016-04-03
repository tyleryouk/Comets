

import SpriteKit

private struct KeyForAction {
    static let appearAction = "appearAction"
    static let disappearAction = "disappearAction"
    static let upDownAction = "upDownAction"
}

class TapTipNode2: SKNode {
    let hand = SKSpriteNode(imageNamed: TextureFileName.TapTip2)
    let textLabel = ShadowLabelNode(fontNamed: FontName.RegularFont)
    let textLabel2 = ShadowLabelNode(fontNamed: FontName.RegularFont)
    
    private lazy var upDownRepeatAction: SKAction = {
        let upDownAction = SKAction.sequence([
            SKAction.moveByX(0, y: 30, duration: 0.5, timingMode: .EaseInEaseOut),
            SKAction.moveByX(0, y: -30, duration: 0.5, timingMode: .EaseInEaseOut),
            ])
        
        return SKAction.repeatActionForever(upDownAction)
    }()
    
    // MARK: - Init
    override init() {
        super.init()
        
        hand.anchorPoint = CGPoint(x: 0.5, y: 0)
        addChild(hand)
        
        textLabel.position = CGPoint(x: 0, y: 75)
        textLabel.text = "Press and"
        
        textLabel2.position = CGPoint(x: 0, y: 50)
        textLabel2.text = "hold"
        
        addChild(textLabel)
        addChild(textLabel2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appear
    func appearWithDuration(duration: NSTimeInterval) {
        if hasActionForKey(KeyForAction.appearAction) {
            return
        }
        
        let fadeInAction = SKAction.fadeInWithDuration(duration)
        
        fadeInAction.timingMode = .EaseOut
        
        // Run
        runAction(fadeInAction, withKey: KeyForAction.appearAction)
        hand.runAction(upDownRepeatAction, withKey: KeyForAction.upDownAction)
    }
    
    func removeWithDuration(duration: NSTimeInterval, completion: (() -> Void)? = nil) {
        if hasActionForKey(KeyForAction.disappearAction) {
            return
        }
        
        let fadeOutAction = SKAction.fadeOutWithDuration(duration)
        let removeAction = SKAction.runBlock { [weak self] in
            self?.removeFromParentIfNeeded()
        }
        
        fadeOutAction.timingMode = .EaseOut
        
        // Run
        runAction(SKAction.sequence([
            fadeOutAction,
            removeAction,
            SKAction.runBlock {
                self.removeActionForKey(KeyForAction.upDownAction)
                completion?()
            }
            ]), withKey: KeyForAction.disappearAction)
    }
}
