//
//  GameScene.swift
//  MemoryGame
//
//  Created by CoderDream on 2018/12/18.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
//    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    
    override func didMove(to view: SKView) {
        setupScenery()

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func setupScenery() {
        let background = SKSpriteNode(imageNamed: BackgroundImage)
        background.anchorPoint = CGPoint(x: 0, y: 1)
        background.position = CGPoint(x: 0, y: size.height)
        background.zPosition = 0
        background.size = CGSize(width: self.view!.bounds.size.width, height: self.view!.bounds.size.height)
        addChild(background)
    }
}
