
import SpriteKit

func pointBetweenPoint(pointA: CGPoint, andPoint pointB: CGPoint) -> CGPoint {
  return CGPoint(x: (pointA.x + pointB.x) / 2, y: (pointA.y + pointB.y) / 2)
}

func lineFromPoint(fromPoint: CGPoint, toPoint: CGPoint, pointAtX: CGFloat) -> CGPoint {
  let slope = (toPoint.y - fromPoint.y) / (toPoint.x - fromPoint.x)
  let yIntercept = fromPoint.y - slope * fromPoint.x
  let y = slope * pointAtX + yIntercept
  
  return CGPoint(x: pointAtX, y: y)
}

func lineFromPoint(fromPoint: CGPoint, toPoint: CGPoint, pointAtY: CGFloat) -> CGPoint {
  let slope = (toPoint.y - fromPoint.y) / (toPoint.x - fromPoint.x)
  let yIntercept = fromPoint.y - slope * fromPoint.x
  let x = (pointAtY - yIntercept) / slope
  
  return CGPoint(x: x, y: pointAtY)
}
