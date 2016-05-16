

import SpriteKit

class EnemiesView : ModalScrollView {
    // MARK: - Immutable var
    let exitButton = SpriteButtonNode(imageNamed: TextureFileName.kCloseEnemiesViewButton)
    var highestUserScore:Int?
    //var aLabel = ShadowLabelNode(fontNamed: FontName.RegularFont)
    
    let firstImage = SpriteButtonNode(imageNamed: TextureFileName.kHilaryClinton)
    let secondImage = SpriteButtonNode(imageNamed: TextureFileName.kTedCruz)
    let thirdImage = SpriteButtonNode(imageNamed: TextureFileName.kBarackObama)
    let fourthImage = SpriteButtonNode(imageNamed: TextureFileName.kJohnKasich)
    let fifthImage = SpriteButtonNode(imageNamed: TextureFileName.kBernieSanders)
    let sixthImage = SpriteButtonNode(imageNamed: TextureFileName.kEnrique)
    let seventhImage = SpriteButtonNode(imageNamed: TextureFileName.kVladimirPutin)
    let eighthImage = SpriteButtonNode(imageNamed: TextureFileName.kMegyn)
    let ninethImage = SpriteButtonNode(imageNamed: TextureFileName.kgBush)
    let tenthImage = SpriteButtonNode(imageNamed: TextureFileName.kJebBush)
    let eleventhImage = SpriteButtonNode(imageNamed: TextureFileName.kMacMiller)
    let twelvthImage = SpriteButtonNode(imageNamed: TextureFileName.kJohnOliver)
    let thirteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kStephen)
    let fourteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kjohnMccain)
    let fifteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kIvanka)
    let sixteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kUnlocked1x)
    let seventeenthImage = SpriteButtonNode(imageNamed: TextureFileName.kUnlocked2x)
    let eighteenthImage = SpriteButtonNode(imageNamed: TextureFileName.kUnlocked3x)
   
    let spriteImagesArray: Array<SpriteButtonNode>
    
    // MARK: - Init
    init(overallHighestUserScore: Int) {
        
        self.firstImage.setScale(2.1)
        self.secondImage.setScale(2.1)
        self.thirdImage.setScale(2.1)
        self.fourthImage.setScale(2.1)
        self.fifthImage.setScale(2.1)
        self.sixthImage.setScale(2.1)
        self.seventhImage.setScale(2.1)
        self.eighthImage.setScale(2.1)
        self.ninethImage.setScale(2.1)
        self.tenthImage.setScale(2.1)
        self.eleventhImage.setScale(2.1)
        self.twelvthImage.setScale(2.1)
        self.thirteenthImage.setScale(2.1)
        self.fourteenthImage.setScale(2.1)
        self.fifteenthImage.setScale(2.1)
        self.sixteenthImage.setScale(2.1)
        self.seventeenthImage.setScale(2.1)
        self.eighteenthImage.setScale(2.1)
        self.exitButton.setScale(2.0)
        
        spriteImagesArray = [self.firstImage, self.secondImage, self.thirdImage, self.fourthImage, self.fifthImage, self.sixthImage, self.seventhImage, self.eighthImage, self.ninethImage, self.tenthImage, self.eleventhImage, self.twelvthImage, self.thirteenthImage, self.fourteenthImage, self.fifteenthImage, self.sixteenthImage, self.seventeenthImage, self.eighteenthImage]
        self.highestUserScore = overallHighestUserScore
        super.init(size: CGSize(width: 640, height: 1000))
        
        

        //Resume
        exitButton.position = CGPoint(x: modalBackground.frame.maxX, y: modalBackground.frame.maxY)
        modal.addChild(exitButton)
        
        let range: Int = 140
        
        //0 - 0
        let firstImage = self.createNewImageRequiredPoints(30, position: 0, xPosition: -range, yPosition: 300)
        scrollingNode.addChild(firstImage)
        
        
        let firstTextLabel:SKLabelNode = self.createNewLabelWithPoints(30, name: "Hillary Clinton", xPosition: -range, yPosition: 160)
        scrollingNode.addChild(firstTextLabel)
    
        
        //0 - 1
        let secondImage = self.createNewImageRequiredPoints(100, position: 1, xPosition: range, yPosition: 300)
        scrollingNode.addChild(secondImage)
        let secondTextLabel = self.createNewLabelWithPoints(100, name:"Ted Cruz", xPosition: range, yPosition: 160)
        scrollingNode.addChild(secondTextLabel)
        
        //1 - 0
        let thirdImage = self.createNewImageRequiredPoints(150, position: 2, xPosition: -range, yPosition: 25)
        scrollingNode.addChild(thirdImage)
        let thirdTextLabel = self.createNewLabelWithPoints(150, name:"Barack Obama", xPosition: -range, yPosition: -115)
        scrollingNode.addChild(thirdTextLabel)
        
        //1 - 1
        let fourthImage = self.createNewImageRequiredPoints(200, position: 3, xPosition: range, yPosition: 25)
        scrollingNode.addChild(fourthImage)
        let fourthTextLabel = self.createNewLabelWithPoints(200, name:"John Kasich", xPosition: range, yPosition: -115)
        scrollingNode.addChild(fourthTextLabel)
        
        //2 - 0
        let fifthImage = self.createNewImageRequiredPoints(250, position: 4, xPosition: -range, yPosition: -250)
        scrollingNode.addChild(fifthImage)
        let fifthTextLabel = self.createNewLabelWithPoints(250, name:"Bernie Sanders", xPosition: -range, yPosition: -390)
        scrollingNode.addChild(fifthTextLabel)
        
        //2 - 1
        let sixthImage = self.createNewImageRequiredPoints(300, position: 5, xPosition: range, yPosition: -250)
        scrollingNode.addChild(sixthImage)
        
        let sixthTextLabel = self.createNewLabelWithPoints(300, name:"Enrique Pena", xPosition: range, yPosition: -390)
        scrollingNode.addChild(sixthTextLabel)
        
        //3 - 0
        let seventhImage = self.createNewImageRequiredPoints(350, position: 6, xPosition: -range, yPosition: -525)
        scrollingNode.addChild(seventhImage)
        
        let seventhTextLabel = self.createNewLabelWithPoints(350, name:"Vladimir Putin", xPosition: -range, yPosition: -665)
        scrollingNode.addChild(seventhTextLabel)
        
        //3 - 1
        let eightImage = self.createNewImageRequiredPoints(400, position: 7, xPosition: range, yPosition: -525)
        scrollingNode.addChild(eightImage)
        
        let eightTextLabel = self.createNewLabelWithPoints(400, name:"Megyn Kelly", xPosition: range - 10, yPosition: -665)
        scrollingNode.addChild(eightTextLabel)
        
       
        //4
        let ninthImage = self.createNewImageRequiredPoints(450, position: 8, xPosition:-range, yPosition: -800)
        scrollingNode.addChild(ninthImage)
        
        let ninthTextLabel = self.createNewLabelWithPoints(450, name:"George Bush", xPosition: -range, yPosition: -940)
        scrollingNode.addChild(ninthTextLabel)
        
        //4 - 1
        let tenthImage = self.createNewImageRequiredPoints(500, position: 9, xPosition: range, yPosition: -800)
        scrollingNode.addChild(tenthImage)
        
        let tenthTextLabel = self.createNewLabelWithPoints(500, name:"Jeb Bush", xPosition: range, yPosition: -940)
        scrollingNode.addChild(tenthTextLabel)
        
        //5
        let eleventhImage = self.createNewImageRequiredPoints(550, position: 10, xPosition:-range, yPosition: -1075)
        scrollingNode.addChild(eleventhImage)
        
        let eleventhTextLabel = self.createNewLabelWithPoints(550, name:"Mac Miller", xPosition: -range, yPosition: -1215)
        scrollingNode.addChild(eleventhTextLabel)
        
        //5 - 1
        let twelvthImage = self.createNewImageRequiredPoints(600, position: 11, xPosition: range, yPosition: -1075)
        scrollingNode.addChild(twelvthImage)
        
        let twelvthTextLabel = self.createNewLabelWithPoints(600, name:"John Oliver", xPosition: range, yPosition: -1215)
        scrollingNode.addChild(twelvthTextLabel)
        
        //6
        let thirteenthImage = self.createNewImageRequiredPoints(650, position: 12, xPosition:-range, yPosition: -1350)
        scrollingNode.addChild(thirteenthImage)
        
        let thirteenthTextLabel = self.createNewLabelWithPoints(650, name:"Stephen Colbert", xPosition: -range, yPosition: -1490)
        scrollingNode.addChild(thirteenthTextLabel)
        
        //6 - 1
        let fourteenthImage = self.createNewImageRequiredPoints(700, position: 13, xPosition: range, yPosition: -1350)
        scrollingNode.addChild(fourteenthImage)
        
        let fourteenthTextLabel = self.createNewLabelWithPoints(700, name:"John Mccain", xPosition: range, yPosition: -1490)
        scrollingNode.addChild(fourteenthTextLabel)
        
        //7 - 1
        let fifteenthImage = self.createNewImageRequiredPoints(800, position: 14, xPosition:-range, yPosition: -1625)
        scrollingNode.addChild(fifteenthImage)
        
        let fifteenthTextLabel = self.createNewLabelWithPoints(800, name:"Ivanka Trump", xPosition: -range, yPosition: -1765)
        scrollingNode.addChild(fifteenthTextLabel)
        
        //7 - 2
        let sixteenthImage = self.createNewImageRequiredPoints(1000, position: 15, xPosition: range, yPosition: -1625)
        scrollingNode.addChild(sixteenthImage)
        
        //8 - 1
        let seventeenthImage = self.createNewImageRequiredPoints(2000, position: 16, xPosition: -range, yPosition: -1900)
        scrollingNode.addChild(seventeenthImage)
        
        //8 - 2
        let eighteenthImage = self.createNewImageRequiredPoints(3000, position: 17, xPosition: range, yPosition: -1900)
        scrollingNode.addChild(eighteenthImage)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkIfImageShouldAppear(userScore: Int, requiredScore: Int) -> Bool {
        return userScore >= requiredScore
    }
    
    private func createNewLabelWithPoints(pointsRequired: Int, name: String, xPosition:Int, yPosition: Int) -> SKLabelNode {
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
    
    private func createNewImageRequiredPoints(pointsRequired: Int, position: Int, xPosition: Int, yPosition: Int) -> SpriteButtonNode {
        if (self.checkIfImageShouldAppear(self.highestUserScore!, requiredScore: pointsRequired)) {
            let characterImage = spriteImagesArray[position]
            characterImage.position = CGPoint(x: xPosition, y: yPosition)
            return characterImage
        }
        let defaultImage = SpriteButtonNode(imageNamed: TextureFileName.kNoImage)
        defaultImage.position = CGPoint(x: xPosition, y: yPosition)
        defaultImage.setScale(2.1)
        return defaultImage
    }
    
    

    
}


