

import UIKit
class WinnerViewController: UIViewController {

    @IBOutlet weak var WinnerImageView: UIImageView!
    
    var challenge_id = ""
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        WinnerImageView.clipsToBounds = true
        // Do any additional setup after loading the view.
        getChallengeData()
    }
    

   
    @IBAction func backAction(_ sender: Any) {
            let StoryObj = UIStoryboard(name: "Main", bundle: nil)
            let vcobj = StoryObj.instantiateViewController(withIdentifier: "ChallengeRMadeViewController") as! ChallengeRMadeViewController
            vcobj.isComingFromWinnerViewController = true
            self.navigationController?.pushViewController(vcobj, animated: true)
    }
    
    
    func getChallengeData() {
        var DicInput = [String:AnyObject]()
        DicInput = ["challenge_id":self.challenge_id as AnyObject]
        print("DicInput:",DicInput)
        WebHelper.requestPostUrl(strURL: GlobalConstant.cahllenge_winner, Dictionary: DicInput, Success: {success in
            print("Success:",success)
            let status = String(describing: success.value(forKey: "status")!)
            if status == "1"{
                
            }
            else if status == "0"{
                
            }
        }, Failure: {failler in
            print("something went wrong",failler.localizedDescription)
        })
        
    }
    
    
    
    
}
