//
//  ScoreViewController.swift
//  #コンパスクイズ
//
//  Created by 浦山秀斗 on 2021/09/26.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    var result = 0
    var allQuiz = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if result == allQuiz {
            score.text = "全問正解しました！"
        } else if (result == 0 ) {
            score.text = "全問不正解でした..."
        } else {
            score.text = "\(allQuiz)問中\(result)問正解!"
        }
        
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
