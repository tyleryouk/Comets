import SpriteKit

@objc protocol StartSceneDelegate {
  optional func startSceneDidRequestStart(startScene: StartScene)
  optional func startSceneDidRequestLeaderboard(startScene: StartScene)
  //optional func startSceneDidRequestStore(stareScene: StartScene)
  optional func startSceneDidRequestToggleSound(startScene: StartScene, withButton button: SpriteButtonNode)
  optional func startSceneDidRequestToggleMusic(startScene: StartScene, withButton button: SpriteButtonNode)
}
