

import AVFoundation

/**
 * Audio player that uses AVFoundation to play looping background music and
 * short sound effects. For when using SKActions just isn't good enough.
 */
public class SKTAudio {
  public var backgroundMusicPlayer: AVAudioPlayer?
  public var soundEffectPlayer: AVAudioPlayer?

  public class func sharedInstance() -> SKTAudio {
    return SKTAudioInstance
  }

  public func playBackgroundMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)

    if (url == nil) {
      print("Could not find file: \(filename)")
      return
    }

    do {
      backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: url!)

      if let player = backgroundMusicPlayer {
        player.numberOfLoops = -1
        player.prepareToPlay()
        player.play()
      }
    } catch let error as NSError {
      print("Could not create audio player: \(error)")
    }
  }

  public func pauseBackgroundMusic() {
    if let player = backgroundMusicPlayer {
      if player.playing {
        player.pause()
      }
    }
  }

  public func resumeBackgroundMusic() {
    if let player = backgroundMusicPlayer {
      if !player.playing {
        player.play()
      }
    }
  }

  public func playSoundEffect(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)

    if (url == nil) {
      print("Could not find file: \(filename)")
      return
    }

    do {
      soundEffectPlayer = try AVAudioPlayer(contentsOfURL: url!)

      if let player = soundEffectPlayer {
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
      }
    } catch let error as NSError {
      print("Could not create audio player: \(error)")
    }
  }
}

private let SKTAudioInstance = SKTAudio()
