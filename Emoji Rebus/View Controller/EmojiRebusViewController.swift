//
//  TestViewController.swift
//  Emoji Rebus
//
//  Created by Marlon Raskin on 7/16/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit
import SpriteKit

enum Result: String {
	case correct = "Correct!"
	case incorrect = "Wrong!"
}

class EmojiRebusViewController: UIViewController, UITextFieldDelegate {

	let happyEmojis = "😜 😁 🤪 😉".split(separator: " ").map { String($0) }
	let angryEmojis = "😡 🤬 🤯 😱 🤮 🤢".split(separator: " ").map { String($0) }

	let puzzleController = PuzzleController()
	let orginalTitleText = "Emoji Rebus 🧩"
	var puzzleIndex = 0
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var resultEmojiLabel: UILabel!
	@IBOutlet weak var emojiPuzzleLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var hintLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var particlesView: SKView!
	@IBOutlet weak var leftPuzzleLabel: UILabel!
	@IBOutlet weak var rightPuzzleLabel: UILabel!
	
	
	let layer = CAGradientLayer()
	var result: Result = .incorrect
	

	override func viewDidLoad() {
        super.viewDidLoad()
		layer.frame = view.bounds
		layer.colors = [UIColor.white.cgColor,
						UIColor(red: 0.12, green: 0.96, blue: 0.99, alpha: 1.0).cgColor]
		view.layer.insertSublayer(layer, at: 0)
		checkButton.layer.cornerRadius = 20
		nextButton.layer.borderWidth = 3
		nextButton.layer.borderColor = #colorLiteral(red: 1, green: 0.1343690869, blue: 0.4400124269, alpha: 1)
		nextButton.layer.cornerRadius = 20
		levelLabel.text = "\(puzzleIndex + 1)/\(puzzleController.puzzles.count)"
		enableNxtBtn(false)
		loadPuzzle()
		
		
	}
	
	@IBAction func checkButtonTapped(_ sender: UIButton) {
		checkAnswer()
	}
	
	@IBAction func nextButtonTapped(_ sender: UIButton) {
		loadNextPuzzle()
		enableNxtBtn(false)
		textField.text = nil
		resultEmojiLabel.text = "😑"
		levelLabel.text = "\(puzzleIndex + 1)/\(puzzleController.puzzles.count)"
	}
	
	@IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
		textField.resignFirstResponder()
	}
	
	@IBAction func hintGesture(_ sender: UITapGestureRecognizer) {
		hintLabel.text = puzzleController.puzzles[puzzleIndex].hint
	}
	
	func loadPuzzle() {
		let puzzle = puzzleController.puzzles[puzzleIndex]
		emojiPuzzleLabel.text = puzzle.puzzle
		resetHint()
	}
	
	func loadNextPuzzle() {
		puzzleIndex += 1
		if puzzleIndex == puzzleController.puzzles.count {
			puzzleIndex = 0
			hideStuff(false)
			titleLabel.text = orginalTitleText
		}
		loadPuzzle()
	}
	
	func resetHint() {
		hintLabel.text = "Hint ?"
	}
	
	func checkAnswer() {
		guard let input = textField.text else { return }
		let puzzle = puzzleController.puzzles[puzzleIndex]
		let processedInput = input.lowercased().replacingOccurrences(of: ##"\W"##, with: "", options: .regularExpression)
		let processedPuzzle = puzzle.answer.lowercased().replacingOccurrences(of: ##"\W"##, with: "", options: .regularExpression)

		if processedInput == processedPuzzle {
			if puzzleIndex == puzzleController.puzzles.count - 1 {
				titleLabel.text = "🙌 Thanks for playing! 🥳"
				hideStuff(true)
				textField.resignFirstResponder()
			}
			resultEmojiLabel.text = happyEmojis.randomElement()
			enableNxtBtn()
			wiggleResult(true)
		} else {
			resultEmojiLabel.text = angryEmojis.randomElement()
			wiggleResult(false)
		}
	}
	
	func wiggleResult(_ result: Bool) {
		let scale: CGFloat = result ? 1.2 : 1.4
		
		UIView.animate(withDuration: 0.1, animations: {
			self.resultEmojiLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
		}) { (_) in
			UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
				self.resultEmojiLabel.transform = .identity
			}, completion: nil)
		}
	}
	
	func hideStuff(_ hide: Bool) {
		
		if hide {
			particlesView.presentScene(ParticleScene(size: particlesView.frame.size))
			particlesView.isHidden = false
			particlesView.alpha = 1
		} else {
			UIView.animate(withDuration: 1) {
				self.particlesView.alpha = 0
			}
		}
		
		UIView.animate(withDuration: 0.7) {
			let alphaValue: CGFloat = hide ? 0.0 : 1.0
			self.textField.alpha = alphaValue
			self.hintLabel.alpha = alphaValue
			self.levelLabel.alpha = alphaValue
			self.emojiPuzzleLabel.alpha = alphaValue
			self.checkButton.alpha = alphaValue
			self.leftPuzzleLabel.alpha = alphaValue
			self.rightPuzzleLabel.alpha = alphaValue
		}
	}
	
	func enableNxtBtn(_ enabled: Bool = true) {
		if enabled {
			nextButton.isEnabled = true
			nextButton.alpha = 1
		} else {
			nextButton.isEnabled = false
			nextButton.alpha = 0.5
		}
	}
}
