import GameplayKit
import SpriteKit
import UIKit
import ClockKit

class GameScene: SKScene {
    
    let textColor = Palette.textSymbolNormal
    let buttonColor = Palette.backgroundNormal
    let selectedColor = Palette.backgroundPrimary
    let selectedTextColor = Palette.textSymbolNormal
    let secondarySelectedColor = Palette.backgroundSecondary
    let secondaryTextColor = Palette.textSymbolBold
    let backgroundFrame = Palette.backgroundFrame
    
    weak var switchDelegate: QSceneDelegate?
    
    var gridFrame: GridNode? = nil
    var miscButtons: [ButtonNode] = []
    var actionButtons: [ButtonNode] = []
    var numberButtons: [ButtonNode] = []
    
    var time: Date = Date()
    
    let MISC_BUTTON_NAMES = ["Home", "Settings"]
    let ACTION_BUTTON_NAMES = ["Notes1", "Undo", "Check", "Erase", "Notes2"]
    let NUMBER_BUTTON_NAMES = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    let MISC_SYMBOL_NAMES = ["arrowshape.turn.up.backward.fill", "gearshape.fill"]
    let ACTION_SYMBOL_NAMES = ["pencil.line", "arrow.uturn.backward", "checkmark.circle.badge.questionmark.fill", "eraser.fill", "pencil.line"]
    
    override func sceneDidLoad() {
        var placeholderNode: SKNode = SKNode()
        self.backgroundColor = backgroundFrame
        
        for i in 0..<MISC_BUTTON_NAMES.count {
            placeholderNode = self.childNode(withName: MISC_BUTTON_NAMES[i])!
            miscButtons.insert(ButtonNode(buttonRect: placeholderNode.frame,
                                        buttonColor: Palette.backgroundNormal,
                                        buttonSymbol: MISC_SYMBOL_NAMES[i],
                                        symbolColor: secondaryTextColor), at: i);
            removeChildren(in: [placeholderNode])
            addChild(miscButtons[i])
        }
        var parentPlaceholder = self.childNode(withName: "ActionButtons")!
        for i in 0..<ACTION_BUTTON_NAMES.count {
            placeholderNode = parentPlaceholder.childNode(withName: ACTION_BUTTON_NAMES[i])!
            actionButtons.insert(ButtonNode(buttonRect: placeholderNode.frame,
                                        buttonColor: Palette.backgroundNormal,
                                        buttonSymbol: ACTION_SYMBOL_NAMES[i],
                                        symbolColor: secondaryTextColor), at: i);
            parentPlaceholder.removeChildren(in: [placeholderNode])
            addChild(actionButtons[i])
        }
        
        parentPlaceholder = self.childNode(withName: "NumberButtons")!
        for i in 0..<NUMBER_BUTTON_NAMES.count {
            placeholderNode = parentPlaceholder.childNode(withName: NUMBER_BUTTON_NAMES[i])!
            numberButtons.insert(ButtonNode(buttonRect: placeholderNode.frame,
                                            buttonColor: Palette.backgroundNormal,
                                            number: i + 1,
                                            labelColor: secondaryTextColor), at: i)
            parentPlaceholder.removeChildren(in: [placeholderNode])
            addChild(numberButtons[i])
        }
        
        gridFrame = GridNode(self.childNode(withName: "GridFrame")!.frame)
        addChild(gridFrame!)
        
        // DEFINING BUTTON FUNCTIONS
        
        // BACK / HOME
        miscButtons[0].action = {
            self.switchDelegate!.moveToHomeScene(scene: self, return_code: 0)
        }
        // SETTINGS
        miscButtons[1].action = {
            
        }
        
        // NOTES1
        actionButtons[0].action = {
            self.gridFrame!.toggleNotes()
            let toggle = self.gridFrame!.notesToggle
            for i in [0, 4] {
                self.actionButtons[i].changeColors(buttonColor: toggle ? self.secondaryTextColor : self.buttonColor,
                                                   contentColor: toggle ? self.buttonColor : self.secondaryTextColor)
            }
        }
        // UNDO
        actionButtons[1].action = {
            
        }
        // CHECK
        actionButtons[2].action = {
            let result = self.gridFrame!.checkGrid()
            if result {
                print("eyoooo")
            }
        }
        // ERASE
        actionButtons[3].action = {
            if self.gridFrame != nil {
                self.gridFrame!.placeNumber(0)
            }
        }
        // NOTES2
        actionButtons[4].action = actionButtons[0].action
        
        // NUMBER BUTTONS
        for i in 0..<NUMBER_BUTTON_NAMES.count {
            numberButtons[i].action = {
                if self.gridFrame != nil {
                    self.gridFrame!.placeNumber(i + 1)
                }
            }
        }
        
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        // Code to run when the scene is first loaded into view
        time = Date.now
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Code to run when the screen is touched
    }
    
    override func update(_ currentTime: TimeInterval) {
        gridFrame!.updateGrid(-time.timeIntervalSinceNow)
        // Code to run on each frame of the game loop
    }
    
    func adjustToFrame(frame: CGRect) {
        //do stuff here
    }
    
    // Add any additional functions or methods here
}
