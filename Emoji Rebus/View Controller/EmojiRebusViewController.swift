//
//  TestViewController.swift
//  Emoji Rebus
//
//  Created by Marlon Raskin on 7/16/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

enum Result: String {
	case correct = "Correct!"
	case incorrect = "Wrong!"
}

class EmojiRebusViewController: UIViewController, UITextFieldDelegate {

	let happyEmojis = "😜 😁 🤪 😉".split(separator: " ").map { String($0) }
	let angryEmojis = "😡 🤬 🤯 😱 🤮 🤢".split(separator: " ").map { String($0) }

	let puzzleController = PuzzleController()
	var puzzleIndex = 0
	
	@IBOutlet weak var resultEmojiLabel: UILabel!
	@IBOutlet weak var emojiPuzzleLabel: UILabel!
	@IBOutlet weak var levelLabel: UILabel!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var hintLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	
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
		levelLabel.text = "\(puzzleIndex + 1)/10"
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
		levelLabel.text = "\(puzzleIndex + 1)/10"
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
			resultEmojiLabel.text = happyEmojis.randomElement()
			enableNxtBtn()
		} else {
			resultEmojiLabel.text = angryEmojis.randomElement()
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
