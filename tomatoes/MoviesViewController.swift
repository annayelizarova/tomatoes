//
//  MoviesViewController.swift
//  tomatoes
//
//  Created by Anna Yelizarova on 4/11/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies: [NSDictionary]! = [NSDictionary]()
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for network error
//        let frame = CGRectMake(0, 0, 330, 50)
//        let subview = UIView(frame: frame)
//        self.tableView.addSubview(subview)
//        subview.backgroundColor = UIColor.yellowColor()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=ta5dbe46br3y5s3enkz2nxk9&country=us")!
        var request = NSURLRequest(URL:url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){(response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = json["movies"] as [NSDictionary]
            self.tableView.reloadData()
    }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func refresh(sender:AnyObject)
    {
        // Updating your data here...
        var url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=ta5dbe46br3y5s3enkz2nxk9&country=us")!
        var request = NSURLRequest(URL:url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()){(response:NSURLResponse!, data:NSData!, error:NSError!) -> Void in
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = json["movies"] as [NSDictionary]
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self

        
        self.refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // 1
        var nav = self.navigationController?.navigationBar
        // 2
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        // 3
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .ScaleAspectFit
//        // 4
//        let image = UIImage(named: "Apple_Swift_Logo")
//        imageView.image = image
//        // 5
//        navigationItem.titleView = imageView
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("My Movie Cell", forIndexPath: indexPath) as MovieCell
        
        var movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var url = movie.valueForKeyPath("posters.thumbnail") as? String
        cell.posterView.setImageWithURL(NSURL(string: url!)!)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var movieDetailViewController = segue.destinationViewController as MovieDetailViewController
        var cell = sender as UITableViewCell
        var indexPath = tableView.indexPathForCell(cell)!
        movieDetailViewController.movie = movies[indexPath.row]
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

