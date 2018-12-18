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
    
    var buttonPlay: SKSpriteNode!
    var buttonLeaderboard: SKSpriteNode!
    var buttonRate: SKSpriteNode!
    var title: SKSpriteNode!
//    
//    private var label : SKLabelNode?
//    private var spinnyNode : SKShapeNode?
//    
    override func didMove(to view: SKView) {
        setupScenery()
        
        createMenu()

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
        let touch = touches.first
        let positionInScene : CGPoint = touch!.location(in: self)
        let touchedNode : SKSpriteNode = self.atPoint(positionInScene) as! SKSpriteNode
        
        self.processItemTouch(node: touchedNode)
    }

//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // setup
    func setupScenery() {
        let background = SKSpriteNode(imageNamed: BackgroundImage)
        background.anchorPoint = CGPoint(x: 0, y: 1)
        background.position = CGPoint(x: 0, y: size.height)
        background.zPosition = 0
        background.size = CGSize(width: self.view!.bounds.size.width, height: self.view!.bounds.size.height)
        addChild(background)
    }
    
    // create menu
    func createMenu() {
        let offsetX: CGFloat = 5.0
        let offsetY: CGFloat = 3.0
        buttonRate = SKSpriteNode(imageNamed: buttonRateImage)
        buttonRate.position = CGPoint(x: size.width / 2, y: size.height / 2 + buttonRate.size.height + offsetY)
        buttonRate.zPosition = 10
        buttonRate.name = "rate"
        addChild(buttonRate)
        
        buttonPlay = SKSpriteNode(imageNamed: buttonPlayImage)
        buttonPlay.position = CGPoint(x: size.width / 2 - offsetX - buttonPlay.size.width / 2, y: size.height / 2)
        buttonPlay.zPosition = 10
        buttonPlay.name = "play"
        addChild(buttonPlay)
        
        buttonLeaderboard = SKSpriteNode(imageNamed: buttonLeaderboardImage)
        buttonLeaderboard.position = CGPoint(x: size.width / 2 + offsetX + buttonLeaderboard.size.width / 2, y: size.height / 2)
        buttonLeaderboard.zPosition = 10
        buttonLeaderboard.name = "leaderboard"
        addChild(buttonLeaderboard)
        
        title = SKSpriteNode(imageNamed: titleImage)
        title.position = CGPoint(x: size.width / 2, y: buttonRate.position.y + buttonRate.size.height / 2 + title.size.height / 2 + offsetY)
        title.zPosition = 10
        title.name = "title"
        // 缩小30%
        title.setScale(0.7)
        addChild(title)
    }
    
    func hideMenu() {
        let duration: TimeInterval = 0.5
        buttonPlay.run(SKAction.fadeAlpha(to: 0, duration: duration))
        buttonLeaderboard.run(SKAction.fadeAlpha(to: 0, duration: duration))
        buttonRate.run(SKAction.fadeAlpha(to: 0, duration: duration))
        title.run(SKAction.fadeAlpha(to: 0, duration: duration))
    }
    
    func showMenu() {
        let duration: TimeInterval = 0.5
        buttonPlay.run(SKAction.fadeAlpha(to: 1, duration: duration))
        buttonLeaderboard.run(SKAction.fadeAlpha(to: 1, duration: duration))
        buttonRate.run(SKAction.fadeAlpha(to: 1, duration: duration))
        title.run(SKAction.fadeAlpha(to: 1, duration: duration))
    }
    
    func processItemTouch(node: SKSpriteNode) {
        if node.name == "play" {
            print("play button pressed")
            hideMenu()
        } else if node.name == "leaderboard" {
            print("leaderboard button pressed")
            showMenu() // remover later, just for testing
        } else if node.name == "rate" {
            print("rate button pressed")
        }
    }
}
