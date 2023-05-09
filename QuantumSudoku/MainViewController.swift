//
//  GameViewController.swift
//  TestSpriteKit
//
//  Created by Sriman Selvakumaran on 4/16/23.
//

import UIKit
import SpriteKit
import GameplayKit

protocol QSceneDelegate: AnyObject {
    func moveToGameScene(scene: HomeScene, difficulty: Int, _ gameCode: Int)
    func moveToHomeScene(scene: GameScene, return_code: Int)
}

class MainViewController: UIViewController, QSceneDelegate {
    
    var backgroundNode: SKSpriteNode!
    var homeScene: GKScene? = nil
    var gameScene: GKScene? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let homeRoot = HomeScene(fileNamed: "HomeScene")!
        let gameRoot = GameScene(fileNamed: "GameScene")!
        
        homeRoot.scaleMode = .aspectFill
        gameRoot.scaleMode = .aspectFill
        
        homeScene = GKScene()
        gameScene = GKScene()
        
        homeScene!.rootNode = homeRoot
        gameScene!.rootNode = gameRoot
        
        if homeScene != nil {
            // Copy gameplay related content over to the scene
            
            self.view.backgroundColor = Palette.backgroundFrame
            //view.frame = self.view.safeAreaLayoutGuide.layoutFrame
            
            homeRoot.switchDelegate = self
            gameRoot.switchDelegate = self
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(homeRoot)
                view.ignoresSiblingOrder = true
            }
        }
    }
    
    func moveToGameScene(scene: HomeScene, difficulty: Int, _ gameCode: Int) {
        if gameScene != nil {
            // Get the SKScene from the loaded GKScene
            let gameRoot = gameScene!.rootNode as! GameScene
            if gameCode == 0 {
                gameRoot.setDifficulty(difficulty)
                gameRoot.clearGrid()
            }
            // Copy gameplay related content over to the scene
            
            // Present the scene
            if let view = self.view as! SKView? {
                //view.frame = self.view.safeAreaLayoutGuide.layoutFrame
                view.presentScene(gameRoot, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 1))
                view.ignoresSiblingOrder = true
            }
        }
    }
    
    func moveToHomeScene(scene: GameScene, return_code: Int) {
        if homeScene != nil {
            // Get the SKScene from the loaded GKScene
            let homeRoot = homeScene!.rootNode as! HomeScene
            // Copy gameplay related content over to the scene
                
            // Set the scale mode to scale to fit the window
            homeRoot.scaleMode = .aspectFit //change to .fill
            //homeRoot.adjustToFrame(frame: self.view.safeAreaLayoutGuide.layoutFrame)
            // Present the scene
            if let view = self.view as! SKView? {
                //view.frame = self.view.safeAreaLayoutGuide.layoutFrame
                view.presentScene(homeRoot, transition: SKTransition.push(with: SKTransitionDirection.up, duration: 1))
                view.ignoresSiblingOrder = true
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
}
