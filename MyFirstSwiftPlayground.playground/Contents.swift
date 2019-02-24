//: Playground - noun: a place where people can play

/*
 My playground tries to recreate a very simplified version of the game of Chinese Whispers. Chinese Whispers is the game where players sit in a line and a message is passed from the first person in the line to the next and so on until the end of the line where the message(or the usually distorted version of it) is revealed.
 The players are created as different instances of the Class Player, the message is coded into the property “message”. Loss of transmission is modeled using the method “transmissionDistortion”.
 */

import UIKit
import Foundation

class Player {
    var name: String
    var message: String =  " "
    var mutationsDictionary = ["Reinforce":"Regis ghost", "pavements":"says mints", "concrete": "not neat","alien":"Alsatian","with":"are"]
    
    init(name: String) {
        self.name = name
    }
    
    func introduction() -> String {
        return "Hi! My name is \(name)."
    }
    
    func transmissionDistortion() {
        
        //split message into array of words
        let messageArray  = message.components(separatedBy: " ")
        
        let numberOfWords = messageArray.count
        
        //pick a random word in the message
        let n: Int = numberOfWords - 1
        let index: Int = Int(arc4random_uniform(UInt32(n)))
        let word = messageArray[index]
        
        /*Check dictionary if mutation exists for this word. Apply mutation if it exists */
        if mutationsDictionary[word] != nil {
            let replaced = message.replacingOccurrences(of: word, with:mutationsDictionary[word]!)
            message = replaced
        }
    }
}

let originalMessage      = "Reinforce pavements with concrete said the alien from Jupiter"
let playerNames          = ["Josh", "Tom", "Nina", "Mike", "Steve", "Gary", "Joan", "Elise", "Mark", "Susie"]
var numberOfPlayers: Int = playerNames.count
var groupOfPlayers       = [Player]()
var count: Int           = 0

groupOfPlayers.append(Player(name:playerNames[count]))
groupOfPlayers[count].message = originalMessage

count = count + 1

while (count < numberOfPlayers){
    
    groupOfPlayers.append(Player(name: playerNames[count]))
    groupOfPlayers[count].message = groupOfPlayers[count - 1].message //pass on message
    groupOfPlayers[count].transmissionDistortion() //message heard as
    
    count = count + 1
}

print("Original message was:")
print("\(originalMessage).")
print("Message at the end of the line was:")
print("\(groupOfPlayers[numberOfPlayers - 1].message).")

/*
 Output:
 
 "Original message was:\n"
 "Reinforce pavements with concrete said the alien from Jupiter.\n"
 "Message at the end of the line was:\n"
 "Regis ghost says mints are concrete said the Alsatian from Jupiter.\n"
 
 */
