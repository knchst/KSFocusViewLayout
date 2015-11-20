//
//  ViewController.swift
//  KSFocusViewLayout
//
//  Created by Kenichi Saito on 11/18/15.
//  Copyright © 2015 Kenichi Saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let data = [
        [
            "title": "Apple",
            "description": "Inventer of Macintosh",
            "image": "imege-"
        ],
        [
            "title": "Google",
            "description": "Inventer of Android",
            "image": "image-"
        ],
        [
            "title": "Microsoft",
            "description": "Inventer of Windows",
            "image": "image-"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        
        let nib = UINib(nibName: "KSCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(nib, forCellWithReuseIdentifier: "Cell")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! KSCollectionViewCell
        
        cell.titleLabel.text = data[indexPath.row]["title"]
        cell.descriptionLabel.text = data[indexPath.row]["description"]
        cell.imageView.image = UIImage(named: "image-\(indexPath.row)")
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

