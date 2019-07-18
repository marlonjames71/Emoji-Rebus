//
//  PuzzleController.swift
//  Emoji Rebus
//
//  Created by Marlon Raskin on 7/17/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import Foundation

class PuzzleController {
	var puzzles: [Puzzle]
	
	init() {
		puzzles = [
				Puzzle(puzzle: "❤️ ✉️", answer: "Love letter", hint: "Send this to your special someone"),
				Puzzle(puzzle: "🔨 🕰", answer: "Hammer time", hint: "Stop!"),
				Puzzle(puzzle: "🍐 of  ☎️☎️", answer: "Pair of headphones", hint: "Listen closely..."),
				Puzzle(puzzle: "🏞 🎮", answer: "View Controller", hint: "We use these in Xcode"),
				Puzzle(puzzle: "🛣 🕑 🔥", answer: "Highway to hell", hint: "pAy C⚡️ose attention to Da Clock"),
				Puzzle(puzzle: "👔 🆔 ⬆️", answer: "Tidy up", hint: "Your mom has probably told you this many times"),
				Puzzle(puzzle: "🎤 💧", answer: "Mic drop", hint: "I'm out!"),
				Puzzle(puzzle: "🐻 🏨 🧠", answer: "Bear in mind", hint: "Holiday ___"),
				Puzzle(puzzle: "🎫 ⛺️⛺️", answer: "Past Tense", hint: "You might need one of these to get backstage"),
				Puzzle(puzzle: "📞 🕑 🎬", answer: "Call to action", hint: "Stop thinking about it")
				]
	}
}


