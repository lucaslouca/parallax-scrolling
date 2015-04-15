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
        // Get images for each layer
        var images: [UIImage] = [UIImage(named: "ground")!, UIImage(named: "mountains")!, UIImage(named: "clouds")!]
        
        // Create a parallax background node
        self.parallaxBackground = ParallaxScrolling(backgroundImages: images, size: size, scrollingDirection: scrollingDirection, startingSpeed: CGFloat(2.0), speedDecreaseFactor: CGFloat(2.0))!
        
        super.init(size: size)
        
        // Add the parallax background to the scene
        self.addChild(parallaxBackground)
        
        // Add Wario to the scene
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
        parallaxBackground.update()
        
    }
    
    /**
    Add our Wario character to the screen
    */
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
