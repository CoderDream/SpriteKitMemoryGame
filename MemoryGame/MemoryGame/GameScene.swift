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
    
    
    let cardsPerRow :Int = 4        // display 1 more since index starts at 0 and is included
    let cardsPerColumn :Int = 5     // display 1 more since index starts at 0 and is included
    let cardSizeX :CGFloat = 50
    let cardSizeY :CGFloat = 50
    
    let scorePanelAndAdvertiseingHeight :CGFloat = 150
    
    var cards :[SKSpriteNode] = []
    var cardsBacks :[SKSpriteNode] = []
    var carsStatus :[Bool] = []
    
    let numberOfTypesCards :Int = 26
    
    var cardsSequence :[Int] = []
    
    var selectedCardIndex1 :Int = -1
    var selectedCardIndex2 :Int = -1
    var selectedCard1Value :String = ""
    var selectedCard2Value :String = ""
    
    var gameIsPlaying :Bool = false
    var lockInteraction :Bool = false
    
   
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
        if gameIsPlaying == false {
            if node.name == "play" {
                print("play button pressed")
                
                hideMenu()
                fillCardSequence()
                createCardboard()
                gameIsPlaying = true
            } else if node.name == "leaderboard" {
                print("leaderboard button pressed")
                showMenu() // remover later, just for testing
            } else if node.name == "rate" {
                print("rate button pressed")
            }
        } else {
            // game is playing
            if node.name != nil {
                print(node.name!)
                let num :Int? = Int.init(node.name!)
                if num != nil {
                    if num! > 0 {
                        if lockInteraction == true {
                            return
                        } else {
                            print("the card with number \(num!) was touched")
                            var i :Int = 0
                            for cardBack in cardsBacks {
                                if cardBack == node {
                                    // the node is identical to the cardback at index i
                                    let cardNode :SKSpriteNode = cards[i] as SKSpriteNode
                                    if selectedCardIndex1 == -1 {
                                        selectedCardIndex1 = i
                                        selectedCard1Value = cardNode.name!
                                        cardBack.run(SKAction.hide())
                                        // TODO: add sound effect
                                    } else if selectedCardIndex2 == -1 {
                                        if i != selectedCardIndex1 {
                                            lockInteraction = true
                                            selectedCardIndex2 = i
                                            selectedCard2Value = cardNode.name!
                                            cardBack.run(SKAction.hide())
                                            
                                            // at this point we want to compare the 2 cards for a match
                                            if selectedCard1Value == selectedCard2Value {
                                                print("we have a match")
                                                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideSelectedCards), userInfo: nil, repeats: false)
                                                
                                                setStatusCardFound(cardIndex: selectedCardIndex1)
                                                setStatusCardFound(cardIndex: selectedCardIndex2)
                                                // TODO: play a sound "match sound"
                                                // TODO: we nned to find out if all the cards from the board have been matched all
                                            } else {
                                                print("no match")
                                                Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(resetSelectedCards), userInfo: nil, repeats: false)
                                            }
                                        }
                                    }
                                }
                                
                                i += 1
                            }
                        }
                    }
                }
            } else {
                print("nil")
            }
            
        }
    }
    
    func createCardboard() {
        let totalEmptyScapeX :CGFloat = self.size.width - (CGFloat(cardsPerRow + 1)) * cardSizeX
        let offsetX :CGFloat = totalEmptyScapeX / (CGFloat(cardsPerRow) + 2)
        
        let totalEmptySpaceY :CGFloat = self.size.height - scorePanelAndAdvertiseingHeight - (CGFloat(cardsPerColumn + 1)) * cardSizeY
        let offsetY :CGFloat = totalEmptySpaceY / (CGFloat(cardsPerColumn) + 2)
        
        var idx :Int = 0
        for i in 0 ... cardsPerRow {
            for j in 0 ... cardsPerColumn {
                let cardIndex :Int = cardsSequence[idx] // TODO: need to fill the cardsSequence array!
                idx += 1
                let cardName :String = String(format: "card-%i", cardIndex)
                let card :SKSpriteNode = SKSpriteNode(imageNamed: cardName)
                card.size = CGSize(width: cardSizeX, height: cardSizeY)
                card.anchorPoint = CGPoint(x: 0, y: 0)
                
                let posX :CGFloat = offsetX + CGFloat(i) * card.size.width + offsetX * CGFloat(i)
                let posY :CGFloat = offsetY + CGFloat(j) * card.size.height + offsetY * CGFloat(j)
                card.position = CGPoint(x: posX, y: posY)
                card.zPosition = 9
                card.name = String(format: "%i", cardIndex)
                addChild(card)
                cards.append(card)
                
                let cardBack :SKSpriteNode = SKSpriteNode(imageNamed: "card-back")
                cardBack.size = CGSize(width: cardSizeX, height: cardSizeY)
                cardBack.anchorPoint = CGPoint(x: 0, y: 0)
                cardBack.zPosition = 10
                cardBack.position = CGPoint(x: posX, y: posY)
                cardBack.name = String(format: "%i", cardIndex)
                addChild(cardBack)
                cardsBacks.append(cardBack)
            }
        }
    }
    
//    func shuffle<C :MutableCollectionType where C.Index == Int>(var list: C) ->C {
//        let count
//    }
    
//    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
//        let total = list.count
//        for i in 0..<(total - 1) {
//            let j = Int(arc4random_uniform(UInt32(total - i))) + i
//            swap(&list[i], &list[j])
//        }
//        return list
//    }
    
    func shuffleArray<T>( array: inout Array<T>) -> Array<T> {
        var index = array.count - 1
        while index > 0 {
            //for var index = array.count - 1; index > 0; index -= 1 {
            // Random int from 0 to index-1
            let j = Int(arc4random_uniform(UInt32(index-1)))
            
            // Swap two array elements
            // Notice '&' required as swap uses 'inout' parameters
            array.swapAt(index, j)
            //swap(&array[index], &array[j])
           
            index -= 1
        }
        return array
    }
    
    func fillCardSequence() {
        let totalCards :Int = (cardsPerRow + 1) * (cardsPerColumn + 1) / 2
        for i in 1 ... totalCards {
            cardsSequence.append(i)
            cardsSequence.append(i)
        }
        //let newSequence =
        let newSequence = shuffleArray(array: &cardsSequence)
        cardsSequence.removeAll(keepingCapacity: false)
        cardsSequence += newSequence
    }
    
    @objc func hideSelectedCards() {
        let card1 :SKSpriteNode = cards[selectedCardIndex1] as SKSpriteNode
        let card2 :SKSpriteNode = cards[selectedCardIndex2] as SKSpriteNode
        
        card1.run(SKAction.hide())
        card2.run(SKAction.hide())
        
        selectedCardIndex1 = -1
        selectedCardIndex2 = -1
        lockInteraction = false
    }
    
    
    @objc func resetSelectedCards() {
        let card1 :SKSpriteNode = cardsBacks[selectedCardIndex1] as SKSpriteNode
        let card2 :SKSpriteNode = cardsBacks[selectedCardIndex2] as SKSpriteNode
        
        card1.run(SKAction.unhide())
        card2.run(SKAction.unhide())
        
        selectedCardIndex1 = -1
        selectedCardIndex2 = -1
        lockInteraction = false
    }
    
    func setStatusCardFound(cardIndex :Int) {
        carsStatus[cardIndex] = true
    }
}
