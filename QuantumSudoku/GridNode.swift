import SpriteKit
import UIKit

struct GridPos {
    var row: Int = 0
    var column: Int = 0
    
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

class GridNode: SKNode {
    
    let THICK_LINE_WIDTH = 4.0
    let THIN_LINE_WIDTH = 4.0
    let FRAME_THICKNESS = 6.0
    let THICK_LINE_COLOR = Palette.gridStrongLine
    let THIN_LINE_COLOR = Palette.gridWeakLine
    let LABEL_GIVEN_COLOR = Palette.textSymbolNormal
    let LABEL_PLACED_COLOR = Palette.textSymbolBold
    let NOTES_TEXT_COLOR = Palette.textSymbolLight
    let PRIMARY_SELECTED_COLOR = Palette.backgroundPrimary
    let SECONDARY_SELECTED_COLOR = Palette.backgroundSecondary
    let TERTIARY_SELECTED_COLOR = Palette.backgroundTertiary
    let UNSELECTED_GRID_COLOR = Palette.backgroundNormal
    let GRADIENT_COLORS = Palette.gradientColors
    let INCORRECT_COLOR = Palette.incorrectCell
    
    var gridFrame: CGRect = CGRect()
    // [ROW][COLUMN]
    var labels: [[SKLabelNode]]
    var cellBackgrounds: [[SKSpriteNode]]
    var entangledCellFrames: [[SKShapeNode]]
    var systemColors: [UIColor] = []
    
    // [HORIZONTAL, VERTICAL]
    var gridLines: [[SKShapeNode]]
    
    var selectedCell: GridPos = GridPos(0,0)
    
