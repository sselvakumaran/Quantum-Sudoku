import GameplayKit
import SpriteKit
import UIKit

class HomeScene: SKScene {
    
    // Declare any variables or properties here
    // var titlegradient: CGGradient
    let backgroundFrame = Palette.backgroundFrame
    let textColor = Palette.textSymbolNormal
    let selectedColor = Palette.textSymbolBold
    let selectedTextColor = Palette.backgroundNormal
    let secondarySelectedColor = Palette.backgroundSecondary
    let secondaryTextColor = Palette.textSymbolNormal
    
    weak var switchDelegate: QSceneDelegate?
    
    var newGameButton: ButtonNode? = nil
    var resumeGameButton: ButtonNode? = nil
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        self.isUserInteractionEnabled = true
        // Set the background color of the SKScene to the dynamic color
        let newGamePlaceholder = self.childNode(withName: "NewGameButton")!
        newGameButton = ButtonNode(buttonRect:newGamePlaceholder.frame,
                                       buttonColor:selectedColor,
                                       buttonLabel:"New Game",
                                       labelColor:selectedTextColor)
        newGameButton!.action = {
            let alertController = UIAlertController(title: "Choose Difficulty", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Easy", style: .default) { _ in
                self.switchDelegate!.moveToGameScene(scene: self, difficulty: -1, 0)
            })
            alertController.addAction(UIAlertAction(title: "Hard", style: .default) { _ in
                self.switchDelegate!.moveToGameScene(scene: self, difficulty: -2, 0)
            })
            alertController.addAction(UIAlertAction(title: "Evil", style: .default) { _ in
                self.switchDelegate!.moveToGameScene(scene: self, difficulty: -3, 0)
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            }
            cancelAction.setValue(Palette.checkValidity[2], forKey: "titleTextColor")
            alertController.addAction(cancelAction)
            self.view?.window?.rootViewController?.present(alertController, animated: true)
        }
        
        let resumeGamePlaceholder = self.childNode(withName: "ResumeSaveButton")!
        resumeGameButton = ButtonNode(buttonRect:resumeGamePlaceholder.frame,
                                       buttonColor:secondarySelectedColor,
                                       buttonLabel:"Resume Saved",
                                       labelColor:secondaryTextColor)
        
        resumeGameButton!.action = {
            self.switchDelegate!.moveToGameScene(scene: self, difficulty: 0, 1)
        }
        
//        let backgroundNode = SKSpriteNode(color: Palette.backgroundFrame, size: CGSize(width:10000, height:10000))
//        backgroundNode.position = CGPoint(x: frame.midX, y: frame.midY)
//        backgroundNode.zPosition = -1
//        addChild(backgroundNode)
        
        removeChildren(in: [newGamePlaceholder, resumeGamePlaceholder])
        addChild(newGameButton!)
        addChild(resumeGameButton!)
        updateColorStyles()
        
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Code to run when the scene is first loaded into view
        updateColorStyles()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Code to run on each frame of the game loop
    }
    
    func adjustToFrame(frame: CGRect) {
        // do stuff here
    }
    
    func updateColorStyles() {
        // background color
        self.backgroundColor = backgroundFrame
        
        
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
