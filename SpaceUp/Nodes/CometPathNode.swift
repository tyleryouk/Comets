

import SpriteKit

class CometPathNode: SKShapeNode {
  init(fromPosition: CGPoint, toPosition: CGPoint) {
    super.init()
    
    let path = CGPathCreateMutable()
    
    CGPathMoveToPoint(path, nil, fromPosition.x, fromPosition.y)
    CGPathAddLineToPoint(path, nil, toPosition.x, toPosition.y)
    
    self.path = path
    strokeColor = UIColor.redColor()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
