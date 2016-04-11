

import SpriteKit

class EnemiesView : ModalScrollView {
    // MARK: - Immutable var
    let exitButton = SpriteButtonNode(imageNamed: TextureFileName.kCloseEnemiesViewButton)
    var highestUserScore:Int?
    
    let firstImage = SpriteButtonNode(imageNamed: TextureFileName.kTedCruz)
    let secondImage = SpriteButtonNode(imageNamed: TextureFileName.kHilaryClinton)
    let thirdImage = SpriteButtonNode(imageNamed: TextureFileName.kJebBush)
    let fourthImage = SpriteButtonNode(imageNamed: TextureFileName.kMacMiller)
    let fifthImage = SpriteButtonNode(imageNamed: TextureFileName.kBernieSanders)
    let sixthImage = SpriteButtonNode(imageNamed: TextureFileName.kFloRida)
    let seventhImage = SpriteButtonNode(imageNamed: TextureFileName.kBarackObama)
    let eighthImage = SpriteButtonNode(imageNamed: TextureFileName.kVladimirPutin)
    let ninethImage = SpriteButtonNode(imageNamed: TextureFileName.kMarcoRubio)
   
    let spriteImagesArray: Array<SpriteButtonNode>
    
    // MARK: - Init
    init(overallHighestUserScore: Int) {
        spriteImagesArray = [self.firstImage, self.secondImage, self.thirdImage, self.fourthImage, self.fifthImage, self.sixthImage, self.seventhImage, self.eighthImage, ninethImage]
        self.highestUserScore = overallHighestUserScore
        super.init(size: CGSize(width: 640, height: 1000))

        //Resume
        exitButton.position = CGPoint(x: modalBackground.frame.maxX, y: modalBackground.frame.maxY)
        modal.addChild(exitButton)
        
        let range: Int = 160
        
        //0 - 0
        let firstImageToSet = self.createNewImageRequiredPoints(20, position: 0, xPosition: -range, yPosition: 350)
        scrollingNode.addChild(firstImageToSet)
        
        let firstTextLabel:SKLabelNode = self.createNewLabelWithPoints(20, name: "Ted Cruz", xPosition: range, yPosition: 350)
        scrollingNode.addChild(firstTextLabel)
    
        
        //0 - 1
        let secondImageToSet = self.createNewImageRequiredPoints(45, position: 1, xPosition: -range, yPosition: 0)
        scrollingNode.addChild(secondImageToSet)
        let secondTextLabel = self.createNewLabelWithPoints(45, name:"Hilary Clinton", xPosition: range, yPosition: 0)
        scrollingNode.addChild(secondTextLabel)
        
        //1 - 0
        let thirdImage = self.createNewImageRequiredPoints(70, position: 2, xPosition: -range, yPosition:-350)
        scrollingNode.addChild(thirdImage)
        let thirdTextLabel = self.createNewLabelWithPoints(70, name:"Jeb Bush", xPosition: range, yPosition: -350)
        scrollingNode.addChild(thirdTextLabel)
        
        //1 - 1
        let fourthImageToSet = self.createNewImageRequiredPoints(80, position: 3, xPosition: -range, yPosition: -700)
        scrollingNode.addChild(fourthImageToSet)
        let fourthTextLabel = self.createNewLabelWithPoints(80, name:"Mac Miller", xPosition: range, yPosition: -700)
        scrollingNode.addChild(fourthTextLabel)
        
        //2 - 0
        let fifthImage = self.createNewImageRequiredPoints(100, position: 4, xPosition: -range, yPosition: -1050)
        scrollingNode.addChild(fifthImage)
        let fifthTextLabel = self.createNewLabelWithPoints(100, name:"Bernie Sanders", xPosition: range, yPosition: -1050)
        scrollingNode.addChild(fifthTextLabel)
        
        //2 - 1
        let sixthImage = self.createNewImageRequiredPoints(115, position: 5, xPosition: -range, yPosition: -1400)
        scrollingNode.addChild(sixthImage)
        
        let sixthTextLabel = self.createNewLabelWithPoints(115, name:"Flo Rida", xPosition: range, yPosition: -1400)
        scrollingNode.addChild(sixthTextLabel)
        
        //3 - 0
        let seventhImage = self.createNewImageRequiredPoints(145, position: 6, xPosition: -range, yPosition: -1750)
        scrollingNode.addChild(seventhImage)
        
        let seventhTextLabel = self.createNewLabelWithPoints(145, name:"Barack Obama", xPosition: range, yPosition: -1750)
        scrollingNode.addChild(seventhTextLabel)
        
        //3 - 1
        let eightImage = self.createNewImageRequiredPoints(160, position: 7, xPosition: -range, yPosition: -2100)
        scrollingNode.addChild(eightImage)
        
        let eightTextLabel = self.createNewLabelWithPoints(160, name:"Vladirimir Putin", xPosition: range, yPosition: -2100)
        scrollingNode.addChild(eightTextLabel)
        
       
        //4
        let ninthImage = self.createNewImageRequiredPoints(130, position: 8, xPosition:-range, yPosition: -2450)
        scrollingNode.addChild(ninthImage)
        
        let ninthTextLabel = self.createNewLabelWithPoints(130, name:"Marco Rubio", xPosition: range, yPosition: -2450)
        scrollingNode.addChild(ninthTextLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkIfImageShouldAppear(userScore: Int, requiredScore: Int) -> Bool {
        return userScore >= requiredScore
    }
    
    private func createNewLabelWithPoints(pointsRequired: Int, name: String, xPosition:Int, yPosition: Int) -> SKLabelNode {
        var aLabel = SKLabelNode()
        aLabel = SKLabelNode(fontNamed: "Arial")
        if(self.highestUserScore >= pointsRequired) {
            aLabel.text = name
        } else {
            aLabel.text = "Unlock at " + String(pointsRequired)
        }
        aLabel.fontSize = 25
        aLabel.position = CGPoint(x: xPosition, y: yPosition)
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
        return defaultImage
    }
    
    

    
}


