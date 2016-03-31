

import SpriteKit

class HUDNode: SKNode {
  // MARK: - Immutable var
  let scoreLabel = SKLabelNode(fontNamed: FontName.RegularFont)
  
  // MARK: - Init
  override init() {
    super.init()

    scoreLabel.color = UIColor(hexString: ColorHex.TextColor)
    scoreLabel.colorBlendFactor = 1
    scoreLabel.horizontalAlignmentMode = .Center
    scoreLabel.position = CGPoint(x: 0, y: -150)
    scoreLabel.fontSize = 80
    addChild(scoreLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Data
  func updateWithGameData(gameData: GameData) {
    let numberFormatter = NSNumberFormatter()
    
    // Configure number formatter
    numberFormatter.maximumFractionDigits = 0
    numberFormatter.roundingMode = .RoundHalfUp
    
    // Update text
    scoreLabel.text = numberFormatter.stringFromNumber(gameData.score) ?? "0"
  }
}
