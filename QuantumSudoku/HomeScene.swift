import GameplayKit
import SpriteKit
import UIKit

class HomeScene: SKScene {
    
    // Declare any variables or properties here
    var titlegradient: CGGradient
    
    override func sceneDidLoad() {
        // Set the background color of the SKScene to the dynamic color
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
        self.backgroundColor = UIColor(named: "Background")!
        
        (self.childNode(withName: "Title1") as! SKLabelNode).fontColor = UIColor(named: "NumberColor")!
        
        (self.childNode(withName: "Title2") as! SKLabelNode).fontColor = UIColor(named: "NumberColor")!
    }
    // Add any additional functions or methods here
    
}
