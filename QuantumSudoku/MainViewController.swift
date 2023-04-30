//
//  GameViewController.swift
//  TestSpriteKit
//
//  Created by Sriman Selvakumaran on 4/16/23.
//

import UIKit
import SpriteKit
import GameplayKit

class MainViewController: UIViewController, QSceneDelegate {
    
    var homeScene: GKScene? = nil
    var gameScene: GKScene? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        let homeRoot = HomeScene(fileNamed: "HomeScene")!
        let gameRoot = GameScene(fileNamed: "GameScene")!
        
        homeScene = GKScene()
        gameScene = GKScene()
        
        homeScene!.rootNode = homeRoot
        gameScene!.rootNode = gameRoot
            
        if homeScene != nil {
            // Copy gameplay related content over to the scene
            self.view.backgroundColor = Palette.background
            //view.frame = self.view.safeAreaLayoutGuide.layoutFrame
            
            homeRoot.switchDelegate = self
            // Set the scale mode to scale to fit the window
            homeRoot.scaleMode = .aspectFit //change to .fill
            homeRoot.adjustToFrame(frame: self.view.safeAreaLayoutGuide.layoutFrame)
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(homeRoot)
                view.ignoresSiblingOrder = true
            }
        }
    }
    
    func moveToGameScene(scene: HomeScene, game_code: Int) {
        if gameScene != nil {
            // Get the SKScene from the loaded GKScene
            let gameRoot = gameScene!.rootNode as! GameScene
            // Copy gameplay related content over to the scene
                
            // Set the scale mode to scale to fit the window
            gameRoot.scaleMode = .aspectFit //change to .fill
            gameRoot.adjustToFrame(frame: self.view.safeAreaLayoutGuide.layoutFrame)
            // Present the scene
            if let view = self.view as! SKView? {
                //view.frame = self.view.safeAreaLayoutGuide.layoutFrame
                view.presentScene(gameRoot, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 1))
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
