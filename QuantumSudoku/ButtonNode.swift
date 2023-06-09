import SpriteKit
import UIKit
class ButtonNode: SKNode {
    
    var background: SKShapeNode? = nil
    var contentLabel: SKLabelNode? = nil
    var contentSymbol: SKSpriteNode? = nil
    var contentSymbolImage: UIImage? = nil
    
    var action: (() -> Void)?
    
    // making a button with normal text
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         buttonLabel: String,
         labelColor: UIColor) {
        super.init()
        
        // Create the rounded rectangle shape for the button
        let buttonShape = SKShapeNode(rect: buttonRect, cornerRadius: 20)
        buttonShape.fillColor = buttonColor
        buttonShape.strokeColor = UIColor.clear
        buttonShape.name = "Background"
        background = buttonShape
        addChild(buttonShape)
        
        // Create the label for the button
        let labelNode = SKLabelNode(text: buttonLabel)
        labelNode.fontName = Palette.mainTextFont
        labelNode.fontSize = buttonRect.height / 2.5
        labelNode.fontColor = labelColor
        labelNode.verticalAlignmentMode = .center
        labelNode.position = CGPoint(x: buttonRect.midX, y: buttonRect.midY)
        labelNode.name = "Content"
        contentLabel = labelNode
        addChild(labelNode)
        
        self.isUserInteractionEnabled = true
    }
    
    // making a button with a symbol in it
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         buttonSymbol: String,
         symbolColor: UIColor) {
        super.init()
        
        // Create the rounded rectangle shape for the button
        let buttonShape = SKShapeNode(rect: buttonRect, cornerRadius: 20)
        buttonShape.fillColor = buttonColor
        buttonShape.strokeColor = UIColor.clear
        buttonShape.name = "Background"
        background = buttonShape
        addChild(buttonShape)
        
        // Create the image
        var imageconfig = UIImage.SymbolConfiguration(weight: .regular)
        imageconfig = imageconfig.applying(UIImage.SymbolConfiguration(paletteColors: [symbolColor, symbolColor, symbolColor]))
        let image = UIImage(systemName: buttonSymbol, withConfiguration: imageconfig)!
        contentSymbolImage = image
        let data = image.pngData()
        let ratio = 0.5 * (buttonRect.width > buttonRect.height ?
                            buttonRect.width / image.size.width :
                            buttonRect.height / image.size.height)
        let symbolNode = SKSpriteNode(texture: SKTexture(image: UIImage(data:data!)!), size: image.size)
        symbolNode.size = CGSize(width: image.size.width * ratio, height: image.size.height * ratio)
        symbolNode.position = CGPoint(x: buttonRect.minX + buttonRect.height / 2, y: buttonRect.minY + buttonRect.width / 2)
        symbolNode.name = "ContentSymbol"
        contentSymbol = symbolNode
        addChild(symbolNode)
        
        self.isUserInteractionEnabled = true
    }
    
    // making a button with a single number
    init(buttonRect: CGRect = CGRect(x: -100, y: -40, width: 200, height: 80),
         buttonColor: UIColor,
         number: Int,
         labelColor: UIColor) {
        super.init()
        
        // Create the rounded rectangle shape for the button
        let buttonShape = SKShapeNode(rect: buttonRect, cornerRadius: 20)
        buttonShape.fillColor = buttonColor
        buttonShape.strokeColor = UIColor.clear
        buttonShape.name = "Background"
        background = buttonShape
        addChild(buttonShape)
        
        // Create the label for the button
        let labelNode = SKLabelNode(text: "\(number)")
        labelNode.fontName = Palette.gridNumberFont
        labelNode.fontSize = buttonRect.height
        labelNode.fontColor = labelColor
        labelNode.verticalAlignmentMode = .center
        labelNode.position = CGPoint(x: buttonRect.midX, y: buttonRect.midY)
        labelNode.name = "Content"
        contentLabel = labelNode
        addChild(labelNode)
        
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isHidden, let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if self.contains(touchLocation) {
            action!()
        }
    }
    
    func changeColors(_ buttonColor: UIColor, _ contentColor1: UIColor, _ contentColor2: UIColor) {
        self.background!.fillColor = buttonColor
        if (contentLabel != nil) {
            contentLabel!.fontColor = contentColor1
        }
        if (contentSymbol != nil) {
            let imageconfig = UIImage.SymbolConfiguration(weight: .regular)
                .applying(UIImage.SymbolConfiguration(paletteColors: [contentColor1, contentColor2, contentColor2]))
            let image = contentSymbolImage!.applyingSymbolConfiguration(imageconfig)
            let data = image!.pngData()
            contentSymbol!.texture = SKTexture(image: UIImage(data: data!)!)
        }
    }
    
    func changeSymbol(_ buttonSymbol: String, _ contentColor1: UIColor, _ contentColor2: UIColor) {
        let imageconfig = UIImage.SymbolConfiguration(weight: .regular)
            .applying(UIImage.SymbolConfiguration(paletteColors: [contentColor1, contentColor2, contentColor2]))
        contentSymbolImage = UIImage(systemName: buttonSymbol)!.applyingSymbolConfiguration(imageconfig)
        let data = contentSymbolImage!.pngData()
        contentSymbol!.texture = SKTexture(image: UIImage(data: data!)!)
        let ratio = 0.5 * (background!.frame.width > background!.frame.height ?
                           background!.frame.width / contentSymbolImage!.size.width :
                            background!.frame.height / contentSymbolImage!.size.height)
        contentSymbol!.size = CGSize(width: contentSymbolImage!.size.width * ratio, height: contentSymbolImage!.size.height * ratio)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
