//
//  ViewController.swift
//  3072
//
//  Created by Jaden Donald on 10/14/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var a1: UILabel!
    @IBOutlet weak var a2: UILabel!
    @IBOutlet weak var a3: UILabel!
    @IBOutlet weak var a4: UILabel!
    @IBOutlet weak var b1: UILabel!
    @IBOutlet weak var b2: UILabel!
    @IBOutlet weak var b3: UILabel!
    @IBOutlet weak var b4: UILabel!
    @IBOutlet weak var c1: UILabel!
    @IBOutlet weak var c2: UILabel!
    @IBOutlet weak var c3: UILabel!
    @IBOutlet weak var c4: UILabel!
    @IBOutlet weak var d1: UILabel!
    @IBOutlet weak var d2: UILabel!
    @IBOutlet weak var d3: UILabel!
    @IBOutlet weak var d4: UILabel!
    

    @IBOutlet weak var score: UILabel!
    
    var squareList: Array<UILabel> = Array()
    
    @IBOutlet weak var Highscore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.re)
        squareList = [a1, a2, a3, a4, b1, b2, b3, b4, c1, c2, c3, c4, d1, d2, d3, d4]
        
        SpawnRandomNumber()
    }
    
    
    @IBAction func RightSwipe(_ sender: UISwipeGestureRecognizer) {
        SwipeRight()
    }
    
    @IBAction func LeftSwipe(_ sender: UISwipeGestureRecognizer) {
        SwipeLeft()
    }
    
    @IBAction func UpSwipe(_ sender: UISwipeGestureRecognizer) {
        SwipeUp()
    }
    
    @IBAction func DownSwipe(_ sender: UISwipeGestureRecognizer) {
        SwipeDown()
    }

    
    func GetHighestNumber()
    {
        var highestNumber = 0
        for square in squareList
        {
            if let number = Int(square.text!)
            {
                if number > highestNumber
                {
                    highestNumber = number
                }
            }
        }
        score.text = String(highestNumber)
        
        if (UserDefaults.standard.value(forKey: "highscore") == nil)
        {
            UserDefaults.standard.set(highestNumber, forKey: "highscore")
        }
        else
        {
            let highscore = UserDefaults.standard.value(forKey: "highscore") as! Int
            if (highscore < highestNumber)
            {
                UserDefaults.standard.set(highestNumber, forKey: "highscore")
            }
        }
        let highscore = UserDefaults.standard.value(forKey: "highscore") as! Int
        Highscore.text = String(highscore)
    }
    
    
    @IBAction func NewGame(_ sender: Any) {
        for square in squareList
        {
            square.text = ""
        }
        SpawnRandomNumber()
    }
    
    
    func SpawnRandomNumber()
    {
        var emptySpace = false
        for square in squareList {
            if (square.text == "")
            {
                emptySpace = true
            }
        }
        
        if (!emptySpace) { return }
        
        let randomSquare = squareList.randomElement()
        
        if (randomSquare?.text == "")
        {
            // 10% chance of spawning a 6
            if (Int.random(in: 1...10) == 1)
            {
                randomSquare?.text = "6"
            }
            else
            {
                randomSquare?.text = "3"
            }
        }
        else
        {
            SpawnRandomNumber()
        }
        GetHighestNumber()
    }
    
    func ResetZeros()
    {
        // loop through all squares and if they are 0, set them to ""
        for square in squareList {
            if (square.text == "0")
            {
                square.text = ""
            }
        }
    }


    func SwipeRight()
    {
        // get the rows
        var row1 = [Int(a1.text!), Int(a2.text!), Int(a3.text!), Int(a4.text!)]
        var row2 = [Int(b1.text!), Int(b2.text!), Int(b3.text!), Int(b4.text!)]
        var row3 = [Int(c1.text!), Int(c2.text!), Int(c3.text!), Int(c4.text!)]
        var row4 = [Int(d1.text!), Int(d2.text!), Int(d3.text!), Int(d4.text!)]

        // loop through the rows and if there is a nil, set it to 0
        for i in 0...3 {
            if (row1[i] == nil) { row1[i] = 0 }
            if (row2[i] == nil) { row2[i] = 0 }
            if (row3[i] == nil) { row3[i] = 0 }
            if (row4[i] == nil) { row4[i] = 0 }
        }

        // get rid of the zeros
        row1 = row1.filter { $0 != 0 }
        row2 = row2.filter { $0 != 0 }
        row3 = row3.filter { $0 != 0 }
        row4 = row4.filter { $0 != 0 }

        // add the zeros to the start
        while (row1.count < 4)
        {
            row1.insert(0, at: 0)
        }
        while (row2.count < 4)
        {
            row2.insert(0, at: 0)
        }
        while (row3.count < 4)
        {
            row3.insert(0, at: 0)
        }
        while (row4.count < 4)
        {
            row4.insert(0, at: 0)
        }

        MergeRight(row1: row1, row2: row2, row3: row3, row4: row4)

    }

    func MergeRight(row1 : [Int?], row2 : [Int?], row3 : [Int?], row4 : [Int?])
    {
        var row1 = row1
        var row2 = row2
        var row3 = row3
        var row4 = row4

        // check the rows from right to left and merge numbers if they are the same
        for i in (1...3).reversed() {
            if (row1[i] == row1[i-1])
            {
                row1[i] = row1[i]! * 2
                row1[i-1] = 0
            }
            if (row2[i] == row2[i-1])
            {
                row2[i] = row2[i]! * 2
                row2[i-1] = 0
            }
            if (row3[i] == row3[i-1])
            {
                row3[i] = row3[i]! * 2
                row3[i-1] = 0
            }
            if (row4[i] == row4[i-1])
            {
                row4[i] = row4[i]! * 2
                row4[i-1] = 0
            }
        }
        
        // get rid of the zeros
        row1 = row1.filter { $0 != 0 }
        row2 = row2.filter { $0 != 0 }
        row3 = row3.filter { $0 != 0 }
        row4 = row4.filter { $0 != 0 }

        // add the zeros to the start
        while (row1.count < 4)
        {
            row1.insert(0, at: 0)
        }
        while (row2.count < 4)
        {
            row2.insert(0, at: 0)
        }
        while (row3.count < 4)
        {
            row3.insert(0, at: 0)
        }
        while (row4.count < 4)
        {
            row4.insert(0, at: 0)
        }

        // set the labels
        a1.text = String(row1[0]!)
        a2.text = String(row1[1]!)
        a3.text = String(row1[2]!)
        a4.text = String(row1[3]!)
        b1.text = String(row2[0]!)
        b2.text = String(row2[1]!)
        b3.text = String(row2[2]!)
        b4.text = String(row2[3]!)
        c1.text = String(row3[0]!)
        c2.text = String(row3[1]!)
        c3.text = String(row3[2]!)
        c4.text = String(row3[3]!)
        d1.text = String(row4[0]!)
        d2.text = String(row4[1]!)
        d3.text = String(row4[2]!)
        d4.text = String(row4[3]!)

        ResetZeros()
        SpawnRandomNumber()
    }


    func SwipeLeft()
    {
        // get the rows
        var row1 = [Int(a1.text!), Int(a2.text!), Int(a3.text!), Int(a4.text!)]
        var row2 = [Int(b1.text!), Int(b2.text!), Int(b3.text!), Int(b4.text!)]
        var row3 = [Int(c1.text!), Int(c2.text!), Int(c3.text!), Int(c4.text!)]
        var row4 = [Int(d1.text!), Int(d2.text!), Int(d3.text!), Int(d4.text!)]

        // loop through the rows and if there is a nil, set it to 0
        for i in 0...3 {
            if (row1[i] == nil) { row1[i] = 0 }
            if (row2[i] == nil) { row2[i] = 0 }
            if (row3[i] == nil) { row3[i] = 0 }
            if (row4[i] == nil) { row4[i] = 0 }
        }

        // get rid of the zeros
        row1 = row1.filter { $0 != 0 }
        row2 = row2.filter { $0 != 0 }
        row3 = row3.filter { $0 != 0 }
        row4 = row4.filter { $0 != 0 }

        // add the zeros to the end
        while (row1.count < 4)
        {
            row1.append(0)
        }
        while (row2.count < 4)
        {
            row2.append(0)
        }
        while (row3.count < 4)
        {
            row3.append(0)
        }
        while (row4.count < 4)
        {
            row4.append(0)
        }

        MergeLeft(row1: row1, row2: row2, row3: row3, row4: row4)
    }

    func MergeLeft(row1 : [Int?], row2 : [Int?], row3 : [Int?], row4 : [Int?])
    {
        var row1 = row1
        var row2 = row2
        var row3 = row3
        var row4 = row4

        // check the rows from left to right and merge numbers if they are the same
        for i in 0...2 {
            if (row1[i] == row1[i+1])
            {
                row1[i] = row1[i]! * 2
                row1[i+1] = 0
            }
            if (row2[i] == row2[i+1])
            {
                row2[i] = row2[i]! * 2
                row2[i+1] = 0
            }
            if (row3[i] == row3[i+1])
            {
                row3[i] = row3[i]! * 2
                row3[i+1] = 0
            }
            if (row4[i] == row4[i+1])
            {
                row4[i] = row4[i]! * 2
                row4[i+1] = 0
            }
        }
        
        // get rid of the zeros
        row1 = row1.filter { $0 != 0 }
        row2 = row2.filter { $0 != 0 }
        row3 = row3.filter { $0 != 0 }
        row4 = row4.filter { $0 != 0 }

        // add the zeros to the end
        while (row1.count < 4)
        {
            row1.append(0)
        }
        while (row2.count < 4)
        {
            row2.append(0)
        }
        while (row3.count < 4)
        {
            row3.append(0)
        }
        while (row4.count < 4)
        {
            row4.append(0)
        }

        // set the labels
        a1.text = String(row1[0]!)
        a2.text = String(row1[1]!)
        a3.text = String(row1[2]!)
        a4.text = String(row1[3]!)
        b1.text = String(row2[0]!)
        b2.text = String(row2[1]!)
        b3.text = String(row2[2]!)
        b4.text = String(row2[3]!)
        c1.text = String(row3[0]!)
        c2.text = String(row3[1]!)
        c3.text = String(row3[2]!)
        c4.text = String(row3[3]!)
        d1.text = String(row4[0]!)
        d2.text = String(row4[1]!)
        d3.text = String(row4[2]!)
        d4.text = String(row4[3]!)

        ResetZeros()
        SpawnRandomNumber()
    }
    
    

    func SwipeUp()
    {
        // get the columns
        var col1 = [Int(a1.text!), Int(b1.text!), Int(c1.text!), Int(d1.text!)]
        var col2 = [Int(a2.text!), Int(b2.text!), Int(c2.text!), Int(d2.text!)]
        var col3 = [Int(a3.text!), Int(b3.text!), Int(c3.text!), Int(d3.text!)]
        var col4 = [Int(a4.text!), Int(b4.text!), Int(c4.text!), Int(d4.text!)]

        // loop through the columns and if there is a nil, set it to 0
        for i in 0...3 {
            if (col1[i] == nil) { col1[i] = 0 }
            if (col2[i] == nil) { col2[i] = 0 }
            if (col3[i] == nil) { col3[i] = 0 }
            if (col4[i] == nil) { col4[i] = 0 }
        }

        // get rid of the zeros
        col1 = col1.filter { $0 != 0 }
        col2 = col2.filter { $0 != 0 }
        col3 = col3.filter { $0 != 0 }
        col4 = col4.filter { $0 != 0 }

        // add the zeros to the end
        while (col1.count < 4)
        {
            col1.append(0)
        }
        while (col2.count < 4)
        {
            col2.append(0)
        }
        while (col3.count < 4)
        {
            col3.append(0)
        }
        while (col4.count < 4)
        {
            col4.append(0)
        }

        MergeUp(col1: col1, col2: col2, col3: col3, col4: col4)
    }

    func MergeUp(col1 : [Int?], col2 : [Int?], col3 : [Int?], col4 : [Int?])
    {
        var col1 = col1
        var col2 = col2
        var col3 = col3
        var col4 = col4

        // check the columns from top to bottom and merge numbers if they are the same
        for i in 0...2 {
            if (col1[i] == col1[i+1])
            {
                col1[i] = col1[i]! * 2
                col1[i+1] = 0
            }
            if (col2[i] == col2[i+1])
            {
                col2[i] = col2[i]! * 2
                col2[i+1] = 0
            }
            if (col3[i] == col3[i+1])
            {
                col3[i] = col3[i]! * 2
                col3[i+1] = 0
            }
            if (col4[i] == col4[i+1])
            {
                col4[i] = col4[i]! * 2
                col4[i+1] = 0
            }
        }
        
        // get rid of the zeros
        col1 = col1.filter { $0 != 0 }
        col2 = col2.filter { $0 != 0 }
        col3 = col3.filter { $0 != 0 }
        col4 = col4.filter { $0 != 0 }

        // add the zeros to the end
        while (col1.count < 4)
        {
            col1.append(0)
        }
        while (col2.count < 4)
        {
            col2.append(0)
        }
        while (col3.count < 4)
        {
            col3.append(0)
        }
        while (col4.count < 4)
        {
            col4.append(0)
        }

        // set the labels
        a1.text = String(col1[0]!)
        a2.text = String(col2[0]!)
        a3.text = String(col3[0]!)
        a4.text = String(col4[0]!)
        b1.text = String(col1[1]!)
        b2.text = String(col2[1]!)
        b3.text = String(col3[1]!)
        b4.text = String(col4[1]!)
        c1.text = String(col1[2]!)
        c2.text = String(col2[2]!)
        c3.text = String(col3[2]!)
        c4.text = String(col4[2]!)
        d1.text = String(col1[3]!)
        d2.text = String(col2[3]!)
        d3.text = String(col3[3]!)
        d4.text = String(col4[3]!)

        ResetZeros()
        SpawnRandomNumber()
    }


    func SwipeDown()
    {
        // get the columns
        var col1 = [Int(a1.text!), Int(b1.text!), Int(c1.text!), Int(d1.text!)]
        var col2 = [Int(a2.text!), Int(b2.text!), Int(c2.text!), Int(d2.text!)]
        var col3 = [Int(a3.text!), Int(b3.text!), Int(c3.text!), Int(d3.text!)]
        var col4 = [Int(a4.text!), Int(b4.text!), Int(c4.text!), Int(d4.text!)]

        // loop through the columns and if there is a nil, set it to 0
        for i in 0...3 {
            if (col1[i] == nil) { col1[i] = 0 }
            if (col2[i] == nil) { col2[i] = 0 }
            if (col3[i] == nil) { col3[i] = 0 }
            if (col4[i] == nil) { col4[i] = 0 }
        }

        // get rid of the zeros
        col1 = col1.filter { $0 != 0 }
        col2 = col2.filter { $0 != 0 }
        col3 = col3.filter { $0 != 0 }
        col4 = col4.filter { $0 != 0 }

        // add the zeros to the end
        while (col1.count < 4)
        {
            col1.insert(0, at: 0)
        }
        while (col2.count < 4)
        {
            col2.insert(0, at: 0)
        }
        while (col3.count < 4)
        {
            col3.insert(0, at: 0)
        }
        while (col4.count < 4)
        {
            col4.insert(0, at: 0)
        }

        MergeDown(col1: col1, col2: col2, col3: col3, col4: col4)
    }

    func MergeDown(col1 : [Int?], col2 : [Int?], col3 : [Int?], col4 : [Int?])
    {
        var col1 = col1
        var col2 = col2
        var col3 = col3
        var col4 = col4

        // check the columns from bottom to top and merge numbers if they are the same
        for i in (1...3).reversed() {
            if (col1[i] == col1[i-1])
            {
                col1[i] = col1[i]! * 2
                col1[i-1] = 0
            }
            if (col2[i] == col2[i-1])
            {
                col2[i] = col2[i]! * 2
                col2[i-1] = 0
            }
            if (col3[i] == col3[i-1])
            {
                col3[i] = col3[i]! * 2
                col3[i-1] = 0
            }
            if (col4[i] == col4[i-1])
            {
                col4[i] = col4[i]! * 2
                col4[i-1] = 0
            }
        }
        
        // get rid of the zeros
        col1 = col1.filter { $0 != 0 }
        col2 = col2.filter { $0 != 0 }
        col3 = col3.filter { $0 != 0 }
        col4 = col4.filter { $0 != 0 }

        // add the zeros to the end
        while (col1.count < 4)
        {
            col1.insert(0, at: 0)
        }
        while (col2.count < 4)
        {
            col2.insert(0, at: 0)
        }
        while (col3.count < 4)
        {
            col3.insert(0, at: 0)
        }
        while (col4.count < 4)
        {
            col4.insert(0, at: 0)
        }

        // set the labels
        a1.text = String(col1[0]!)
        a2.text = String(col2[0]!)
        a3.text = String(col3[0]!)
        a4.text = String(col4[0]!)
        b1.text = String(col1[1]!)
        b2.text = String(col2[1]!)
        b3.text = String(col3[1]!)
        b4.text = String(col4[1]!)
        c1.text = String(col1[2]!)
        c2.text = String(col2[2]!)
        c3.text = String(col3[2]!)
        c4.text = String(col4[2]!)
        d1.text = String(col1[3]!)
        d2.text = String(col2[3]!)
        d3.text = String(col3[3]!)
        d4.text = String(col4[3]!)

        ResetZeros()
        SpawnRandomNumber()
    }
}
