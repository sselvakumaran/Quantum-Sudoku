import SpriteKit

class ButtonNode: SKNode {
    
    let buttonColor: UIColor
    let buttonLabel: String
    let labelColor: UIColor
    
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80), buttonColor: UIColor, buttonLabel: String, labelColor: UIColor) {
        self.buttonColor = buttonColor
        self.buttonLabel = buttonLabel
        self.labelColor = labelColor
        
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
