//
//  main.swift
//  BeggarYourNeighbour
//
//  Created by Russell Gordon on 12/14/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import Foundation

// Create an enumeration for the suits of a deck of cards
enum Suit : String {
	
	case hearts     = "❤️"
	case diamonds   = "♦️"
	case spades     = "♠️"
	case clubs      = "♣️"
	
	// Given a value, returns the suit
	static func glyph(forHashValue : Int) -> String {
		switch forHashValue {
		case 0 :
			return Suit.hearts.rawValue
		case 1 :
			return Suit.diamonds.rawValue
		case 2 :
			return Suit.spades.rawValue
		case 3 :
			return Suit.clubs.rawValue
		default:
			return Suit.hearts.rawValue
		}
	}
	
}

// Create a new datatype to represent a playing card
struct Card {
	
	var value : Int
	var suit : Int
	
	// Initializer accepts arguments to set up this instance of the struct
	init(value : Int, suit : Int) {
		self.value = value
		self.suit = suit
	}
	
}

// Initalize a deck of cards
var deck : [Card] = []
/*
var playerHand : [Card] = []
var computerHand : [Card] = []
var computerHand : [Card] = []
var computerHand : [Card] = []
*/
var hands = [[Card]]()
var players = 0;

var _response = ""
while _response == "" {
	print("Enter amount of players (2-4)")
	_response = readLine()!
	if _response != "2" && _response != "3" && _response != "4" {
		_response = ""
	}
}

func shuffleCards() {
	deck.removeAll()
	for i in 0...players-1 {
		hands[i].removeAll;
	}
	for suit in 0...3 {
		for value in 2...14 {
			let card = Card(value: value, suit: suit)
			deck.append(card)
		}
	}
	
	// Iterate over the deck of cards
	for card in deck {
		print("Suit is \(Suit.glyph(forHashValue: card.suit)) and value is \(card.value)")
	}
	
	// Initialize hands
	// MARK: Initialization
	
	// "Shuffle" the deck and give half the cards to the player
	while deck.count > 26 {
		
		// Generate a random number between 0 and the count of cards still left in the deck
		let position = Int(arc4random_uniform(UInt32(deck.count)))
		
		// Copy the card in this position to the player's hand
		playerHand.append(deck[position])
		
		// Remove the card from the deck for this position
		deck.remove(at: position)
		
	}
	while deck.count > 0 {
		
		// Generate a random number between 0 and the count of cards still left in the deck
		let position = Int(arc4random_uniform(UInt32(deck.count)))
		
		// Copy the card in this position to the player's hand
		computerHand.append(deck[position])
		
		// Remove the card from the deck for this position
		deck.remove(at: position)
		
	}
}

// MARK: User Input
print("Enter to play next hand, or Q to exit")
var nextIteration = true
var playerWin = false

func cardValue(value: Int) -> String {
	switch value {
	case 11:
		return("Jack")
	case 12:
		return("Queen")
	case 13:
		return("King")
	case 14:
		return("Ace")
	default:
		return("\(value)")
	}
}

var iterations : CUnsignedLong = 0
print("Enter to play next hand, or Q to exit")
nextIteration = true
shuffleCards()
while playerHand.count > 0 && computerHand.count > 0 && nextIteration {
	var response = " "
	while response != "" && response != "Q" {
		response = readLine()!
		if response.lowercased() == "wake me up" {
			print("\nWake me up inside")
			print("Can't wake up\n")
		} else if (response != "Q" && response != "") {
			print("Enter to play next hand, or Q to exit")
		}
	}
	nextIteration = !(response == "Q")
	if nextIteration {
		iterations += 1
		print("Player flips \(cardValue(value: playerHand[0].value)) of \(Suit.glyph(forHashValue: playerHand[0].suit))")
		if "\(playerHand[0].value)" != cardValue(value: playerHand[0].value) { // If the card is a face card
			for i in 0...(playerHand[0].value-11) {
				print("Computer flips \(cardValue(value: computerHand[0].value)) of \(Suit.glyph(forHashValue: computerHand[0].suit))")
			}
		}
		print("Computer flips \(cardValue(value: computerHand[0].value)) of \(Suit.glyph(forHashValue: computerHand[0].suit))")
		if "\(computerHand[0].value)" != cardValue(value: computerHand[0].value) { // If the card is a face card
			for i in 0...(computerHand[0].value-11) {
				print("Player flips \(cardValue(value: playerHand[0].value)) of \(Suit.glyph(forHashValue: playerHand[0].suit))")
			}
		}
	}
}
let winner = playerWin ? "Player" : "Computer"
print("The \(winner) won this game!")
print("ITERATIONS: \(iterations)")
