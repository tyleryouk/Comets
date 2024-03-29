
import SpriteKit
import AVFoundation

extension SKAction {
  class func moveTo(location: CGPoint, duration sec: NSTimeInterval, timingMode: SKActionTimingMode) -> SKAction {
    let action = moveTo(location, duration: sec)

    action.timingMode = timingMode
  
    return action
  }
  
  class func moveByX(deltaX: CGFloat, y deltaY: CGFloat, duration sec: NSTimeInterval, timingMode: SKActionTimingMode) -> SKAction {
    let action = moveByX(deltaX, y: deltaY, duration: sec)
    
    action.timingMode = timingMode
    
    return action
  }
  
  class func playSoundFileNamed(soundFile: String, volume: Float, waitForCompletion wait: Bool) -> SKAction {
    let url = NSBundle.mainBundle().URLForResource(soundFile, withExtension: nil)
    let audioPlayer = try! AVAudioPlayer(contentsOfURL: url!)

    audioPlayer.volume = volume
    audioPlayer.prepareToPlay()
    
    return SKAction.sequence([
      SKAction.runBlock {
        audioPlayer.play()
      },
      SKAction.waitForDuration(audioPlayer.duration)
    ])
  }
}
