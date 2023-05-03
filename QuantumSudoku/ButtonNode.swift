import SpriteKit
import UIKit
class ButtonNode: SKNode {
    
    let buttonRect: CGRect
    let buttonColor: UIColor
    let labelColor: UIColor?
    let symbolColor: UIColor?
    let buttonLabel: String?
    let buttonSymbol: String?
    
    
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         buttonLabel: String,
         labelColor: UIColor) {
        self.buttonRect = buttonRect
        self.buttonColor = buttonColor
        self.buttonLabel = buttonLabel
        self.labelColor = labelColor
        self.symbolColor = nil; self.buttonSymbol = nil
        super.init()
        
        // Create the rounded rectangle shape for the button
        let buttonShape = SKShapeNode(rect: buttonRect, cornerRadius: 20)
        buttonShape.fillColor = buttonColor
        buttonShape.strokeColor = UIColor.clear
        addChild(buttonShape)
        
        // Create the label for the button
        let labelNode = SKLabelNode(text: buttonLabel)
        labelNode.fontName = "Helvetica"
        labelNode.fontSize = 32
        labelNode.fontColor = labelColor
        labelNode.verticalAlignmentMode = .center
        labelNode.position = CGPoint(x: buttonRect.midX, y: buttonRect.midY)
        addChild(labelNode)
    }
    
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         buttonSymbol: String,
         symbolColor: UIColor) {
        self.buttonRect = buttonRect
        self.buttonColor = buttonColor
        self.buttonSymbol = buttonSymbol
        self.symbolColor = symbolColor
        self.labelColor = nil; self.buttonLabel = nil
        super.init()
        
        // Create the rounded rectangle shape for the button
        let buttonShape = SKShapeNode(rect: buttonRect, cornerRadius: 20)
        buttonShape.fillColor = buttonColor
        buttonShape.strokeColor = UIColor.clear
        addChild(buttonShape)
        
        // Create the image
        var image = UIImage(named: buttonSymbol)!
        image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        image = image.applyingSymbolConfiguration(UIImage.SymbolConfiguration(hierarchicalColor: .red))!
        image = image.withTintColor(.red)
        
        let symbolNode = SKSpriteNode(texture: SKTexture(image: image), color: .red, size: CGSize())
//        symbolNode.color = symbolColor
//        symbolNode.blendMode = SKBlendMode.alpha
//        symbolNode.colorBlendFactor =
        let length = (buttonRect.width > buttonRect.height ? buttonRect.height : buttonRect.width) * 0.75
        symbolNode.size = CGSize(width: length, height: length)
        addChild(symbolNode)
        symbolNode.position = CGPoint(x: buttonRect.minX + buttonRect.height / 2, y: buttonRect.minY + buttonRect.width / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
