
import SpriteKit

func texturesWithName(name: String, fromIndex: Int, toIndex: Int) -> [SKTexture] {
  return texturesWithName(name, fromIndex: fromIndex, toIndex: toIndex, reversed: false)
}

func texturesWithName(name: String, fromIndex: Int, toIndex: Int, reversed: Bool) -> [SKTexture] {
  var textures = [SKTexture]()
  
  for (_, index) in (fromIndex...toIndex).enumerate() {
    textures << SKTexture(imageNamed: name, index: index)
  }
  
  if reversed {
    for (_, index) in (fromIndex...toIndex).enumerate() {
      textures << SKTexture(imageNamed: name, index: toIndex - index + fromIndex)
    }
  }
  
  return textures
}
