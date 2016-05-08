
import SpriteKit

private struct KeyForAction {
    static let moveFromPositionAction = "moveFromPositionAction"
    static let rotationAction = "rotationAction"
    static let glowAction = "glowAction"
}

class CometNode: SKSpriteNode {
    // MARK: - Immutable vars
    var sphere: SKSpriteNode
    var glow: SKSpriteNode
    let type: CometType
    
    // MARK: - Vars
    private var sphereHighlight: SphereHighlightNode?
    weak var emitter: CometEmitter?
    var enabled: Bool = true
    var physicsFrame = CGRectZero
    
    private lazy var explodeAnimateAction: SKAction = {
        let texture0: SKTexture
        
        switch self.type {
        case .Slow:
            texture0 = SKTexture(imageNamed: TextureFileName.CrackedLarge)
            
        case .Fast:
            texture0 = SKTexture(imageNamed: TextureFileName.CrackedSmall)
            
        default:
            texture0 = SKTexture(imageNamed: TextureFileName.CrackedMedium)
        }
        
        let textures = [
            texture0,
            SKTexture(imageNamed: TextureFileName.CrackedRed)
            ] + texturesWithName(TextureFileName.Explosion, fromIndex: 1, toIndex: 5)
        
        return SKAction.animateWithTextures(textures, timePerFrame: 1/20)
    }()
    
