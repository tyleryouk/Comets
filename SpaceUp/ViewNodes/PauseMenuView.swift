import SpriteKit

class PauseMenuView: ModalView {
  // MARK: - Immutable var
    let resumeButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonResume)
    let enemiesButton = SpriteButtonNode(imageNamed: TextureFileName.kEnemiesButton)
    let enemiesButtonTouchd = SpriteButtonNode(imageNamed: TextureFileName.kEnemiesButtonToched)
    let quitButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonHome)
    let soundButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonSound)
    let musicButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonMusic)
  
  // MARK: - Init
    init() {
        super.init(size: CGSize(width: 640, height: 740))

        // Enemies
        enemiesButton.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.maxY - 150)
        enemiesButton.setTexture(SKTexture(imageNamed: TextureFileName.kEnemiesButton), forState: .Normal)
        enemiesButton.setTexture(SKTexture(imageNamed: TextureFileName.kEnemiesButtonToched), forState: .Active)
        modal.addChild(enemiesButton)
        
        // Resume
        resumeButton.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.maxY - 400)
        modal.addChild(resumeButton)

        // Sound
        soundButton.position = CGPoint(x: modalBackground.frame.minX + 130, y: modalBackground.frame.minY + 200)
        soundButton.setTexture(SKTexture(imageNamed: TextureFileName.ButtonSoundOff), forState: .Active)
        soundButton.state = isSoundEnabled() ? .Normal : .Active
        modal.addChild(soundButton)

        // Music
        musicButton.position = CGPoint(x: modalBackground.frame.maxX - 130, y: modalBackground.frame.minY + 200)
        musicButton.setTexture(SKTexture(imageNamed: TextureFileName.ButtonMusicOff), forState: .Active)
        musicButton.state = isMusicEnabled() ? .Normal : .Active
        modal.addChild(musicButton)

        // Quit
        quitButton.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.minY + 130)
        modal.addChild(quitButton)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
