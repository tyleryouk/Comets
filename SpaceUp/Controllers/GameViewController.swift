import SpriteKit
import GameKit
import StoreKit
import CoreMotion



// TODO: Refactor, too many responsbilities atm
class GameViewController: UIViewController, GKGameCenterControllerDelegate, GameCenterManagerDelegate, GameSceneDelegate, StartSceneDelegate, SKProductsRequestDelegate, MotionDataSource {
  // MARK: - Immutable vars
      var tableImg : UITableView  =   UITableView()
    var scrollViewEmites: UIScrollView!
    var CloseButton = UIButton()
  let gameCenterManager = GameCenterManager()
  let gameData = GameData.dataFromArchive()
  let motionManager = CMMotionManager()
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0

  // MARK: - Vars
//  private var interstitialAdView: InterstitialAdView?
//  private var numberOfRetriesSinceLastAd: UInt = 0
  private var products: [SKProduct]?
  private var removeAdsProduct: SKProduct?

  // MARK: - Computed vars
  var skView: SKView! {
    return view as? SKView
  }
  
  // MARK: - View
  override func loadView() {
    super.loadView()

    view = SKView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure the view.
    // skView.showsFPS = true
    // skView.showsNodeCount = true
    // skView.showsPhysics = true
    skView.ignoresSiblingOrder = true
    
    // Present scene
   // preloadAndPresentStartScene()
    presentStartScene()
    
    
    
    // Authenticate GameCenter in next loop
    dispatch_async(dispatch_get_main_queue()) {
     // LoadingIndicatorView.sharedView.showInView(self.view)
      self.gameCenterManager.authenticateLocalPlayer()
    }
    
    // GameCenter
    gameCenterManager.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    // Motion
    observeMotion()
    
    // Notification
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.addObserver(self, selector:#selector(GameViewController.paymentTransactionDidComplete(_:)) , name: PaymentTransactionDidRestoreNotification, object: nil)
    notificationCenter.addObserver(self, selector:#selector(GameViewController.paymentTransactionDidRestore(_:)) , name: PaymentTransactionDidRestoreNotification, object: nil)
    notificationCenter.addObserver(self, selector:#selector(GameViewController.paymentTransactionDidFail(_:)) , name: PaymentTransactionDidRestoreNotification, object: nil)
    notificationCenter.addObserver(self, selector:#selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
  }
  
  override func viewWillDisappear(animated: Bool) {
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.removeObserver(self)
    
    // Motion
    stopObservingMotion()
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // MARK: - Scene
  func presentStartScene() -> StartScene {
    let scene = StartScene(size: SceneSize)
    scene.scaleMode = .AspectFill
    scene.startSceneDelegate = self
    
    // Present scene
    skView.presentScene(scene)
    skView.paused = false
    scene.appear()
    
    // Background music
    playMusicIfNeeded()
    
    return scene
  }
  
  func presentGameScene() -> GameScene {
    let scene = GameScene(size: SceneSize, gameData: gameData)
    scene.scaleMode = .AspectFill
    scene.gameSceneDelegate = self
    scene.motionDataSource = self
    
    // Present scene
    skView.presentScene(scene)
    skView.paused = false
    
    // Background music
    playMusicIfNeeded()
    
    return scene
  }
  
  func preloadAndPresentStartScene(completion: ((StartScene) -> Void)? = nil) {
    
    autoreleasepool { () -> () in
        let textureAtlases: [SKTextureAtlas] = [
            SKTextureAtlas(named: TextureAtlasFileName.UserInterface)
        ]
       
            
        
        let textures: [SKTexture] = [
        
        
            
            SKTexture(imageNamed: TextureFileName.Background),
            SKTexture(imageNamed: TextureFileName.BackgroundStars),
            SKTexture(imageNamed: TextureFileName.StartLogo)
            
           
            
            
        ]
        
        // Show loading scene
        presentLoadingScene(.Blank)
        
        // Preload textures
        preloadTextures(textures, textureAtlases: textureAtlases) { [weak self] in
            // Present game scene
            if let scene = self?.presentStartScene() {
                // Retain preloaded textures
                scene.textureAtlases = textureAtlases
                scene.textures = textures
                
                completion?(scene)
            }
        }
    }
    
    
  }
  
  func preloadAndPresentGameScene(completion: ((GameScene) -> Void)? = nil) {
    
    autoreleasepool { () -> () in
        let textureAtlases: [SKTextureAtlas] = [
            SKTextureAtlas(named: TextureAtlasFileName.Environment),
            SKTextureAtlas(named: TextureAtlasFileName.Character),
            SKTextureAtlas(named: TextureAtlasFileName.UserInterface)
        ]
        
        let textures: [SKTexture] = [
            SKTexture(imageNamed: TextureFileName.Background),
            SKTexture(imageNamed: TextureFileName.BackgroundSmallPlanets),
            SKTexture(imageNamed: TextureFileName.BackgroundSmallPlanets, index: 2),
            SKTexture(imageNamed: TextureFileName.BackgroundLargePlanets),
            SKTexture(imageNamed: TextureFileName.BackgroundLargePlanets, index: 2),
            SKTexture(imageNamed: TextureFileName.BackgroundStars),
            SKTexture(imageNamed: TextureFileName.PlanetGround)
        ]
        
        // Show loading scene
        presentLoadingScene()
        
        // Preload textures
        preloadTextures(textures, textureAtlases: textureAtlases) { [weak self] in
            // Present game scene
            if let scene = self?.presentGameScene() {
                // Retain preloaded textures
                scene.textureAtlases = textureAtlases
                scene.textures = textures
                
                completion?(scene)
            }
        }

    }
    
   
    }
  
  func presentLoadingScene(type: LoadingSceneType = .Regular) -> LoadingScene {
    let scene = LoadingScene(size: SceneSize, type: type)
    scene.scaleMode = .AspectFill
    
    // Present scene
    skView.presentScene(scene)
    skView.paused = false
    
    return scene
  }
  
  // MARK: - Motion
  func observeMotion() {
    // Motion manager
    if motionManager.accelerometerAvailable && !motionManager.accelerometerActive {
      motionManager.accelerometerUpdateInterval = 1/100
      motionManager.startAccelerometerUpdates()
    }
  }
  
  func stopObservingMotion() {
    motionManager.stopAccelerometerUpdates()
  }
  
  // MARK: - Leaderboard
  func presentLeaderboard() {
    if let leaderboardIdentifier = gameCenterManager.leaderboardIdentifier where gameCenterManager.isAuthenticated {
      presentLeaderboardViewControllerWithIdentifier(leaderboardIdentifier)
    } else {
      let message = "Please log into GameCenter to access the leaderboard"
      let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
      let cancelAlertAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
      let okAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { _ in
        self.gameCenterManager.promptLocalPlayerAuthentication()
      }
      
      alertController.addAction(okAlertAction)
      alertController.addAction(cancelAlertAction)
      
      presentViewController(alertController, animated: true, completion: nil)
    }
  }

  func presentLeaderboardViewControllerWithIdentifier(identifier: String) -> GKGameCenterViewController {
    let leaderboardViewController = GKGameCenterViewController()
    
    leaderboardViewController.gameCenterDelegate = self
    leaderboardViewController.viewState = .Leaderboards
    leaderboardViewController.leaderboardIdentifier = identifier
    
    skView.paused = true

    presentViewController(leaderboardViewController, animated: true, completion: nil)
    
    return leaderboardViewController
  }
  
  // MARK: - IAP
  func presentStoreActionSheet() {
    if let removeAdsProduct = removeAdsProduct {
      let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
      let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)

      let purchaseAction = UIAlertAction(title: "Remove ads for \(removeAdsProduct.formattedPrice)", style: .Default) { _ in
        LoadingIndicatorView.sharedView.showInView(self.view)

        self.purchaseProduct(removeAdsProduct)
      }

      let restoreAction = UIAlertAction(title: "Restore purchase", style: .Default) { _ in
        LoadingIndicatorView.sharedView.showInView(self.view)

        self.restoreProducts()
      }
      
      actionController.addAction(purchaseAction)
      actionController.addAction(restoreAction)
      actionController.addAction(cancelAction)
    
      presentViewController(actionController, animated: true, completion: nil)
    }
  }
  
  func requestProducts() {
    let productIdentifiers = Set([ProductIdentifier.RemoveAds])
    let request = SKProductsRequest(productIdentifiers: productIdentifiers)
    
    request.delegate = self
    request.start()
  }
  
  func purchaseProduct(product: SKProduct) {
    let payment = SKPayment(product: product)
    let paymentQueue = SKPaymentQueue.defaultQueue()
    
    paymentQueue.addPayment(payment)
  }
  
  func restoreProducts() {
    let paymentQueue = SKPaymentQueue.defaultQueue()
    
    paymentQueue.restoreCompletedTransactions()
  }
  
  // MARK: - Sound
  func playMusicIfNeeded() {
    if isMusicEnabled() {
      if SKTAudio.sharedInstance().backgroundMusicPlayer?.playing != true {
        SKTAudio.sharedInstance().playBackgroundMusic(SoundFileName.BackgroundMusic, volume: 0.3)
      }
    } else {
      SKTAudio.sharedInstance().pauseBackgroundMusic()
    }
  }

  func playMusic() {
    SKTAudio.sharedInstance().playBackgroundMusic(SoundFileName.BackgroundMusic)
  }
  
  func stopMusic() {
    SKTAudio.sharedInstance().pauseBackgroundMusic()
  }

  func toggleSoundForScene(scene: SKScene, withButton button: SpriteButtonNode) -> Bool {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if isSoundEnabled() {
      userDefaults.setValue(true, forKey: KeyForUserDefaults.SoundDisabled)
      button.state = .Active
    } else {
      userDefaults.setValue(false, forKey: KeyForUserDefaults.SoundDisabled)
      button.state = .Normal
    }
    
    userDefaults.synchronize()
    
    return isSoundEnabled()
  }
  
  func toggleMusicForScene(scene: SKScene, withButton button: SpriteButtonNode) -> Bool {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if isMusicEnabled() {
      userDefaults.setValue(true, forKey: KeyForUserDefaults.MusicDisabled)
      button.state = .Active
      stopMusic()
    } else {
      userDefaults.setValue(false, forKey: KeyForUserDefaults.MusicDisabled)
      button.state = .Normal
      playMusic()
    }
    
    userDefaults.synchronize()
    
    return isMusicEnabled()
  }
  
  // MARK: - Notification
  func applicationWillResignActive(notification: NSNotification) {
    SKTAudio.sharedInstance().pauseBackgroundMusic()
  }
  
  func applicationDidBecomeActive(notification: NSNotification) {
    SKTAudio.sharedInstance().resumeBackgroundMusic()
  }

  func paymentTransactionDidComplete(notification: NSNotification) {
    restoreViewFromTransaction()
  }
  
  func paymentTransactionDidRestore(notification: NSNotification) {
    restoreViewFromTransaction()
  }
  
  func paymentTransactionDidFail(notification: NSNotification) {
    restoreViewFromTransaction()
  }
  
  private func restoreViewFromTransaction() {
    LoadingIndicatorView.sharedView.dismiss()
    
    skView.paused = false
  }
  
  // MARK: - GKGameCenterControllerDelegate
  func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)

    skView.paused = false
  }
  
  // MARK: - GameCenterManagerDelegate
  func gameCenterManager(manager: GameCenterManager, didProvideViewController viewController: UIViewController) {
    presentViewController(viewController, animated: true, completion: nil)
  }
  
  func gameCenterManager(manager: GameCenterManager, didAuthenticateLocalPlayer: Bool) {
    if didAuthenticateLocalPlayer {
      gameCenterManager.loadDefaultLeaderboardIdentifier()
    }
  }
  
  func gameCenterManager(manager: GameCenterManager, didReceiveError error: NSError) {
    // Cancelled by user
    LoadingIndicatorView.sharedView.dismiss()
  }
  
  func gameCenterManager(manager: GameCenterManager, didLoadDefaultLeaderboardIdentifier identifier: String) {
    gameCenterManager.loadLeaderboardScore()
  }
  
  func gameCenterManager(manager: GameCenterManager, didLoadLocalPlayerScore score: GKScore) {
    gameData.updateTopScoreWithGKScore(score)
    
    LoadingIndicatorView.sharedView.dismiss()
  }
  
  // MARK: - GameSceneDelegate
  func gameSceneDidEnd(gameScene: GameScene) {
    if !gameScene.godMode && gameCenterManager.isAuthenticated {
      let scoreValue = Int64(round(gameScene.gameData.score))

      gameCenterManager.reportScoreValue(scoreValue)
    }
  }
  
  func gameSceneDidStart(gameScene: GameScene) {
    //prepareInterstitialAd() //JUST DELETED
  }
  
  func gameSceneDidRequestRetry(gameScene: GameScene) {
    // Show ad or restart game
//    if numberOfRetriesSinceLastAd < MinimumNumberOfRetriesBeforePresentingAd {
//      numberOfRetriesSinceLastAd = 0
    
      gameScene.startGame()
//    } else {
//      numberOfRetriesSinceLastAd = 0
//    }
  }
  
  func gameSceneDidRequestQuit(gameScene: GameScene) {
    presentStartScene()
  }
  
  func gameSceneDidRequestLeaderboard(gameScene: GameScene) {
    presentLeaderboard()
  }
  
  func gameSceneDidRequestToggleSound(gameScene: GameScene, withButton button: SpriteButtonNode) {
    toggleSoundForScene(gameScene, withButton: button)
  }

  func gameSceneDidRequestToggleMusic(gameScene: GameScene, withButton button: SpriteButtonNode) {
    toggleMusicForScene(gameScene, withButton: button)
  }
    
    
    
   
    /*func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 10
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableImg.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        
        // Next line: fatal error: unexpectedly found nil while unwrapping an Optional value
        
        
        
         let cell_image: UIImageView = UIImageView(frame: CGRectMake(10, 5, 80, 80))
         cell_image.tag = 111
         cell.contentView.addSubview(cell_image)
         cell_image.image = UIImage(named: "TedCruz")
        
        let cell_image2: UIImageView = UIImageView(frame: CGRectMake(tableImg.frame.size.width - 90, 5, 80, 80))
        cell_image2.tag = 222
        cell.contentView.addSubview(cell_image2)
        cell_image2.image = UIImage(named: "HilaryClinton")
        
        let label1: UILabel = UILabel(frame: CGRectMake(5, cell_image.frame.origin.x + cell_image.frame.height , 70, 20))
        label1.textColor = UIColor.whiteColor()
        label1.textAlignment = NSTextAlignment.Center
        label1.font =  UIFont.systemFontOfSize(12)
        label1.tag = 125
        label1.text = "TedCruz"
        cell.addSubview(label1)
        
        
        let label2: UILabel = UILabel(frame: CGRectMake(100 ,150, 90, 20))
        label2.textColor = UIColor.whiteColor()
        label2.textAlignment = NSTextAlignment.Center
        label2.font =  UIFont.systemFontOfSize(12)
        label2.tag = 112
        label2.text = "Hilary Clinton"
        cell.addSubview(label2)
        
        
        
        
        cell.backgroundColor = UIColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1.0)
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
        
        
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        // performSegueWithIdentifier("PlaceInfo", sender: nil)
    }*/
    
   func closetable(sender: UIButton!) {
    scrollViewEmites.hidden = true
    scrollViewEmites.removeFromSuperview()
    CloseButton.hidden = true
    CloseButton.removeFromSuperview()
    }
    
    func gameSceneDidRequestToShowEnemiesView(gameScene: GameScene, withHighestUserScore: Int) {
       
        
        scrollViewEmites = UIScrollView(frame: CGRectMake(30, 150, self.view.frame.size.width - 60, 370))
        scrollViewEmites.backgroundColor = UIColor.clearColor()
        var y: CGFloat = CGFloat(("5" as NSString).doubleValue)
        
       var galleryView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width - 60, 370))
        
        for i in 0...5 {
            let cell_image: UIImageView = UIImageView(frame: CGRectMake(10, y, 80, 80))
            cell_image.tag = 111
            galleryView.addSubview(cell_image)
            
            
            let cell_image2: UIImageView = UIImageView(frame: CGRectMake(galleryView.frame.size.width - 90, y, 80, 80))
            cell_image2.tag = 222
            galleryView.addSubview(cell_image2)
            
            
            let label1: UILabel = UILabel(frame: CGRectMake(5, cell_image.frame.origin.y + cell_image.frame.height , 100, 20))
            label1.textColor = UIColor.whiteColor()
            label1.textAlignment = NSTextAlignment.Center
            label1.font =  UIFont.boldSystemFontOfSize(13)
            label1.tag = 125
            
            galleryView.addSubview(label1)
            
            
            let label2: UILabel = UILabel(frame: CGRectMake(cell_image2.frame.origin.x - 20 ,cell_image.frame.origin.y + cell_image.frame.height, 100, 20))
            label2.textColor = UIColor.whiteColor()
            label2.textAlignment = NSTextAlignment.Center
            label2.font =  UIFont.boldSystemFontOfSize(13)
            label2.tag = 112
           
            galleryView.addSubview(label2)
            
            if(i==0){
             label2.text = "Hilary Clinton"
            label1.text = "TedCruz"
            cell_image2.image = UIImage(named: "HilaryClinton")
            cell_image.image = UIImage(named: "TedCruz")
            }
            else if(i == 1)
            {
                label1.text = "Unlock at 70"
                label2.text = "Unlock at 80"
                
                cell_image2.image = UIImage(named: "officialquestion")
                cell_image.image = UIImage(named: "officialquestion")
            }
            else if(i == 2)
            {
                label1.text = "Unlock at 100"
                label2.text = "Unlock at 115"
                cell_image.image = UIImage(named: "officialquestion")
                cell_image2.image = UIImage(named: "officialquestion")
            }
            else if(i == 3)
            {
                label1.text = "Unlock at 145"
                label2.text = "Unlock at 160"
                cell_image.image = UIImage(named: "officialquestion")
                cell_image2.image = UIImage(named: "officialquestion")
            }
            else if(i == 4)
            {
                label1.text = "Unlock at 130"
                label2.text = ""
                cell_image.image = UIImage(named: "officialquestion")
                
            }
            
            y = y + 110

        }
        galleryView.backgroundColor = UIColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1.0)
        galleryView.frame = CGRectMake(0, 0, self.view.frame.size.width - 60, y)
        scrollViewEmites.addSubview(galleryView)
        
