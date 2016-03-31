

import Foundation

extension NSError {
  public class func errorWithMessage(message: String, code: Int = 500) -> NSError {
    var userInfo = [NSObject: AnyObject]()
    
    userInfo[NSLocalizedDescriptionKey] = message
    
    return NSError(domain: MainBundleIdentifier, code: code, userInfo: userInfo)
  }
}
