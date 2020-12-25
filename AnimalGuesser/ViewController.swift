//
//  ViewController.swift
//  HelloWorld
//
//  Created by Jibeom Bae on 2020-07-01.
//  Copyright © 2020 Jibeom Bae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(getDataForDate(animal: "Human"))
        setup()
        
    }
    
    func setup() {
        restartButton.isHidden = true
        createAnimal("polarbear", false, true, true, true, false, false, false)
        createAnimal("human", false, false, true, false, true, false, false)
        createAnimal("mosquito", false, false, true, false, false, true, true)
        createAnimal("platypus", false, true, true, false, false, true, false)
        createAnimal("cardinal", false, false, false, false, true, true, true)
        createAnimal("alligator", false, false, true, true, false, true, false)
        createAnimal("goat", true, true, false, false, false, false, false)
        createAnimal("whale", false, false, true, false, false, false, false)
        createAnimal("flyingsquirrel", false, true, false, false, false, false, true)
        
        currentQuestion = getCurrentIndex(animals)
        QuestionLabel.text = questions[currentQuestion]
    }
    
    @IBAction func yesTapped(_ sender: Any) {
        eliminateAnimals(currentQuestion, true)
        if !animalFound{
            QuestionLabel.text = questions[currentQuestion]
        }
        
        
    }
    
    
    @IBAction func noTapped(_ sender: Any) {
        eliminateAnimals(currentQuestion, false)
        if !animalFound{
            QuestionLabel.text = questions[currentQuestion]
        }
        
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        currentQuestion = 0
        answers = []
        selectedAnimal = []
        animals = []
        animalFound = false
        yesButton.isHidden = false
        noButton.isHidden = false
        setup()
    }
    
    
    
    var questions: [String] = ["Does your animal have horns?",
    "Does your animal have fur?",
    "Does your animal enjoy being in water?",
    "Is your animal potentially dangerous towards humans",
    "Can your animal whistle?",
    "Does your animal lay eggs?",
    "Can your animal fly?"]
    var currentQuestion = 0
    var answers: [Bool] = []
    var selectedAnimal: [Animal] = []
    var animals: [Animal] = []
    var animalFound = false
    
//    func getSwiftArrayFromPlist(name: String)->(Array<Dictionary<String,String>>)
//    {
//        let path = Bundle.main.path(forResource: name, ofType: "plist")
//        var arr : NSArray?
//        arr = NSArray(contentsOfFile: path!)
//        return (arr as? Array<Dictionary<String,String>>)!
//    }
//
//    func getDataForDate(animal:String)->(Array<[String:String]>)
//    {
//        let array = getSwiftArrayFromPlist(name: "animalData")
//        let namePredicate = NSPredicate( format: "Animal = %@", animal)
//        return [array.filter {namePredicate.evaluate(with: $0)}[0]]
//    }
    
    func createAnimal( _ name:String, _ horns:Bool, _ fur:Bool, _ likeswater:Bool, _ dangerous:Bool, _ whistle:Bool, _ eggs:Bool, _ flies:Bool){
        
        let newAnimal = Animal()
        newAnimal.name = name
        newAnimal.horns = horns
        newAnimal.fur = fur
        newAnimal.likeswater = likeswater
        newAnimal.dangerous = dangerous
        newAnimal.whistle = whistle
        newAnimal.eggs = eggs
        newAnimal.flies = flies
        
        animals.append(newAnimal)
    }
    
    func getCurrentIndex(_ animals: [Animal]) -> Int {
        var aHorns = 0
        var aFur = 0
        var aLikesWater = 0
        var aDangerous = 0
        var aWhistle = 0
        var aEggs = 0
        var aFlies = 0
        
        for animal in animals{
            if animal.horns{
                aHorns += 1
            }
            if animal.fur{
                aFur += 1
            }
            if animal.likeswater{
                aLikesWater += 1
            }
            if animal.dangerous{
                aDangerous += 1
            }
            if animal.whistle{
                aWhistle += 1
            }
            if animal.eggs{
                aEggs += 1
            }
            if animal.flies{
                aFlies += 1
            }
            
        }
        let idealQuestions = (animals.count) / 2
        let a: [Int] = [aHorns, aFur, aLikesWater, aDangerous, aWhistle, aEggs, aFlies]
        var lowestValue = abs(a[0] - idealQuestions)
        var lowestIndex = 0
        
        for n in 0...a.count-1{
            if abs(a[n] - idealQuestions) < lowestValue{
                lowestValue = abs(a[n] - idealQuestions)
                lowestIndex = n
            }
        }
        
        return lowestIndex
        
    }
    
    func eliminateAnimals( _ question:Int, _ ans:Bool){
        var newAnimals:[Animal] = []
        
        for animal in animals{
            let attributes:[Bool] = [animal.horns, animal.fur, animal.likeswater, animal.dangerous, animal.whistle, animal.eggs, animal.flies]
            
            if attributes[question] == ans{
                newAnimals.append(animal)
            }
        }
        animals = newAnimals
        currentQuestion = getCurrentIndex(animals)
        if animals.count == 1{
            endStatement()
           
        }
    }
    
    func endStatement(){
        animalFound = true
        QuestionLabel.text = "The animal is " + animals[0].name
        yesButton.isHidden = true
        noButton.isHidden = true
        restartButton.isHidden = false
        
    }

}

class Animal {
    var name = ""
    var horns = true
    var fur = true
    var likeswater = true
    var dangerous = true
    var whistle = true
    var eggs = true
    var flies = true
    //var scales = true
    //var feathers = true
    //var omnivore = true
    //var carnivore = true
    //var quadrupedal = true
    //var toes = true
    //var heards = true
    //var livesforest = true
    //var livestree = true
    //var nocturnal = true
    //var small = true
    //var milk = true
    
    
    
}

