

import SpriteKit

enum CometType {
  case Regular
  case Slow
  case Fast
  case Award
  
  static func randomType(levelFactor levelFactor: CGFloat, exceptTypes: [CometType]? = nil) -> CometType {
    var types = [CometType]()
    
    for _ in 0..<5 {
      types << .Regular
    }
    
    for _ in 0..<Int(round(levelFactor * 5)) {
      types << .Fast
      types << .Slow
      types << .Award
    }
    
    if let exceptTypes = exceptTypes {
      types = types.filter { !exceptTypes.contains($0) }
    }
    
    return types.sample() ?? .Regular
  }
}
