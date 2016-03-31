
import SpriteKit

func preloadTextures(textures: [SKTexture]?, textureAtlases: [SKTextureAtlas]?, completion: () -> Void) {
  SKTextureAtlas.preloadTextureAtlases(textureAtlases ?? [SKTextureAtlas]()) {
    SKTexture.preloadTextures(textures ?? [SKTexture]()) {
      dispatch_async(dispatch_get_main_queue()) {
        completion()
      }
    }
  }
}
