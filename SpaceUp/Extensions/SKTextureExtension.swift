
import SpriteKit

extension SKTexture {
  convenience init(imageNamed name: String, index: Int) {
    self.init(imageNamed: "\(name)\(index)")
  }
}
