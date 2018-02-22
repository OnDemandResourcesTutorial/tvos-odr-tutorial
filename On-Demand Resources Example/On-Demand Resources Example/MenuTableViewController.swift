//
//  MenuTableViewController.swift
//  On-Demand Resources Example
//
//  Created by Ricardo Rachaus on 15/02/18.
//  Copyright © 2018 Apple Developer Academy UCB. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    // MARK: - Properties
    
    /// Array that holds the celebrities names and their tags.
    var celebrities: [String]!
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        celebrities = ["Will Smith", "The Rock", "Zac Efron", "Hugh Jackman", "Alexandra Daddario",
                       "Scarlett Johansson", "James Hetfield", "Jennifer Aniston", "Chris Brown", "Courteney Cox"]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return celebrities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCell
        
        cell.textLabel?.text = celebrities[indexPath.row]
        cell.progressView.isHidden = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuCell
        
        // Hide the label and presents the progress view during download.
        cell.isDownloaded.isHidden = true
        cell.progressView.isHidden = false
        
        // Request assets according to the tag passed of the array in the position selected.
        ODRManager.shared.requestImage(with: celebrities[indexPath.row], onSuccess: {
            OperationQueue.main.addOperation {
                cell.progressView.isHidden = true
                cell.isDownloaded.isHidden = false
                cell.isDownloaded.text = "Downloaded"
                self.performSegue(withIdentifier: "ClickedSegue", sender: indexPath)
            }
        }) { (error) in
            // It's a good practice show a visual feedback to the user about the error.
            let controller = UIAlertController(title: "Error", message: "There was an error", preferredStyle: .alert)
            
            switch error.code{
            case NSBundleOnDemandResourceOutOfSpaceError:
                controller.message = "You don't have enough space available to donwload this resource"
                
            case NSBundleOnDemandResourceExceededMaximumSizeError:
                controller.message = "The bundle resource was too big"
                
            case NSBundleOnDemandResourceInvalidTagError:
                controller.message = "The requested tag does not exist"
                
            default:
                controller.message = error.description
            }
            
            controller.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            guard let rootViewController = self.view.window?.rootViewController else { return }
            
            rootViewController.present(controller, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Segue Methods
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClickedSegue" {
            let celebrityViewController = segue.destination as! CelebrityViewController
            celebrityViewController.navigationItem.title = celebrities[(sender as! IndexPath).row]
        }
    }
}


// MARK: - ODRManager

/**
 On-Demand Resource Manager
 */
class ODRManager {
    /// Hold the instance of the singleton.
    static let shared = ODRManager()
    
    /// The current resource requested.
    var currentRequest: NSBundleResourceRequest?
    
    
    /**
        Request the image from the server.
     
        - parameters:
            - tag: Name of the tag.
            - onSuccess: Completion to handle the success.
            - onFailure: Completion to handle the failure.
     */
    func requestImage(with tag: String, onSuccess: @escaping () -> Void, onFailure: @escaping (NSError) -> Void){
        currentRequest = NSBundleResourceRequest(tags: [tag])
        
//        cell.progressView.observedProgress = ODRManager.shared.currentRequest?.progress
        
        guard let request = currentRequest else { return }
        request.endAccessingResources()
        
        request.beginAccessingResources { (error: Error?) in
            
            if let error = error{
                onFailure(error as NSError)
                return
            }
            
            onSuccess()
        }
    }

}