        scrollViewEmites.contentSize = galleryView.bounds.size
       
    
        self.view.addSubview(scrollViewEmites)
        /*self.tableImg.frame = CGRectMake(30, 150, self.view.frame.size.width - 60, 370)
        self.tableImg.delegate      =   self
        self.tableImg.dataSource    =   self
        self.tableImg.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableImg)
        self.tableImg.reloadData()*/
        
        CloseButton = UIButton()
        CloseButton.frame = CGRectMake(self.view.frame.size.width - 50, 132 , 40, 40)
        CloseButton.backgroundColor = UIColor.clearColor()
        CloseButton.setImage(UIImage(named: "closeEnemiesViewButton.png"), forState: UIControlState.Normal)
        CloseButton.addTarget(self, action: #selector(GameViewController.closetable(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(CloseButton)

        
       /*var anchorPoint : CGPoint = CGPoint(x: 0.5, y: 0.5)
        
        
         
         
         
        
        
        let smallerRect = CGRectMake(400, 24, 600, 720)
        let navRect = CGRectMake(0, 0, 600, 720)
        
        
        
       var smallerView : ScrollNewViewController = ScrollNewViewController()
       smallerView.view.frame = smallerRect
       self.view.insertSubview(smallerView.view, atIndex: 1000)*/
        
        /*tableImg.delegate = self;
        tableImg.delegate = self;
        
        view.addSubview(tableImg)*/
        
        
        /*gameScene.view?.paused = false
        gameScene.pauseMenu?.removeFromParent()
        gameScene.enemiesView = gameScene.presentEnemiesGameView(withHighestUserScore)
        
        afterDelay(0.05) { [weak gameScene] in
            gameScene!.view?.paused = true
        }*/
    }
  
