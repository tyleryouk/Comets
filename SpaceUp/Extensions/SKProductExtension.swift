
import UIKit
import StoreKit

extension SKProduct {
  var formattedPrice: String {
    let numberFormatter = NSNumberFormatter()
    
    numberFormatter.formatterBehavior = .Behavior10_4
    numberFormatter.numberStyle = .CurrencyStyle
    numberFormatter.locale = priceLocale
    
    return numberFormatter.stringFromNumber(price)!
  }
}
