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
    
    var gridFrame: SKNode? = nil
    var miscButtons: [ButtonNode] = []
    var actionButtons: [ButtonNode] = []
    var numberButtons: [ButtonNode] = []
    
    var notesToggle: Bool = false
    var numberSelected: UInt8 = 0
    
    let MISC_BUTTON_NAMES = ["Home, Settings"]
    let ACTION_BUTTON_NAMES = ["Erase, Check, Undo, Notes1, Notes2"]
    let NUMBER_BUTTON_NAMES = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    override func sceneDidLoad() {
        let erasePlaceholder = self.childNode(withName: "ActionButtons")!.childNode(withName: "Erase")!
        let eraseButton = ButtonNode(buttonRect: erasePlaceholder.frame,
                                     buttonColor: Palette.backgroundNormal,
                                     buttonSymbol: "Erase",
                                     symbolColor: secondaryTextColor)
        print(secondaryTextColor)
        addChild(eraseButton)
//        for i in 0..<MISC_BUTTON_NAMES.count {
//            miscButtons[i] = ButtonNode( buttonColor: <#T##UIColor#>, buttonLabel: <#T##String#>, labelColor: <#T##UIColor#>)
//        }
        
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
