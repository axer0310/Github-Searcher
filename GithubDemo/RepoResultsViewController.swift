//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()
    static var count:Int = 0
    var num:Int = 0
    @IBOutlet var tableView: UITableView!
    
    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
 
        
        // Perform the first search when the view controller first loads
        
        doSearch()
        
        
        
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                               print(repo)
            }
            self.repos = newRepos
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if  repos != nil
        {
            self.num = 0;
            for repo in repos
            {
                if ( Int(repo.stars!) >= RepoResultsViewController.count)
                {
                    self.num += 1;
                }
                
                
            }

            if(RepoResultsViewController.count != 0)
            {
                return self.num
            }
            else
            {
                return repos.count;
            }
        }
        else
        {
            return 0;
        }
        
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoTableViewCell", for: indexPath) as! TableViewCell;
        cell.repo = repos[indexPath.row]
        
        if(Int(cell.starCount.text!)! > RepoResultsViewController.count)
        {
            return cell;
        }
        var emptyCell = tableView.dequeueReusableCell(withIdentifier: "repoTableViewCell", for: indexPath) as! TableViewCell;
        return emptyCell
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.tableView.reloadData()
    }
    
}



// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
