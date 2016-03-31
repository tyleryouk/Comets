

import SpriteKit

class ModalBackgroundNode: SKShapeNode {
  private let foreground: SKShapeNode

  // MARK: - Init
  init(size: CGSize) {
    let padding: CGFloat = 20

    foreground = SKShapeNode(rectOfSize: CGSize(width: size.width - padding * 2, height: size.height - padding * 2),
                             cornerRadius: 10)

    super.init()
    
    // Path
    path = CGPathCreateWithRoundedRect(CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height), 10, 10, nil)
    fillColor = UIColor.init(hexString: "#cccccc", alpha: 0.3)//#f6f655 /*UIColor(red: 242, green: 242, blue: 243, alpha: 0.3)*/
    strokeColor = UIColor.clearColor()
    
    // Foreground
    foreground.position = CGPoint(x: 0, y: 0)
    foreground.fillColor = UIColor.init(hexString: "#cccccc", alpha: 1)/*UIColor(red: 51, green: 204, blue: 51, alpha: 1)*/
    foreground.strokeColor = UIColor.clearColor()
    foreground.userInteractionEnabled = false
    addChild(foreground)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