    func gameSceneDidRequestToDismissEnemiesView(gameScene: GameScene) {
        gameScene.view?.paused = false
        gameScene.enemiesView?.removeFromParent()
        gameScene.pauseMenu = gameScene.presentPauseMenu()
        afterDelay(0.05) { [weak gameScene] in
            gameScene!.view?.paused = true
        }

    }
    
    
    
    
  // MARK: - MotionDataSource
  func accelerometerDataForScene(scene: SKScene) -> CMAccelerometerData? {
    return motionManager.accelerometerData
  }
  
  // MARK: - StartSceneDelegate
  func startSceneDidRequestStart(startScene: StartScene) {
    preloadAndPresentGameScene()
  }

  func startSceneDidRequestLeaderboard(startScene: StartScene) {
    presentLeaderboard()
  }
  
  func startSceneDidRequestStore(stareScene: StartScene) {
    LoadingIndicatorView.sharedView.showInView(view)

    requestProducts()
  }
  
  func startSceneDidRequestToggleSound(startScene: StartScene, withButton button: SpriteButtonNode) {
    toggleSoundForScene(startScene, withButton: button)
  }

  func startSceneDidRequestToggleMusic(startScene: StartScene, withButton button: SpriteButtonNode) {
    toggleMusicForScene(startScene, withButton: button)
  }
  
  // MARK: - SKProductsRequestDelegate
  func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
    products = response.products
    
    if let products = products {
      for product in products {
        if product.productIdentifier == ProductIdentifier.RemoveAds {
          removeAdsProduct = product
        }
        
        break
      }
    }

    // Hide indicator
    LoadingIndicatorView.sharedView.dismiss()

    // Present products
    presentStoreActionSheet()
  }
    
  override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews();
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.viewController = self;
    }
}

