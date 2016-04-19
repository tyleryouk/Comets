import SpriteKit

class PauseMenuView: ModalView {
  // MARK: - Immutable var
    let resumeButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonResume)
    let quitButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonHome)
    let soundButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonSound)
    let musicButton = SpriteButtonNode(imageNamed: TextureFileName.ButtonMusic)
  
  // MARK: - Init
    init() {
        super.init(size: CGSize(width: 640, height: 640))
        
        // Resume
        resumeButton.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.maxY - 230)
        modal.addChild(resumeButton)

        // Sound
        soundButton.setScale(2.0)
        soundButton.position = CGPoint(x: modalBackground.frame.minX + 130, y: modalBackground.frame.minY + 200)
        soundButton.setTexture(SKTexture(imageNamed: TextureFileName.ButtonSoundOff), forState: .Active)
        soundButton.state = isSoundEnabled() ? .Normal : .Active
        modal.addChild(soundButton)

        // Music
        musicButton.setScale(2.0)
        musicButton.position = CGPoint(x: modalBackground.frame.maxX - 130, y: modalBackground.frame.minY + 200)
        musicButton.setTexture(SKTexture(imageNamed: TextureFileName.ButtonMusicOff), forState: .Active)
        musicButton.state = isMusicEnabled() ? .Normal : .Active
        modal.addChild(musicButton)

        // Quit
        quitButton.setScale(2.0)
        quitButton.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.minY + 130)
        modal.addChild(quitButton)
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
