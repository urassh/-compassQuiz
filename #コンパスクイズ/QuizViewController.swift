//
//  QuizViewController.swift
//  #コンパスクイズ
//
//  Created by 浦山秀斗 on 2021/09/29.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var quizNumberLabel: UILabel!
    @IBOutlet weak var quizTextView: UITextView!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var judgeImageView: UIImageView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    //クイズの問題番号と正解数を数える変数
    var quizCount = 0
    var trueCount = 0
    //ランダムに関する空配列
    var NumberList = [Int]()
    var ramdomList = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        csvArray = loadCSV(fileName: "Rarity_quiz")
        //ランダムにする処理
        for i in 0..<csvArray.count {
            NumberList += [i]
        }
        ramdomList = NumberList.shuffled()
        
        self.setQuiz()
        // Do any additional setup after loading the view.
    }
    
    //ScoreViewControllerに問題数と正解数を送る。
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toScoreVC" {
            let score_view = segue.destination as! ScoreViewController
            score_view.result = trueCount
            score_view.allQuiz = quizCount
        }
    }
    
    @IBAction func btn(_ sender: UIButton) {
        if sender.tag == Int(quizArray[1]){
            //正解の時の処理
            trueCount += 1
            judgeImageView.image = UIImage(named: "correct")
            print("正解")
        } else {
            //不正解の処理
            judgeImageView.image = UIImage(named: "incorrect")
            print("不正解")
        }
        //2回タップを防ぐ処理
        judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
        }
    }
    
    func setQuiz() {
        quizArray = csvArray[ramdomList[quizCount]].components(separatedBy: ",")
        quizNumberLabel.text = "第\(quizCount + 1)問"
        quizTextView.text = quizArray[0]
        answerButton1.setTitle(quizArray[2], for: .normal)
        answerButton2.setTitle(quizArray[3], for: .normal)
        answerButton3.setTitle(quizArray[4], for: .normal)
        answerButton4.setTitle(quizArray[5], for: .normal)
    }
    
    func nextQuiz() {
        quizCount += 1
        if quizCount < csvArray.count {
            self.setQuiz()
        } else {
            performSegue(withIdentifier: "toScoreVC", sender: nil)
            if trueCount == quizCount {
                print("全問正解しました。")
            } else if trueCount == 0{
                print("全問不正解でした。")
            } else {
                 print("\(trueCount)問正解しました。")
            }
             
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("error")
        }
        return csvArray
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
