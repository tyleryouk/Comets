
import Foundation

func isSoundEnabled() -> Bool {
  let userDefaults = NSUserDefaults.standardUserDefaults()

  return userDefaults.boolForKey(KeyForUserDefaults.SoundDisabled) != true
}

func isMusicEnabled() -> Bool {
  let userDefaults = NSUserDefaults.standardUserDefaults()

  return userDefaults.boolForKey(KeyForUserDefaults.MusicDisabled) != true
}

func isAdsEnabled() -> Bool {
  let userDefaults = NSUserDefaults.standardUserDefaults()
  
  return userDefaults.boolForKey(ProductIdentifier.RemoveAds) != true
}
