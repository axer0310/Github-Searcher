//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Arthur on 2017/3/2.
//  Copyright © 2017年 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {

    @IBOutlet var slider: UISlider!
    @IBOutlet var starCount: UILabel!
    var count: Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.value = Float(RepoResultsViewController.count)
        starCount.text! = "\(Int(slider.value))"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    @IBAction func sliderChanged(_ sender: Any)
    {
        let slidder = sender as! UISlider
        var currentValue = Int( slidder.value)
        starCount.text! = "\(currentValue)"
        count = currentValue
    }

    @IBAction func onSave(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        RepoResultsViewController.count = self.count
    }

    
    @IBAction func onCancel(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
