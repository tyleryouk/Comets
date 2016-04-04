
import SpriteKit
import CoreMotion
import GoogleMobileAds

class GameScene: SKScene, SKPhysicsContactDelegate, WorldDelegate, ButtonDelegate, GameDataSource {
    // MARK: - Immutable var
    unowned let gameData: GameData
    let world = WorldNode()
    let hud = HUDNode()
    var pauseButton = IconButtonNode(size: CGSize(width: 70, height: 70), text: "\u{f04c}")
    let background = SceneBackgroundNode()
    let bottomBoundary = LineBoundaryNode(length: SceneSize.width, axis: .X)
    let cometPopulator = CometPopulator()
    let filteredMotion = FilteredMotion()
    

    // MARK: - Vars
    var interstitial: GADInterstitial?
    weak var endGameView: EndGameView?
    weak var pauseMenu: PauseMenuView?
    weak var enemiesView : EnemiesView?
    weak var gameSceneDelegate: GameSceneDelegate?
    weak var motionDataSource: MotionDataSource?
    var textures: [SKTexture]?
    var textureAtlases: [SKTextureAtlas]?
    var tip2: TapTipNode2?
    var tip3: TapTipNode3?
    var gameStarted = false
    var godMode = false
    var gameOverCount:Int = 0
    
