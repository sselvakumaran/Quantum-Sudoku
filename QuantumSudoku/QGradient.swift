import Foundation
import CoreGraphics
import SpriteKit

struct Point {
    var x: Float
    var y: Float
    var r: Float
    var g: Float
    var b: Float
    var intensity: Float
}

class QGradient: SKSpriteNode {
    
    let POINT_SIZE = MemoryLayout<Point>.stride
    
    /*
    init(points: [CGPoint], colors: [UIColor], intensities: [Int], size: CGSize) {
        let count = points.count
        var components: [CGFloat]
        
        // Convert points, colors, and intensities arrays into a single data object
        var data = Data(count: count * POINT_SIZE)
        for i in 0..<count {
            components = colors[i].cgColor.components!
            var point = Point(x: Float(points[i].x),
                              y: Float(points[i].y),
                              r: Float(components[0]),
                              g: Float(components[1]),
                              b: Float(components[2]),
                              intensity: Float(intensities[i]))
            data.replaceSubrange(i*POINT_SIZE..<(i+1)*POINT_SIZE, with: &point, count: POINT_SIZE)
        }
            
        // Create a texture descriptor
        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.pixelFormat = .rgba32Float
        textureDescriptor.width = Int(size.width)
        textureDescriptor.height = Int(size.height)
        
        // Create a texture from the data and texture descriptor
        guard let device = MTLCreateSystemDefaultDevice(),
            let texture = device.makeTexture(descriptor: textureDescriptor) else {
                fatalError("Failed to create texture")
            }
        texture.replace(region: MTLRegion(origin: .zero, size: textureDescriptor.size), mipmapLevel: 0, withBytes: data.bytes)
            
            // Create an SKShader and set the texture as a uniform
        let shader = SKShader(fileNamed: "GradientShader")
        shader.uniforms = [
            SKUniform(name: "u_texture", texture: texture)
        ]
            
        super.init(texture: nil, color: .clear, size: size)
        self.shader = shader
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    
    convenience init(box: CGRect) {
        let color = UIColor.red
        self.init(color: color, size: box.size)
        self.position = box.origin
    }
}

