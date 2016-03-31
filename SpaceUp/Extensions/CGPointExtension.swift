import SpriteKit

public extension CGPoint {
  func isFarFromPoint(point: CGPoint, minimumDistance: CGFloat = 0) -> Bool {
    return self.distanceTo(point) >= minimumDistance
  }
}
