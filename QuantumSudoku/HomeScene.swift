import GameplayKit
import SpriteKit
import UIKit

class HomeScene: SKScene {
    
    // Declare any variables or properties here
    // var titlegradient: CGGradient
    let textColor = UIColor(named: "NumberColor")!
    let titleLowColor = UIColor(named: "EntangledPurple")!
    let titleHighColor = UIColor(named: "EntangledGreen")!
    let selectedColor = UIColor(named: "SelectedPrimaryBackground")!
    let secondarySelectedColor = UIColor(named: "SelectedSecondaryBackground")!
    
    override func sceneDidLoad() {
        // Set the background color of the SKScene to the dynamic color
        let newGamePlaceholder = self.childNode(withName: "NewGameButton")!
        let newGameButton = ButtonNode(buttonRect:newGamePlaceholder.frame,
                                       buttonColor:selectedColor,
                                       buttonLabel:"New Game",
                                       labelColor:textColor)
        let resumeGamePlaceholder = self.childNode(withName: "ResumeSaveButton")!
        let resumeGameButton = ButtonNode(buttonRect:resumeGamePlaceholder.frame,
                                       buttonColor:secondarySelectedColor,
                                       buttonLabel:"Resume Saved",
                                       labelColor:textColor)
        removeChildren(in: [newGamePlaceholder, resumeGamePlaceholder])
        addChild(newGameButton)
        addChild(resumeGameButton)
        updateColorStyles()
        
    }
    
    override func didMove(to view: SKView) {
        // Code to run when the scene is first loaded into view
        updateColorStyles()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Code to run when the screen is touched
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Code to run on each frame of the game loop
    }
    
    func updateColorStyles() {
        // background color
        self.backgroundColor = UIColor(named: "Background")!
        
        // color gradient for Title1
        /*let labelNode = self.childNode(withName: "Title1") as! SKLabelNode
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = labelNode.frame
        
        labelNode.maskNode = gradientNode
        labelNode.fontColor = .white */
        
        (self.childNode(withName: "Title1") as! SKLabelNode).fontColor = textColor
        
        // title2 default
        (self.childNode(withName: "Title2") as! SKLabelNode).fontColor = textColor
    }
    // Add any additional functions or methods here
    
}
