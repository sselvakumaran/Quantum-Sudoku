import SpriteKit

class ButtonNode: SKNode {
    
    let buttonRect: CGRect
    let buttonColor: UIColor
    let labelColor: UIColor
    let symbolColor: UIColor
    let buttonLabel: String
    let buttonSymbol: UIImage
    
    
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         buttonLabel: String,
         labelColor: UIColor) {
        self.buttonRect = buttonRect
        self.buttonColor = buttonColor
        self.buttonLabel = buttonLabel
        self.labelColor = labelColor
        self.symbolColor = Palette.textSymbolNormal
        self.buttonSymbol = UIImage()
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
         buttonSymbol: UIImage,
         symbolColor: UIColor) {
        self.buttonRect = buttonRect
        self.buttonColor = buttonColor
        self.buttonSymbol = buttonSymbol
        self.symbolColor = symbolColor
        self.labelColor = Palette.textSymbolNormal
        self.buttonLabel = ""
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
