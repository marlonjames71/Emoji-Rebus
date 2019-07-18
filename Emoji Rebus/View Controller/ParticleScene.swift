//
//  ParticleScene.swift
//  Emoji Rebus
//
//  Created by Marlon Raskin on 7/17/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import SpriteKit

class ParticleScene: SKScene {

	override func didMove(to view: SKView) {
		super.didMove(to: view)
		guard let particles = SKEmitterNode(fileNamed: "MyParticle") else { return }
		particles.position = CGPoint(x: view.frame.midX, y: view.frame.maxY)
		addChild(particles)
		
		backgroundColor = .clear
	}
}
