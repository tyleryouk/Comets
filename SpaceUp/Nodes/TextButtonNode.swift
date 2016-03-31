

import SpriteKit

class TextButtonNode: ButtonNode {
  // MARK: - Immutable vars
  let label = SKLabelNode(fontNamed: "HelveticaNeue")

  // MARK: - Init
  init(size: CGSize) {
    super.init(texture: nil, color: UIColor.clearColor(), size: size)
    
    // Fill color
    color = UIColor(white: 0, alpha: 0.2)
    
    // Label
    label.fontSize = 30
    label.color = UIColor.blackColor()
    label.colorBlendFactor = 1
    label.horizontalAlignmentMode = .Center
    label.verticalAlignmentMode = .Center
    addChild(label)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
