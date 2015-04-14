//
//  MovieDetailViewController.swift
//  tomatoes
//
//  Created by Anna Yelizarova on 4/12/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: NSDictionary!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var bgImage: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as String
        synopsisLabel.text = movie["synopsis"] as String
        // Do any additional setup after loading the view.
        var url = movie.valueForKeyPath("posters.thumbnail") as? String
        bgImage.setImageWithURL(NSURL(string: url!)!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
 