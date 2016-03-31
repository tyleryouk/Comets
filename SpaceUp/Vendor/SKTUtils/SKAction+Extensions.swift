

import SpriteKit

public extension SKAction {
  /**
   * Performs an action after the specified delay.
   */
  public class func afterDelay(delay: NSTimeInterval, performAction action: SKAction) -> SKAction {
    return SKAction.sequence([SKAction.waitForDuration(delay), action])
  }

  /**
   * Performs a block after the specified delay.
   */
  public class func afterDelay(delay: NSTimeInterval, runBlock block: dispatch_block_t) -> SKAction {
    return SKAction.afterDelay(delay, performAction: SKAction.runBlock(block))
  }

  /**
   * Removes the node from its parent after the specified delay.
   */
  public class func removeFromParentAfterDelay(delay: NSTimeInterval) -> SKAction {
    return SKAction.afterDelay(delay, performAction: SKAction.removeFromParent())
  }

  /**
   * Creates an action to perform a parabolic jump.
   */
  public class func jumpToHeight(height: CGFloat, duration: NSTimeInterval, originalPosition: CGPoint) -> SKAction {
    return SKAction.customActionWithDuration(duration) {(node, elapsedTime) in
      let fraction = elapsedTime / CGFloat(duration)
      let yOffset = height * 4 * fraction * (1 - fraction)
      node.position = CGPoint(x: originalPosition.x, y: originalPosition.y + yOffset)
    }
  }
}
