//
//  GameScene.swift
//  parallax-scrolling
//
//  Created by Lucas Louca on 12/04/15.
//  Copyright (c) 2015 Lucas Louca. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var parallaxBackground:ParallaxScrolling
    
    init(size: CGSize, scrollingDirection:ParallaxScrolling.ScrollingDirection) {
        var images: [UIImage] = [UIImage(named: "ground")!, UIImage(named: "mountains")!, UIImage(named: "clouds")!]
        
        self.parallaxBackground = ParallaxScrolling(backgroundImages: images, size: size, scrollingDirection: scrollingDirection, fastestSpeed: CGFloat(2.0), speedDecrease: CGFloat(1.0))!
        
        super.init(size: size)
        
        self.addChild(parallaxBackground)
        addCharacter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        parallaxBackground.update(currentTime)
        
    }
    
    
    func addCharacter() {
        var textures:[SKTexture] = []
        for i in 1...11 {
            var imageFileName = String(format: "wario-%d.tiff", i)
            textures.append(SKTexture(imageNamed: imageFileName))
        }
        
        var character = SKSpriteNode(texture: textures.first)
        character.setScale(0.5)
        character.position = CGPointMake(self.size.width/4, 50)
        
        var movement = SKAction.repeatActionForever(SKAction.animateWithTextures(textures, timePerFrame: 0.05))
        character.runAction(movement)
        
        self.addChild(character)
    }
}
