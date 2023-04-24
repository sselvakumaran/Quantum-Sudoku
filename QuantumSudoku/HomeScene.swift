import GameplayKit
import SpriteKit
import UIKit

protocol QSceneDelegate: AnyObject {
    func moveToGameScene(scene: HomeScene, game_code: Int)
}

class HomeScene: SKScene {
    
    // Declare any variables or properties here
    // var titlegradient: CGGradient
    let textColor = UIColor(named: "TextColor")!
    let titleLowColor = UIColor(named: "EntangledPurple")!
    let titleHighColor = UIColor(named: "EntangledGreen")!
    let selectedColor = UIColor(named: "PrimarySelectedBackground")!
    let selectedTextColor = UIColor(named: "PrimarySelectedTextColor")!
    let secondarySelectedColor = UIColor(named: "SecondarySelectedBackground")!
    let secondaryTextColor = UIColor(named: "SecondarySelectedTextColor")!
    
    weak var switchDelegate: QSceneDelegate?
    
    var newGameButton: ButtonNode? = nil
    var resumeGameButton: ButtonNode? = nil
    var gameScene: GameScene? = nil
    
    override func sceneDidLoad() {
        gameScene = GameScene(size: self.size)
        // Set the background color of the SKScene to the dynamic color
        let newGamePlaceholder = self.childNode(withName: "NewGameButton")!
        newGameButton = ButtonNode(buttonRect:newGamePlaceholder.frame,
                                       buttonColor:selectedColor,
                                       buttonLabel:"New Game",
                                       labelColor:selectedTextColor)
        let resumeGamePlaceholder = self.childNode(withName: "ResumeSaveButton")!
        resumeGameButton = ButtonNode(buttonRect:resumeGamePlaceholder.frame,
                                       buttonColor:secondarySelectedColor,
                                       buttonLabel:"Resume Saved",
                                       labelColor:secondaryTextColor)
        removeChildren(in: [newGamePlaceholder, resumeGamePlaceholder])
        addChild(newGameButton!)
        addChild(resumeGameButton!)
        updateColorStyles()
        
    }
    
    override func didMove(to view: SKView) {
        // Code to run when the scene is first loaded into view
        updateColorStyles()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if newGameButton!.contains(location) {
                switchDelegate?.moveToGameScene(scene: self, game_code: 0)
                /* self.view!.presentScene(gameScene!, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 1)) */
            }
            if resumeGameButton!.contains(location) {
                
            }
        }
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
