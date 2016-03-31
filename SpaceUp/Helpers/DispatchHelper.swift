
import SpriteKit

func afterDelay(delay: NSTimeInterval, queue: dispatch_queue_t = dispatch_get_main_queue(), block: dispatch_block_t) {
  let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
  
  dispatch_after(time, queue, block)
}
