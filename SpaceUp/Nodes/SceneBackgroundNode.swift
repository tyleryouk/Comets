

import SpriteKit

class SceneBackgroundNode: SKNode {
  // MARK: - Vars
  weak var world: WorldNode?
  
  // MARK: - Immutable vars
  //private let galaxyBackground = EndlessBackgroundNode(imageNames: [TextureFileName.Background])
  private let galaxyStars = EndlessBackgroundNode(imageNames: [TextureFileName.BackgroundStars2])
  /*private let galaxyLargePlanets = EndlessBackgroundNode(imageNames: [
    TextureFileName.BackgroundLargePlanets,
    TextureFileName.BackgroundLargePlanets + "2"
  ])
  private let galaxySmallPlanets = EndlessBackgroundNode(imageNames: [
    TextureFileName.BackgroundSmallPlanets,
    TextureFileName.BackgroundSmallPlanets + "2"
  ])*/
  private var positionOffset = CGPointZero
  
  // MARK: - Init
  override init() {
    super.init()
    
    //addChild(galaxyBackground)
    addChild(galaxyStars)
    //addChild(galaxySmallPlanets)
    //addChild(galaxyLargePlanets)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Update
  func move(position: CGPoint) {
    //galaxyBackground.move(position + positionOffset, multiplier: 0.4)
    galaxyStars.move(position + positionOffset, multiplier: 0.5)
   // galaxySmallPlanets.move(position + positionOffset, multiplier: 0.6)
    //galaxyLargePlanets.move(position + positionOffset, multiplier: 0.7)
  }
  
  // MARK: - Offset
  func updateOffsetByMotion(motion: FilteredMotion) {
    let maxDiff: CGFloat = 150
    let dx: CGFloat = 0 // maxDiff * CGFloat(motion.acceleration.x)
    let dy: CGFloat = maxDiff * CGFloat(motion.acceleration.y)
    
    positionOffset = CGPoint(x: dx, y: dy)
  }
}
