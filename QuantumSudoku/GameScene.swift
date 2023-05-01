import GameplayKit
import SpriteKit
import UIKit

class GameScene: SKScene {
    
    let textColor = Palette.textSymbolNormal
    let titleLowColor = Palette.gradient1[0]
    let titleHighColor = Palette.gradient1[1]
    let selectedColor = Palette.backgroundPrimary
    let selectedTextColor = Palette.textSymbolNormal
    let secondarySelectedColor = Palette.backgroundSecondary
    let secondaryTextColor = Palette.textSymbolBold
    
    weak var switchDelegate: QSceneDelegate?
    
    var homeButton: ButtonNode? = nil
    var settingsButton: ButtonNode? = nil
    var gridFrame: SKNode? = nil
    var actionButtons: [ButtonNode]? = []
    var numberButtons: [ButtonNode]? = []
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        
        // Code to run when the scene is first loaded into view
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Code to run when the screen is touched
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Code to run on each frame of the game loop
    }
    
    func adjustToFrame(frame: CGRect) {
        //do stuff here
    }
    
    // Add any additional functions or methods here
}
