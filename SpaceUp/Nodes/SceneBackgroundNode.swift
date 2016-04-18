

import SpriteKit

class SceneBackgroundNode: SKNode {
  // MARK: - Vars
  weak var world: WorldNode?
  
  // MARK: - Immutable vars
  private let galaxyStars = EndlessBackgroundNode(imageNames: [TextureFileName.BackgroundStars2])

  private var positionOffset = CGPointZero
  
  // MARK: - Init
  override init() {
    super.init()
    
    galaxyStars.setScale(2.0)
    addChild(galaxyStars)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Update
  func move(position: CGPoint) {
    galaxyStars.move(position + positionOffset, multiplier: 0.5)

  }
  
  // MARK: - Offset
  func updateOffsetByMotion(motion: FilteredMotion) {
    let maxDiff: CGFloat = 150
    let dx: CGFloat = 0 // maxDiff * CGFloat(motion.acceleration.x)
    let dy: CGFloat = maxDiff * CGFloat(motion.acceleration.y)
    
    positionOffset = CGPoint(x: dx, y: dy)
  }
}