    init(_ gridFrame: CGRect) {
        self.gridFrame = gridFrame
        labels = Array(repeating: Array(repeating: SKLabelNode(), count: 9), count: 9)
        cellBackgrounds = Array(repeating: Array(repeating: SKSpriteNode(), count: 9), count: 9)
        gridLines = [Array(repeating: SKShapeNode(), count: 8), Array(repeating: SKShapeNode(), count: 8)]
        entangledCellFrames = []
        
        super.init()
        
        initialize_grid()
        make_puzzle(0)
        
        // HORIZONTAL LINES
        for i in 0..<gridLines[0].count {
            let line = SKShapeNode(rect: CGRect(x: gridFrame.origin.x,
                                                y: gridFrame.maxY - gridFrame.height * ((CGFloat) (i) + 1) / 9,
                                                width: gridFrame.width,
                                                height: (CGFloat) (i % 3 == 2 ? THICK_LINE_WIDTH : THIN_LINE_WIDTH)))
            line.fillColor = i % 3 == 2 ? THICK_LINE_COLOR : THIN_LINE_COLOR
            line.zPosition = i % 3 == 2 ? 4 : 2
            line.glowWidth = 0
            gridLines[0][i] = line
            addChild(line)
        }
        
        // VERTICAL LINES
        for i in 0..<gridLines[1].count {
            let line = SKShapeNode(rect: CGRect(x: gridFrame.minX + gridFrame.width * ((CGFloat) (i) + 1) / 9,
                                                y: gridFrame.origin.y,
                                                width: (CGFloat) (i % 3 == 2 ? THICK_LINE_WIDTH : THIN_LINE_WIDTH),
                                                height: gridFrame.height))
            line.fillColor = i % 3 == 2 ? THICK_LINE_COLOR : THIN_LINE_COLOR
            line.zPosition = i % 3 == 2 ? 5 : 3
            line.glowWidth = 0
            gridLines[1][i] = line
            addChild(line)
        }
        
        for r in 0..<labels.count {
            for c in 0..<labels[0].count {
                let num = get_number(Int32(r),Int32(c))
                let label = SKLabelNode(text: (num != 0 ? "\(num)" : ""))
                label.fontSize = 4 * (gridFrame.height / 9) / 5
                label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
                label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
                label.position = CGPoint(x: gridFrame.minX + ((CGFloat) (c) + 0.5) * gridFrame.width / 9,
                                         y: gridFrame.maxY - ((CGFloat) (r) + 0.5) * gridFrame.height / 9)
                label.zPosition = 1
                label.fontColor = is_cell_given(Int32(r),Int32(c)) == 1 ? LABEL_GIVEN_COLOR : LABEL_PLACED_COLOR
                label.fontName = Palette.gridNumberFont
                labels[r][c] = label
                addChild(label)
            }
        }
        
        for r in 0..<cellBackgrounds.count {
            for c in 0..<cellBackgrounds[0].count {
                let background = SKSpriteNode(color: UNSELECTED_GRID_COLOR, size: CGSize(width: gridFrame.width / 9, height: gridFrame.height / 9))
                background.position = CGPoint(x: gridFrame.minX + ((CGFloat) (c) + 0.5) * gridFrame.width / 9,
                                              y: gridFrame.maxY - ((CGFloat) (r) + 0.5) * gridFrame.height / 9)
                background.zPosition = 0
                cellBackgrounds[r][c] = background
                addChild(background)
            }
        }
        let num_systems = get_num_entangled_systems()
        entangledCellFrames = Array(repeating: [], count: Int(num_systems))
        systemColors = Palette.gradientColors.shuffled()
        for system in 0..<num_systems {
            let num_cells = get_num_entangled_in_system(system)
            entangledCellFrames[Int(system)] = Array(repeating: SKShapeNode(), count: Int(num_cells))
            for cell in 0..<num_cells {
                let pos = get_pos_entangled_cell(system, cell)
                let bgframe = cellBackgrounds[Int(get_row(pos))][Int(get_column(pos))].frame
                let entangledFrame = SKShapeNode(rect: CGRect(x: bgframe.minX + FRAME_THICKNESS,
                                                              y: bgframe.minY + FRAME_THICKNESS,
                                                              width: bgframe.width + THIN_LINE_WIDTH - 2 * FRAME_THICKNESS,
                                                              height: bgframe.height + THIN_LINE_WIDTH - 2 * FRAME_THICKNESS),
                                                 cornerRadius: 0)
                entangledFrame.fillColor = UIColor.clear
                entangledFrame.strokeColor = Palette.gradientMix([systemColors[Int(system)], UNSELECTED_GRID_COLOR], Double(system))
                entangledFrame.lineCap = CGLineCap.square
                entangledFrame.glowWidth = FRAME_THICKNESS
                entangledFrame.zPosition = 1
                entangledCellFrames[Int(system)][Int(cell)] = entangledFrame
                addChild(entangledCellFrames[Int(system)][Int(cell)])
            }
        }
        
        self.isUserInteractionEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isHidden, let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        if self.contains(touchLocation) {
            let column = Int((touchLocation.x - self.gridFrame.minX) * 9.0 / self.gridFrame.width)
            let row = Int((self.gridFrame.maxY - touchLocation.y) * 9.0 / self.gridFrame.height)
            selectedCell = GridPos(row, column)
            var color: UIColor = UNSELECTED_GRID_COLOR
            for r in 0..<cellBackgrounds.count {
                for c in 0..<cellBackgrounds[0].count {
                    let num_t = get_number(Int32(row), Int32(column))
                    switch (c == selectedCell.column ? 1 : 0) +
                        (r == selectedCell.row ? 2 : 0) +
                        (r / 3 == selectedCell.row / 3 && c / 3 == selectedCell.column / 3 ? 4 : 0) +
                        (num_t != 0 && get_number(Int32(r), Int32(c)) == num_t ? 8 : 0) {
                    case 7, 15: // matches row, column, subgrid
                        color = PRIMARY_SELECTED_COLOR
                    case 8..<15: // is nonzero space and shares number with selected cell
                        color = TERTIARY_SELECTED_COLOR
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
    
    func placeNumber(_ number: Int) {
        let num = place_number(Int32(selectedCell.row), Int32(selectedCell.column), Int32(number))
        if (num != 10) {
            labels[selectedCell.row][selectedCell.column].fontColor = LABEL_PLACED_COLOR
            labels[selectedCell.row][selectedCell.column].text = number != 0 ? "\(num)" : ""
        }
    }
    
    func updateGrid(_ time: Double) {
        let num_systems = get_num_entangled_systems()
        for system in 0..<num_systems {
            let num_cells = get_num_entangled_in_system(system)
            for cell in 0..<num_cells {
                entangledCellFrames[Int(system)][Int(cell)].strokeColor = Palette.gradientMix([systemColors[Int(system)], UNSELECTED_GRID_COLOR],
                                                                                              Palette.timeToCosineLerp(time + Double(system)))
            }
        }
    }
    
    func checkGrid() -> Bool {
        var result = true
        for r in 0..<labels.count {
            for c in 0..<labels[0].count {
                if (check_cell(Int32(r),Int32(c)) == 0) {
                    if (get_number(Int32(r), Int32(c)) != 0) {
                        labels[r][c].fontColor = INCORRECT_COLOR
                    }
                    result = false
                }
            }
        }
        return result
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
