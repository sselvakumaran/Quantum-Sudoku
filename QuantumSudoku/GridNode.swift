import SpriteKit
import UIKit

struct GridPos {
    var x: Int = 0
    var y: Int = 0
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

class GridNode: SKNode {
    
    let THICK_LINE_WIDTH = 6
    let THIN_LINE_WIDTH = 4
    let THICK_LINE_COLOR = Palette.gridStrongLine
    let THIN_LINE_COLOR = Palette.gridWeakLine
    let LABEL_GIVEN_COLOR = Palette.textSymbolNormal
    let LABEL_PLACED_COLOR = Palette.textSymbolBold
    let NOTES_TEXT_COLOR = Palette.textSymbolLight
    let PRIMARY_SELECTED_COLOR = Palette.backgroundPrimary
    let SECONDARY_SELECTED_COLOR = Palette.backgroundSecondary
    let TERTIARY_SELECTED_COLOR = Palette.backgroundTertiary
    let UNSELECTED_GRID_COLOR = Palette.backgroundNormal
    
    var gridFrame: CGRect = CGRect()
    // [ROW][COLUMN]
    var labels: [[SKLabelNode]]
    var cellBackgrounds: [[SKSpriteNode]]
    // [HORIZONTAL, VERTICAL]
    var gridLines: [[SKShapeNode]]
    
    var selectedCell: GridPos = GridPos(0,0)
    
    init(_ gridFrame: CGRect) {
        self.gridFrame = gridFrame
        labels = Array(repeating: Array(repeating: SKLabelNode(), count: 9), count: 9)
        cellBackgrounds = Array(repeating: Array(repeating: SKSpriteNode(), count: 9), count: 9)
        gridLines = [Array(repeating: SKShapeNode(), count: 8), Array(repeating: SKShapeNode(), count: 8)]
        
        super.init()
        
        // HORIZONTAL
        for i in 0..<gridLines[0].count {
            let line = SKShapeNode(rect: CGRect(x: gridFrame.origin.x,
                                                y: gridFrame.origin.y + gridFrame.height * ((CGFloat) (i) + 1) / 9,
                                                width: gridFrame.width,
                                                height: (CGFloat) (i % 3 == 2 ? THICK_LINE_WIDTH : THIN_LINE_WIDTH)))
            line.fillColor = i % 3 == 2 ? THICK_LINE_COLOR : THIN_LINE_COLOR
            line.zPosition = i % 3 == 2 ? 4 : 2
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
            line.zPosition = i % 3 == 2 ? 5 : 3
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
                label.zPosition = 1
                label.fontColor = LABEL_GIVEN_COLOR
                label.fontName = Palette.gridNumberFont
                labels[r][c] = label
                addChild(label)
            }
        }
        
        for r in 0..<cellBackgrounds.count {
            for c in 0..<cellBackgrounds[0].count {
                let background = SKSpriteNode(color: UNSELECTED_GRID_COLOR, size: CGSize(width: gridFrame.width / 9, height: gridFrame.height / 9))
                background.position = CGPoint(x: gridFrame.origin.x + ((CGFloat) (c) + 0.5) * gridFrame.width / 9,
                                              y: gridFrame.origin.y + ((CGFloat) (r) + 0.5) * gridFrame.height / 9)
                background.zPosition = 0
                cellBackgrounds[r][c] = background
                addChild(background)
                
            }
        }
        
        self.isUserInteractionEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isHidden, let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if self.contains(touchLocation) {
            let column = Int((touchLocation.x - self.gridFrame.origin.x) * 9.0 / self.gridFrame.width)
            let row = Int((touchLocation.y - self.gridFrame.origin.y) * 9.0 / self.gridFrame.height)
            selectedCell = GridPos(column, row)
            var color: UIColor = UNSELECTED_GRID_COLOR
            for r in 0..<cellBackgrounds.count {
                for c in 0..<cellBackgrounds[0].count {
                    switch (c == selectedCell.x ? 1 : 0) +
                        (r == selectedCell.y ? 2 : 0) +
                        (r / 3 == selectedCell.y / 3 && c / 3 == selectedCell.x / 3 ? 4 : 0) {
                    case 7: // selected cell
                        color = PRIMARY_SELECTED_COLOR
                    case 0:
                        color = UNSELECTED_GRID_COLOR
                    default:
                        color = SECONDARY_SELECTED_COLOR
                    }
                    cellBackgrounds[r][c].color = color
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
