//
//  QuestionVC.swift
//  BasketballTrivia
//
//  Created by IOS on 03/03/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import GoogleMobileAds


class QuestionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var adBannerView: GADBannerView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tblQuestion: UITableView!
    
    @IBOutlet weak var lblQuestionNumber: UILabel!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var lblResultMessage: UILabel!
    
    @IBOutlet weak var lblCorrectAnswers: UILabel!
    
    @IBOutlet weak var btnPlayAgain: UIButton!
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    var questionNumber = 1
    var correctAnswer = ""
    var wrongAnswer = ""
    var correctQuestions = 0
    
    var seconds = 20
    var timer = Timer()
    var isTimerRunning = false
    var score = 0
    var secondsLeft = 0
    var level = 1
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblQuestion.register(UINib.init(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCellReuse")
        tblQuestion.register(UINib.init(nibName: "AnswerOptionCell", bundle: nil), forCellReuseIdentifier: "AnswerOptionCellReuse")
        
        tblQuestion.delegate = self
        tblQuestion.dataSource = self
        
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        btnPlayAgain.layer.borderColor = UIColor.black.cgColor
        btnPlayAgain.layer.borderWidth = 0.5
        btnPlayAgain.layer.cornerRadius = btnPlayAgain.frame.size.height/2
        btnPlayAgain.clipsToBounds = true
        
        
        lblQuestionNumber.text = "\(questionNumber)/10"
        getQuestions()
        self.resultView.isHidden = true
        self.btnSubmit.isHidden = false
        
        adBannerView.adUnitID = "ca-app-pub-2483571791994176/5498549479"
              adBannerView.rootViewController = self
              adBannerView.load(GADRequest())
        
        
       // Do any additional setup after loading the view.
    }
    
    func getQuestions()
    {
        
        let dict = NSDictionary()
        apiManager.callApi.getApiRequest(controller: self, method: "http://kistchatstorage.com/BasketballTrivia/getQuestionsForLevel.php?level=\(BBallTriviaSingleton.shared.level)", parameters: dict, completionHandler: { (response, status) in
            
            
            if status
            {
                
                BBallTriviaSingleton.shared.QuestionArray = response?.value(forKey: "data") as? [[String:String]] ?? []
                DispatchQueue.main.async {
                    self.tblQuestion.reloadData()
                    self.runTimer()
                }
            }
        })
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        if seconds > 0
        {
            seconds -= 1     //This will decrement(count down)the seconds.
            lblTimer.text = "\(seconds)" //This will update the label.
        }
        else
        {
            if correctAnswer == ""
            {
                var myDict = NSMutableDictionary()
                if BBallTriviaSingleton.shared.QuestionArray.count > 0
                {
                    myDict = (BBallTriviaSingleton.shared.QuestionArray[questionNumber - 1] as AnyObject).mutableCopy() as! NSMutableDictionary
                    if let _ =  myDict.value(forKey: "answer")
                    {
                        correctAnswer = String(describing: myDict.value(forKey: "answer")!)
                    }
                    
                }
                
                tblQuestion.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var myDict = NSMutableDictionary()
        if BBallTriviaSingleton.shared.QuestionArray.count > 0
        {
            myDict = (BBallTriviaSingleton.shared.QuestionArray[questionNumber - 1] as AnyObject).mutableCopy() as! NSMutableDictionary
            
            
        }
        
        if indexPath.row == 0
        {
            let cell = tblQuestion.dequeueReusableCell(withIdentifier: "QuestionCellReuse", for: indexPath) as! QuestionCell
            if let _ =  myDict.value(forKey: "question")
            {
                cell.lblQuestion.text = String(describing: myDict.value(forKey: "question")!)
            }
            return cell
        }
        else if indexPath.row == 1
        {
            let cell = tblQuestion.dequeueReusableCell(withIdentifier: "AnswerOptionCellReuse", for: indexPath) as! AnswerOptionCell
            cell.backgroundColor = UIColor.white
            if let _ =  myDict.value(forKey: "optionA")
            {
                cell.lblAnswer.text = String(describing: myDict.value(forKey: "optionA")!)
            }
            if cell.lblAnswer.text! == correctAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.green
            }
            else if cell.lblAnswer.text! == wrongAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        else if indexPath.row == 2
        {
            let cell = tblQuestion.dequeueReusableCell(withIdentifier: "AnswerOptionCellReuse", for: indexPath) as! AnswerOptionCell
            cell.backgroundColor = UIColor.white
            if let _ =  myDict.value(forKey: "optionB")
            {
                cell.lblAnswer.text = String(describing: myDict.value(forKey: "optionB")!)
            }
            
            if cell.lblAnswer.text! == correctAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.green
            }
            else if cell.lblAnswer.text! == wrongAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        else if indexPath.row == 3
        {
            let cell = tblQuestion.dequeueReusableCell(withIdentifier: "AnswerOptionCellReuse", for: indexPath) as! AnswerOptionCell
            cell.backgroundColor = UIColor.white
            if let _ =  myDict.value(forKey: "optionC")
            {
                cell.lblAnswer.text = String(describing: myDict.value(forKey: "optionC")!)
            }
            if cell.lblAnswer.text! == correctAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.green
            }
            else if cell.lblAnswer.text! == wrongAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        else
        {
            let cell = tblQuestion.dequeueReusableCell(withIdentifier: "AnswerOptionCellReuse", for: indexPath) as! AnswerOptionCell
            cell.backgroundColor = UIColor.white
            if let _ =  myDict.value(forKey: "optionD")
            {
                cell.lblAnswer.text = String(describing: myDict.value(forKey: "optionD")!)
            }
            if cell.lblAnswer.text! == correctAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.green
            }
            else if cell.lblAnswer.text! == wrongAnswer && correctAnswer != ""
            {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        secondsLeft = Int("\(lblTimer.text!)")!
        var value = 0
        if indexPath.row > 0
        {
            if correctAnswer == ""
            {
                var myDict = NSMutableDictionary()
                if BBallTriviaSingleton.shared.QuestionArray.count > 0
                {
                    myDict = (BBallTriviaSingleton.shared.QuestionArray[questionNumber - 1] as AnyObject).mutableCopy() as! NSMutableDictionary
                    if let _ =  myDict.value(forKey: "answer")
                    {
                        correctAnswer = String(describing: myDict.value(forKey: "answer")!)
                        value = Int(String(describing: myDict.value(forKey: "value")!))!
                    }
                    
                }
                let cell = tblQuestion.cellForRow(at: indexPath) as! AnswerOptionCell
                if cell.lblAnswer.text! == correctAnswer
                {
                    wrongAnswer = ""
                    score += secondsLeft * value
                    correctQuestions += 1
                }
                else
                {
                    wrongAnswer = cell.lblAnswer.text!
                }
                timer.invalidate()
                seconds = 20
                tblQuestion.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 70
        }
        else
        {
            return 50
        }
    }
    
    
    @IBAction func submit_action(_ sender: Any) {
        
        if questionNumber < 10
        {
            if correctAnswer != ""
            {
                timer.invalidate()
                seconds = 20
                runTimer()
                correctAnswer = ""
                wrongAnswer = ""
                questionNumber = questionNumber + 1
                lblQuestionNumber.text = "\(questionNumber)/10"
                
                tblQuestion.reloadData()
                
                
                print ("score: \(score)")
            }
            else
            {
                BBallTriviaSingleton.shared.showAlert(title: "Alert", message: "Please select an option first!!", twoBtn: false, btn1: "Ok", btn2: "", VC: self)
            }
            
        }
        else
        {
            if correctQuestions >= 7
            {
                lblResultMessage.text = "Congratulations!!! You have successfully cleared level \(BBallTriviaSingleton.shared.level)"
                lblCorrectAnswers.text = "Correct Answers: \(correctQuestions)"
                lblScore.text = "Your score is: \(score)"
                BBallTriviaSingleton.shared.level = BBallTriviaSingleton.shared.level + 1
                btnPlayAgain.setTitle("Play Next Level", for: .normal)
            }
            else
            {
                lblResultMessage.text = "Sorry!! You have failed level:  \(BBallTriviaSingleton.shared.level)"
                lblCorrectAnswers.text = "Correct Answers: \(correctQuestions)"
                lblScore.text = "Your score is: \(score)"
                btnPlayAgain.setTitle("Play Again", for: .normal)
            }
            self.btnSubmit.isHidden = true
            self.resultView.isHidden = false
            
        }
    }
    
    @IBAction func playAgain_action(_ sender: Any) {
        //        if correctQuestions >= 7
        //        {
        //
        //        }
        //        else
        //        {
        //
        //        }
       
                
        self.btnSubmit.isHidden = false
        self.resultView.isHidden = true
        questionNumber = 1
        lblQuestionNumber.text = "\(questionNumber)/10"
        correctAnswer = ""
        wrongAnswer = ""
        correctQuestions = 0
        seconds = 20
        score = 0
        secondsLeft = 0
        getQuestions()
        tblQuestion.reloadData()
    }
    
}
