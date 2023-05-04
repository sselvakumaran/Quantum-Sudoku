import SpriteKit
import UIKit
class ButtonNode: SKNode {
    
    let buttonRect: CGRect
    let buttonColor: UIColor
    let labelColor: UIColor?
    let symbolColor: UIColor?
    let buttonLabel: String?
    let buttonSymbol: String?
    
    var action: (() -> Void)?
    
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
        labelNode.fontSize = buttonRect.height / 2.5
        labelNode.fontColor = labelColor
        labelNode.verticalAlignmentMode = .center
        labelNode.position = CGPoint(x: buttonRect.midX, y: buttonRect.midY)
        addChild(labelNode)
        
        self.isUserInteractionEnabled = true
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
        var imageconfig = UIImage.SymbolConfiguration(weight: .regular)
        imageconfig = imageconfig.applying(UIImage.SymbolConfiguration(paletteColors: [symbolColor, symbolColor, symbolColor]))
        var image = UIImage(systemName: buttonSymbol, withConfiguration: imageconfig)!
        image = image.withRenderingMode(.automatic)
        let data = image.pngData()
        let ratio = 0.5 * (buttonRect.width > buttonRect.height ?
                            buttonRect.width / image.size.width :
                            buttonRect.height / image.size.height)
        let symbolNode = SKSpriteNode(texture: SKTexture(image: UIImage(data:data!)!), size: image.size)
        symbolNode.size = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        symbolNode.position = CGPoint(x: buttonRect.minX + buttonRect.height / 2, y: buttonRect.minY + buttonRect.width / 2)
        addChild(symbolNode)
        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("heehee")
        guard !isHidden, let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        print("woohoo")
        if self.contains(touchLocation) {
            action!()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