  // MARK: - Init
  init(size: CGSize, gameData: GameData) {
    self.gameData = gameData
    super.init(size: size)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    func showInformationsWhileDeveloping() {
        self.view?.showsNodeCount = true
        self.view?.showsFPS = true;
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

  // MARK: - View
  override func didMoveToView(view: SKView) {
    backgroundColor = UIColor(hexString: ColorHex.BackgroundColor)
    SetupAdmob() //GOOGLE
    //self.showInformationsWhileDeveloping()
    
    // Physics
    physicsWorld.contactDelegate = self
    physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
    
    // World
    world.delegate = self
    addChild(world)
    
    // Populator
    cometPopulator.world = world
    cometPopulator.dataSource = self
    
    // Backgrounds
    updateMotion()
    addChild(background)
    background.world = world
    // background.updateOffsetByMotion(filteredMotion)
    background.move(world.position)
    
    // Bottom bound
    bottomBoundary.position = CGPoint(x: 0, y: -world.player.frame.height)
    addChild(bottomBoundary)
    
    // HUD
    hud.zPosition = 100
    hud.position = CGPoint(x: screenFrame.midX, y: screenFrame.maxY)
    gameData.updateScoreForPlayer(world.player)
    hud.updateWithGameData(gameData)
    addChild(hud)
    
    // Pause button
    pauseButton.delegate = self
    pauseButton.zPosition = 100
    pauseButton.position = CGPoint(x: screenFrame.maxX, y: screenFrame.maxY) - CGPoint(x: 60, y: 60)
    addChild(pauseButton)

    
    if gameData.shouldShowTip2 {
        tip2 = TapTipNode2()
        tip2!.position = CGPoint(x: screenFrame.midX - 250, y: screenFrame.midY - 370)
        tip2!.zPosition = 3
        tip2!.alpha = 0
        tip2!.appearWithDuration(0.5)
        addChild(tip2!)
        
        gameData.shouldShowTip2 = false
    }

    
    // Notification
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: UIApplicationWillResignActiveNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)), name: UIApplicationDidEnterBackgroundNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillEnterForeground(_:)), name: UIApplicationWillEnterForegroundNotification, object: nil)
    
    // Start Game
    pauseGame(false)
    startGame()
  }
  
  override func willMoveFromView(view: SKView) {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  // MARK: - Scene
  override func update(currentTime: CFTimeInterval) {
    // Motion
    updateMotion()

    // Score
    if world.player.isAlive && gameStarted {
      world.player.updateDistanceTravelled()

      gameData.updateScoreForPlayer(world.player)
      hud.updateWithGameData(gameData)
    }
    
    if world.player.isAlive {
      if world.player.shouldMove {
        world.player.moveUpward()
      } else {
        world.player.brake()
      }
    
    }
  }
  
  // MARK: - Update
  override func didSimulatePhysics() {
    var crawlIncrement: CGFloat = 0
    
    if world.player.state != .Standing {
      crawlIncrement = 1 + MaximumCameraCrawlIncrement * gameData.levelFactor
    }

    // Camera
    world.followPlayer(crawlIncrement)

    background.move(world.position)
    
    // Comet
    if gameStarted && world.player.isAlive {
    
      cometPopulator.update()
    }
  }
  
  // MARK: - Event
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    cometPopulator.currentScore = Int(self.gameData.getUpdatedScore())
    if view?.paused == true {
      return
    }

    if world.player.isAlive {
      if !gameStarted {
        gameStarted = true
      }

      world.player.startMoveUpward()
    }

    
    if let tip2 = tip2 {
        delay(5.0){
        tip2.removeWithDuration(0.5) {
            self.tip2 = nil
        }
        }
    }
    
    if gameData.shouldShowTip3 {
        delay(0.5){
            self.tip3 = TapTipNode3()
            self.tip3!.position = CGPoint(x: self.screenFrame.midX + 250, y: self.screenFrame.midY + 160)
            self.tip3!.zPosition = 3
            self.tip3!.alpha = 0
            self.tip3!.appearWithDuration(0.5)
            self.addChild(self.tip3!)
            
            self.gameData.shouldShowTip3 = false
        }
    }
    
    
    if let tip3 = tip3 {
        delay(4.0){
            tip3.removeWithDuration(0.5) {
                self.tip3 = nil
            }
        }
    }
  }

  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if view?.paused == true {
      return
    }

    if world.player.isAlive {
      world.player.endMoveUpward()
    }
  }
  
  // MARK: - Motion
  func updateMotion() {
    if let acceleration = motionDataSource?.accelerometerDataForScene(self)?.acceleration {
      filteredMotion.updateAcceleration(acceleration)
    }
  }
  
  // MARK: - Views
  func presentPauseMenu() -> PauseMenuView {
    let pauseMenu = PauseMenuView()
    
    pauseMenu.zPosition = 1000
    pauseMenu.resumeButton.delegate = self
    pauseMenu.quitButton.delegate = self
    pauseMenu.soundButton.delegate = self
    pauseMenu.musicButton.delegate = self
    pauseMenu.enemiesButton.delegate = self

    addChild(pauseMenu)
    return pauseMenu
  }
  
  func presentEndGameView(hasNewTopScore: Bool = false) -> EndGameView {
    let endGameView = EndGameView()
    
    endGameView.zPosition = 1000
    endGameView.continueButton.delegate = self
    endGameView.quitButton.delegate = self
    endGameView.leaderboardButton.delegate = self
    endGameView.updateWithGameData(gameData, hasNewTopScore: hasNewTopScore)

    addChild(endGameView)
    
    return endGameView
  }
    
    func presentEnemiesGameView(highestUserScore: Int) -> EnemiesView {
        let enemiesView = EnemiesView(overallHighestUserScore: highestUserScore)
        enemiesView.zPosition = 1000
        enemiesView.exitButton.delegate = self
        addChild(enemiesView)
        return enemiesView
    }
    
  
  // MARK: - Gameflow
  func startGame() {
    if gameStarted || world.player.isAlive {
      return
    }

    // Unpause
    pauseGame(false)
    
    // Comets
    cometPopulator.removeAllEmitters()

    // World
    world.resetPlayerPosition()
    world.player.respawn()
    world.scoreLine.updateWithScore(gameData.topScore, forPlayer: world.player)
    
    // Background
    background.move(world.position)
    
    // Data
    gameData.reset()
    hud.updateWithGameData(gameData)
    
    // Notify
    gameSceneDelegate?.gameSceneDidStart?(self)
  }

  func endGame() {
    let hasNewTopScore = gameData.score > gameData.topScore

    if !godMode {
      gameData.updateTopScore()
      gameData.saveToArchive()
    }
    
    // Delegate
    gameSceneDelegate?.gameSceneDidEnd?(self)
    
    // Kill player
    world.player.kill()
    gameStarted = false

    // End view
    endGameView = presentEndGameView(hasNewTopScore)
    endGameView!.hidden = true

    afterDelay(0.5) { [weak self] in
      self?.endGameView?.hidden = false
      self?.endGameView?.appear()
    }
    
    gameOverCount += 1
    
    print("end game \(gameOverCount)");
    
    if (gameOverCount%2 == 0)
    {
        
        showAdmobInterstitial()
    }
  }
  
  func continueGame() {
    pauseGame(false)

    endGameView?.disappear() {
      self.endGameView?.removeFromParent()
      self.endGameView = nil
      
      // Inform delegate
      self.gameSceneDelegate?.gameSceneDidRequestRetry?(self)
    }
  }
  

  func pauseGame(paused: Bool, presentMenuIfNeeded: Bool = true) {

    if (paused) {
        self.pauseButton.hidden = true
        gameSceneDelegate?.gameSceneDidPause?(self)
        self.pauseMenu = presentPauseMenu()
        self.pauseMenu?.resumeButton.delegate = self
        afterDelay(0.1) { [weak self] in
            self!.view?.paused = true
        }
    } else {
        self.view?.paused = false
        self.pauseButton.hidden = false
        self.pauseMenu?.removeFromParent()
        gameSceneDelegate?.gameSceneDidResume?(self)
    }
    
    
  }
  
  // MARK: - ButtonDelegate
  func touchBeganForButton(button: ButtonNode) {
    if button == pauseButton {
        self.pauseGame(true)
    } else if button == pauseMenu?.resumeButton {
        self.pauseGame(false)
    } else if button == pauseMenu?.quitButton || button == endGameView?.quitButton {
        gameSceneDelegate?.gameSceneDidRequestQuit?(self)
    } else if button == pauseMenu?.musicButton {
        gameSceneDelegate?.gameSceneDidRequestToggleMusic?(self, withButton: pauseMenu!.musicButton)
    } else if button == pauseMenu?.soundButton {
        gameSceneDelegate?.gameSceneDidRequestToggleSound?(self, withButton: pauseMenu!.soundButton)
    } else if button == endGameView?.continueButton {
        continueGame()
    } else if button == endGameView?.leaderboardButton {
        gameSceneDelegate?.gameSceneDidRequestLeaderboard?(self)
    } else if button == pauseMenu?.enemiesButton {
        if (gameData.score > gameData.topScore) {
            gameSceneDelegate?.gameSceneDidRequestToShowEnemiesView?(self, withHighestUserScore: Int(round(gameData.score)))
        } else {
            gameSceneDelegate?.gameSceneDidRequestToShowEnemiesView?(self, withHighestUserScore: Int(round(gameData.topScore)))
        }
    } else if button == enemiesView?.exitButton {
       gameSceneDelegate?.gameSceneDidRequestToDismissEnemiesView?(self)
    }
  }
  
  // MARK: - SKPhysicsContactDelegate
  func didBeginContact(contact: SKPhysicsContact) {
    let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
    switch collision {
    case PhysicsCategory.Player | PhysicsCategory.Boundary:
      if gameStarted && world.player.isAlive {
        endGame()
      }
      
    case PhysicsCategory.Player | PhysicsCategory.Award:
      if let comet = nodeInContact(contact, withCategoryBitMask: PhysicsCategory.Award) as? CometNode {
        if gameStarted && world.player.isAlive && comet.enabled && !world.player.isProtected {
          world.player.isProtected = true

          comet.enabled = false
          comet.emitter?.removeComet(comet)
        }
      }
    
    case PhysicsCategory.Player | PhysicsCategory.Comet:
      if let comet = nodeInContact(contact, withCategoryBitMask: PhysicsCategory.Comet) as? CometNode {
        if gameStarted && world.player.isAlive && comet.enabled {
          if world.player.isProtected {
            world.player.isProtected = false
          } else if !godMode {
            endGame()
          }

          comet.explodeAndRemove()
        }
      }
      
    case PhysicsCategory.Player | PhysicsCategory.Ground:
      world.player.stand()

    default:
      break
    }
  }
  
  func didEndContact(contact: SKPhysicsContact) {
    // let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
  }
  
  // MARK: - NSNotification
  dynamic private func applicationWillResignActive(notification: NSNotification) {
    if world.player.isAlive {
      pauseGame(false)
    }
  }
  
  dynamic private func applicationDidEnterBackground(notification: NSNotification) {
  }
  
  dynamic private func applicationDidBecomeActive(notification: NSNotification) {
    if world.player.isAlive {
      pauseGame(true)
    }
  }
  
  dynamic private func applicationWillEnterForeground(notification: NSNotification) {
  }
    
    //AdMob configration

    func SetupAdmob()  //call only first time
    {
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3608073587678030/6576466709")
        
        let request = GADRequest()
        // Requests test ads on test devices.
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b"]
        interstitial!.loadRequest(request)
    }
    
    func showAdmobInterstitial()  //call this to show fullScreen ads
    {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if (interstitial!.isReady) {
            interstitial!.presentFromRootViewController(appDelegate.viewController)
        }
        
        SetupAdmob()
    }
    

}