    // MARK: - Init
    init(type: CometType, isReversed: Bool = false, currentScore: Int) {
        self.type = type
        
        let radius: CGFloat
        switch type {
        case .Slow:
            
            sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            
            if (currentScore > 70 && currentScore <= 150) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge2)
            } else if (currentScore > 150 && currentScore <= 250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge3)
            }  else if (currentScore > 250 && currentScore <= 320) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge4)
            }  else if (currentScore > 320 && currentScore <= 420) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge5)
            }  else if (currentScore > 420 && currentScore <= 525) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge6)
            }  else if (currentScore > 525 && currentScore <= 600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge7)
            }  else if (currentScore > 600 && currentScore <= 700) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge8)
            }  else if (currentScore > 700 && currentScore <= 875) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge9)
            }  else if (currentScore > 875 && currentScore <= 1000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge10)
            }  else if (currentScore > 1000 && currentScore <= 1200) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge11)
            }  else if (currentScore > 1200 && currentScore <= 1250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge12)
            }  else if (currentScore > 1250 && currentScore <= 1300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge13)
            }  else if (currentScore > 1300 && currentScore <= 1500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge14)
            }  else if (currentScore > 1500 && currentScore <= 1600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge15)
            }  else if (currentScore > 1600 && currentScore <= 1640) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge19)
            }  else if (currentScore > 1640 && currentScore <= 1680) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge17)
            }  else if (currentScore > 1680 && currentScore <= 1730) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge18)
            }  else if (currentScore > 1730 && currentScore <= 2000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge16)
            }  else if (currentScore > 2000 && currentScore <= 2300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge23)
            }  else if (currentScore > 2300 && currentScore <= 2500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge21)
            }   else {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            }
            
            sphere.setScale(2.28)
            glow = SKSpriteNode(imageNamed: TextureFileName.CometLargeGlow)
            glow.anchorPoint = CGPoint(x: 0.68, y: 0.38)
            radius = 99
            
        case .Fast:
            sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            
            if (currentScore > 70 && currentScore <= 150) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge2)
            } else if (currentScore > 150 && currentScore <= 250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge3)
            }  else if (currentScore > 250 && currentScore <= 320) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge4)
            }  else if (currentScore > 320 && currentScore <= 420) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge5)
            }  else if (currentScore > 420 && currentScore <= 525) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge6)
            }  else if (currentScore > 525 && currentScore <= 600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge7)
            }  else if (currentScore > 600 && currentScore <= 700) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge8)
            }  else if (currentScore > 700 && currentScore <= 875) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge9)
            }  else if (currentScore > 875 && currentScore <= 1000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge10)
            }  else if (currentScore > 1000 && currentScore <= 1200) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge11)
            }  else if (currentScore > 1200 && currentScore <= 1250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge12)
            }  else if (currentScore > 1250 && currentScore <= 1300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge13)
            }  else if (currentScore > 1300 && currentScore <= 1500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge14)
            }  else if (currentScore > 1500 && currentScore <= 1600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge15)
            }  else if (currentScore > 1600 && currentScore <= 1640) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge19)
            }  else if (currentScore > 1640 && currentScore <= 1680) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge17)
            }  else if (currentScore > 1680 && currentScore <= 1730) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge18)
            }  else if (currentScore > 1730 && currentScore <= 2000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge16)
            }  else if (currentScore > 2000 && currentScore <= 2300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge22)
            }  else if (currentScore > 2300 && currentScore <= 2500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge21)
            }   else {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            }
            
            sphere.setScale(1.0)
            glow = SKSpriteNode(imageNamed: TextureFileName.CometSmallGlow)
            glow.anchorPoint = CGPoint(x: 0.68, y: 0.38)
            radius = 36
            
        case .Award:
            sphere = SKSpriteNode(imageNamed: TextureFileName.CometStar)
            glow = SKSpriteNode(imageNamed: TextureFileName.CometStarGlow)

            radius = 25
            
        default: //Regular
            sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            
            if (currentScore > 70 && currentScore <= 150) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge2)
            } else if (currentScore > 150 && currentScore <= 250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge3)
            }  else if (currentScore > 250 && currentScore <= 320) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge4)
            }  else if (currentScore > 320 && currentScore <= 420) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge5)
            }  else if (currentScore > 420 && currentScore <= 525) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge6)
            }  else if (currentScore > 525 && currentScore <= 600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge7)
            }  else if (currentScore > 600 && currentScore <= 700) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge8)
            }  else if (currentScore > 700 && currentScore <= 875) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge9)
            }  else if (currentScore > 875 && currentScore <= 1000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge10)
            }  else if (currentScore > 1000 && currentScore <= 1200) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge11)
            }  else if (currentScore > 1200 && currentScore <= 1250) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge12)
            }  else if (currentScore > 1250 && currentScore <= 1300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge13)
            }  else if (currentScore > 1300 && currentScore <= 1500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge14)
            }  else if (currentScore > 1500 && currentScore <= 1600) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge15)
            }  else if (currentScore > 1600 && currentScore <= 1640) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge19)
            }  else if (currentScore > 1640 && currentScore <= 1680) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge17)
            }  else if (currentScore > 1680 && currentScore <= 1730) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge18)
            }  else if (currentScore > 1730 && currentScore <= 2000) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge16)
            }  else if (currentScore > 2000 && currentScore <= 2300) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge20)
            }  else if (currentScore > 2300 && currentScore <= 2500) {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge21)
            }   else {
                sphere = SKSpriteNode(imageNamed: TextureFileName.CometLarge)
            }
            
            sphere.setScale(1.67)
            glow = SKSpriteNode(imageNamed: TextureFileName.CometMediumGlow)
            glow.anchorPoint = CGPoint(x: 0.68, y: 0.38)
            radius = 63
        }
    
        glow.setScale(10.0)
        physicsFrame = CGRect(x: radius, y: radius, width: radius * 2, height: radius * 2)
        super.init(texture: nil, color: UIColor.clearColor(), size: sphere.size)
        
        // Sphere
        addChild(sphere)

        
        // Glow
        glow.zPosition = 1
        glow.blendMode = SKBlendMode.Screen
        
        if isReversed {
            glow.xScale = -10
            glow.yScale = -10
        }
        
        addChild(glow)

        
        // Highlight
        if type != .Award {
            sphereHighlight = SphereHighlightNode(radius: radius)
            addChild(sphereHighlight!)
        }
        
        if type == .Award {
            glow.setScale(1.0)
        }
        
        // Physics
        physicsBody = SKPhysicsBody(circleOfRadius: physicsFrame.width / 2)
        physicsBody!.categoryBitMask = type == .Award ? PhysicsCategory.Award : PhysicsCategory.Comet
        physicsBody!.collisionBitMask = 0
        physicsBody!.contactTestBitMask = PhysicsCategory.Player
        physicsBody!.affectedByGravity = false
        physicsBody!.usesPreciseCollisionDetection = true
        
        // Animate
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Movement
    func moveFromPosition(position: CGPoint, toPosition: CGPoint, duration: NSTimeInterval, completion: (() -> Void)?) {
        self.position = position
        
        let action = SKAction.sequence([
            SKAction.moveTo(toPosition, duration: duration, timingMode: .Linear),
            SKAction.runBlock { completion?() }
            ])
        
        runAction(action, withKey: KeyForAction.moveFromPositionAction)
    }
    
    func cancelMovement() {
        removeActionForKey(KeyForAction.moveFromPositionAction)
    }
    
    // MARK: - Removal
    func removeFromEmitter() {
        enabled = false
        emitter?.removeComet(self)
    }
    
    func explodeAndRemove() {
        if let parent = parent {
            // Add explosion effect
            let explosion = SKSpriteNode(imageNamed: TextureFileName.CrackedRed)
            let glow = SKEmitterNode(fileNamed: EffectFileName.ExplosionGlow)!
            
            explosion.position = position
            parent.addChild(explosion)
            
            explosion.runAction(SKAction.sequence([
                explodeAnimateAction,
                SKAction.runBlock { explosion.removeFromParent() }
                ]))
            
            glow.position = position
            glow.alpha = 0.5
            glow.advanceSimulationTime(0.6)
            parent.addChild(glow)
            
            parent.afterDelay(3) { [weak glow] in
                glow?.removeFromParent()
            }
        }
        
        // Remove itself
        removeFromEmitter()
    }
    
    // MARK: - Animate
    func animate() {
        let rotationAction = SKAction.rotateByAngle(CGFloat(M_PI) * 2, duration: 6)
        let glowAction = SKAction.sequence([
            SKAction.fadeAlphaTo(1, duration: 0.6),
            SKAction.fadeAlphaTo(0.5, duration: 0.6)
            ])
        
        glowAction.timingMode = SKActionTimingMode.EaseInEaseOut
        
        sphere.runAction(SKAction.repeatActionForever(rotationAction), withKey: KeyForAction.rotationAction)
        glow.runAction(SKAction.repeatActionForever(glowAction), withKey: KeyForAction.glowAction)
    }
    
    func stopAnimate() {
        sphere.removeActionForKey(KeyForAction.rotationAction)
        glow.removeActionForKey(KeyForAction.glowAction)
    }
}
