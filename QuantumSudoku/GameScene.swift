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
    
    override func sceneDidLoad() {
        print("hallo")
    }
    
    override func didMove(to view: SKView) {
        print("did move")
        // Code to run when the scene is first loaded into view
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("did touch")
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
