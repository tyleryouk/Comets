

import SpriteKit

class EnemiesView : ModalScrollView {
    // MARK: - Immutable var
    let exitButton = SpriteButtonNode(imageNamed: TextureFileName.kCloseEnemiesViewButton)
    var highestUserScore:Int?
    //var aLabel = ShadowLabelNode(fontNamed: FontName.RegularFont)
    
    let firstImage = SpriteButtonNode(imageNamed: TextureFileName.kTedCruz)
    let secondImage = SpriteButtonNode(imageNamed: TextureFileName.kHilaryClinton)
    let thirdImage = SpriteButtonNode(imageNamed: TextureFileName.kRosie)
    let fourthImage = SpriteButtonNode(imageNamed: TextureFileName.kMegyn)
    let fifthImage = SpriteButtonNode(imageNamed: TextureFileName.kMacMiller)
    let sixthImage = SpriteButtonNode(imageNamed: TextureFileName.kBeckyG)
    let seventhImage = SpriteButtonNode(imageNamed: TextureFileName.kHeidiCruz)
    let eighthImage = SpriteButtonNode(imageNamed: TextureFileName.kSNL)
    let ninethImage = SpriteButtonNode(imageNamed: TextureFileName.kJohnOliver)
    let tenthImage = SpriteButtonNode(imageNamed: TextureFileName.kBernieSanders)
    let eleventhImage = SpriteButtonNode(imageNamed: TextureFileName.kBarackObama)
    let twelvthImage = SpriteButtonNode(imageNamed: TextureFileName.kJebBush)
    let thirteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kJohnKasich)
    let fourteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kNBC)
    let fifteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kFloRida)
   
    let spriteImagesArray: Array<SpriteButtonNode>
    
    // MARK: - Init
    init(overallHighestUserScore: Int) {
        spriteImagesArray = [self.firstImage, self.secondImage, self.thirdImage, self.fourthImage, self.fifthImage, self.sixthImage, self.seventhImage, self.eighthImage, ninethImage]
        self.highestUserScore = overallHighestUserScore
        super.init(size: CGSize(width: 640, height: 1000))

        //Resume
        exitButton.position = CGPoint(x: modalBackground.frame.maxX, y: modalBackground.frame.maxY)
        modal.addChild(exitButton)
        
        let range: Int = 140
        
        //0 - 0
        let firstImageToSet = self.createNewImageRequiredPoints(20, position: 0, xPosition: -range, yPosition: 300)
        scrollingNode.addChild(firstImageToSet)
        
        let firstTextLabel:SKLabelNode = self.createNewLabelWithPoints(20, name: "Ted Cruz", xPosition: -range, yPosition: 160)
        scrollingNode.addChild(firstTextLabel)
    
        
        //0 - 1
        let secondImageToSet = self.createNewImageRequiredPoints(40, position: 1, xPosition: range, yPosition: 300)
        scrollingNode.addChild(secondImageToSet)
        let secondTextLabel = self.createNewLabelWithPoints(40, name:"Hilary Clinton", xPosition: range, yPosition: 160)
        scrollingNode.addChild(secondTextLabel)
        
        //1 - 0
        let thirdImage = self.createNewImageRequiredPoints(55, position: 2, xPosition: -range, yPosition: 25)
        scrollingNode.addChild(thirdImage)
        let thirdTextLabel = self.createNewLabelWithPoints(55, name:"Rosie O'Donnell", xPosition: -range, yPosition: -115)
        scrollingNode.addChild(thirdTextLabel)
        
        //1 - 1
        let fourthImageToSet = self.createNewImageRequiredPoints(110, position: 3, xPosition: range, yPosition: 25)
        scrollingNode.addChild(fourthImageToSet)
        let fourthTextLabel = self.createNewLabelWithPoints(110, name:"Megyn Kelly", xPosition: range, yPosition: -115)
        scrollingNode.addChild(fourthTextLabel)
        
        //2 - 0
        let fifthImage = self.createNewImageRequiredPoints(130, position: 4, xPosition: -range, yPosition: -250)
        scrollingNode.addChild(fifthImage)
        let fifthTextLabel = self.createNewLabelWithPoints(130, name:"Mac Miller", xPosition: -range, yPosition: -390)
        scrollingNode.addChild(fifthTextLabel)
        
        //2 - 1
        let sixthImage = self.createNewImageRequiredPoints(150, position: 5, xPosition: range, yPosition: -250)
        scrollingNode.addChild(sixthImage)
        
        let sixthTextLabel = self.createNewLabelWithPoints(150, name:"Becky G", xPosition: range, yPosition: -390)
        scrollingNode.addChild(sixthTextLabel)
        
        //3 - 0
        let seventhImage = self.createNewImageRequiredPoints(210, position: 6, xPosition: -range, yPosition: -525)
        scrollingNode.addChild(seventhImage)
        
        let seventhTextLabel = self.createNewLabelWithPoints(210, name:"Heidi Cruz", xPosition: -range, yPosition: -665)
        scrollingNode.addChild(seventhTextLabel)
        
        //3 - 1
        let eightImage = self.createNewImageRequiredPoints(230, position: 7, xPosition: range, yPosition: -525)
        scrollingNode.addChild(eightImage)
        
        let eightTextLabel = self.createNewLabelWithPoints(230, name:"Saturday Night Live", xPosition: range, yPosition: -665)
        scrollingNode.addChild(eightTextLabel)
        
       
        //4
        let ninthImage = self.createNewImageRequiredPoints(250, position: 8, xPosition:-range, yPosition: -800)
        scrollingNode.addChild(ninthImage)
        
        let ninthTextLabel = self.createNewLabelWithPoints(250, name:"John Oliver", xPosition: -range, yPosition: -940)
        scrollingNode.addChild(ninthTextLabel)
        
        //4 - 1
        let tenthImage = self.createNewImageRequiredPoints(310, position: 9, xPosition: range, yPosition: -800)
        scrollingNode.addChild(tenthImage)
        
        let tenthTextLabel = self.createNewLabelWithPoints(310, name:"Bernie Sanders", xPosition: range, yPosition: -940)
        scrollingNode.addChild(tenthTextLabel)
        
        //5
        let eleventhImage = self.createNewImageRequiredPoints(335, position: 10, xPosition:-range, yPosition: -1075)
        scrollingNode.addChild(eleventhImage)
        
        let eleventhTextLabel = self.createNewLabelWithPoints(335, name:"Barack Obama", xPosition: -range, yPosition: -1215)
        scrollingNode.addChild(eleventhTextLabel)
        
        //5 - 1
        let twelvthImage = self.createNewImageRequiredPoints(360, position: 11, xPosition: range, yPosition: -1075)
        scrollingNode.addChild(twelvthImage)
        
        let twelvthTextLabel = self.createNewLabelWithPoints(360, name:"Jeb Bush", xPosition: range, yPosition: -1215)
        scrollingNode.addChild(twelvthTextLabel)
        
        //6
        let thirteenthImage = self.createNewImageRequiredPoints(420, position: 12, xPosition:-range, yPosition: -1350)
        scrollingNode.addChild(thirteenthImage)
        
        let thirteenthTextLabel = self.createNewLabelWithPoints(420, name:"John Kasich", xPosition: -range, yPosition: -1490)
        scrollingNode.addChild(thirteenthTextLabel)
        
        //6 - 1
        let fourteenthImage = self.createNewImageRequiredPoints(440, position: 13, xPosition: range, yPosition: -1350)
        scrollingNode.addChild(fourteenthImage)
        
        let fourteenthTextLabel = self.createNewLabelWithPoints(440, name:"NBC", xPosition: range, yPosition: -1490)
        scrollingNode.addChild(fourteenthTextLabel)
        
        //7
        let fifteenthImage = self.createNewImageRequiredPoints(470, position: 14, xPosition:-range, yPosition: -1625)
        scrollingNode.addChild(fifteenthImage)
        
        let fifteenthTextLabel = self.createNewLabelWithPoints(470, name:"Flo Rida", xPosition: -range, yPosition: -1765)
        scrollingNode.addChild(fifteenthTextLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkIfImageShouldAppear(userScore: Int, requiredScore: Int) -> Bool {
        return userScore >= requiredScore
    }
    
    private func createNewLabelWithPoints(pointsRequired: Int, name: String, xPosition:Int, yPosition: Int) -> SKLabelNode {
        /*var aLabel = SKLabelNode()
        aLabel = SKLabelNode(fontNamed: "Arial")
        if(self.highestUserScore >= pointsRequired) {
            aLabel.text = name
        } else {
            aLabel.text = "Unlock at " + String(pointsRequired)
        }
        aLabel.fontSize = 25
        aLabel.position = CGPoint(x: xPosition, y: yPosition)
        return aLabel*/
        let aLabel = ShadowLabelNode(fontNamed: FontName.RegularFont)
        aLabel.fontColor = UIColor(hexString: ColorHex.TextColor)
        aLabel.position = CGPoint(x: xPosition, y: yPosition)
        aLabel.fontSize = 35
        if(self.highestUserScore >= pointsRequired) {
            aLabel.text = name
        } else {
            aLabel.text = "Unlock at " + String(pointsRequired)
        }
        return aLabel
    }
    
    /*let gameOverLabel = ShadowLabelNode(fontNamed: FontName.RegularFont)
    gameOverLabel.fontColor = UIColor(hexString: ColorHex.TextColor)
    gameOverLabel.position = CGPoint(x: modalBackground.frame.midX, y: modalBackground.frame.maxY - 150)
    gameOverLabel.fontSize = 80
    gameOverLabel.text = "GAME OVER"
    modal.addChild(gameOverLabel)*/
    
    private func createNewImageRequiredPoints(pointsRequired: Int, position: Int, xPosition: Int, yPosition: Int) -> SpriteButtonNode {
        if (self.checkIfImageShouldAppear(self.highestUserScore!, requiredScore: pointsRequired)) {
            let characterImage = spriteImagesArray[position]
            characterImage.position = CGPoint(x: xPosition, y: yPosition)
            return characterImage
        }
        let defaultImage = SpriteButtonNode(imageNamed: TextureFileName.kNoImage)
        defaultImage.position = CGPoint(x: xPosition, y: yPosition)
        return defaultImage
    }
    
    

    
}


