import SpriteKit
import UIKit
class GridNode: SKNode {
    
    let THICK_LINE_WIDTH = 6
    let THIN_LINE_WIDTH = 4
    let THICK_LINE_COLOR = Palette.gridStrongLine
    let THIN_LINE_COLOR = Palette.gridWeakLine
    let SELECTED_TEXT_COLOR = Palette.textSymbolBold
    let LABEL_TEXT_COLOR = Palette.textSymbolNormal
    let NOTES_TEXT_COLOR = Palette.textSymbolLight
    let PRIMARY_SELECTED_COLOR = Palette.backgroundPrimary
    let SECONDARY_SELECTED_COLOR = Palette.backgroundSecondary
    let TERTIARY_SELECTED_COLOR = Palette.backgroundTertiary
    
    // [ROW][COLUMN]
    var labels: [[SKLabelNode]]
    // [HORIZONTAL, VERTICAL]
    var gridLines: [[SKShapeNode]]
    
    init(_ gridFrame: CGRect) {
        labels = Array(repeating: Array(repeating: SKLabelNode(), count: 9), count: 9)
        gridLines = [Array(repeating: SKShapeNode(), count: 8), Array(repeating: SKShapeNode(), count: 8)]
        
        super.init()
        
        // HORIZONTAL
        for i in 0..<gridLines[0].count {
            let line = SKShapeNode(rect: CGRect(x: gridFrame.origin.x,
                                                y: gridFrame.origin.y + gridFrame.height * ((CGFloat) (i) + 1) / 9,
                                                width: gridFrame.width,
                                                height: (CGFloat) (i % 3 == 2 ? THICK_LINE_WIDTH : THIN_LINE_WIDTH)))
            line.fillColor = i % 3 == 2 ? THICK_LINE_COLOR : THIN_LINE_COLOR
            gridLines[0][i] = line
            addChild(line)
        }
        
        // VERTICAL
        for i in 0..<gridLines[1].count {
            let line = SKShapeNode(rect: CGRect(x: gridFrame.origin.x + gridFrame.width * ((CGFloat) (i) + 1) / 9,
                                                y: gridFrame.origin.y,
                                                width: (CGFloat) (i % 3 == 2 ? THICK_LINE_WIDTH : THIN_LINE_WIDTH),
                                                height: gridFrame.height))
            line.fillColor = i % 3 == 2 ? THICK_LINE_COLOR : THIN_LINE_COLOR
            gridLines[1][i] = line
            addChild(line)
        }
        
        for r in 0..<labels.count {
            for c in 0..<labels[0].count {
                let label = SKLabelNode(text: "\((r + c) % 10)")
                label.fontSize = 4 * (gridFrame.height / 9) / 5
                label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                label.position = CGPoint(x: gridFrame.origin.x + ((CGFloat) (c) + 0.5) * gridFrame.width / 9,
                                         y: gridFrame.origin.y + ((CGFloat) (r) + 0.5) * gridFrame.height / 9)
                label.fontColor = LABEL_TEXT_COLOR
                label.fontName = "Menlo"
                addChild(label)
            }
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
