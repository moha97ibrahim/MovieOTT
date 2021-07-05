//
//  ViewController.swift
//  Movie Info
//
//  Created by Mohammed Ibrahim on 3/7/21.
//

import UIKit

class ViewController: UIViewController,MovieManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate,
                      UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var DataCollectionView: UICollectionView!
    @IBOutlet weak var appTitle: UILabel!
    var itemCount = 0
    var movieManager = MovieManager()
    var data : NewAraivaLData?
    var newArraival : NewArraivalModel?
    var indexSelected : Int = 0
    var search:String=""
    var searchData : NewAraivaLData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieManager.delegate = self
        movieManager.fetchNewArrivals()
        DataCollectionView.dataSource = self
        DataCollectionView.delegate = self
        DataCollectionView.register(UINib(nibName: "DataCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dataCollectionViewCell");
        DataCollectionView.allowsSelection = true
        
        if let layout = DataCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width:(DataCollectionView!.bounds.width-30)/2, height: 250)
            layout.itemSize = size
        }
        
    }
    
    func didUpdateData(data: NewAraivaLData) {
        DispatchQueue.main.async {
            self.data = data
            self.itemCount = data.results.count
            self.searchData = self.data
            self.DataCollectionView.reloadData()  
        }
    }
    
    
    
    //MARK -: Data Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCollectionViewCell", for: indexPath) as! DataCollectionViewCell;
        cell.movieImages.isUserInteractionEnabled = false
        if(search == ""){
            if let image = data?.results[indexPath.row].imageurl[0]{
                let url = URL(string: image)
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url!){
                        DispatchQueue.main.async {
                            cell.movieImages.setBackgroundImage(UIImage(data: imageData), for: .normal)
                            if let title = self.data?.results[indexPath.row].title{
                                cell.movieTitle.text = title
                            }
                        }
                    }
                }
            }
        }
        else if(data?.results[indexPath.row].title == search) {
            if let image = data?.results[indexPath.row].imageurl[0]{
            let url = URL(string: image)
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        cell.movieImages.setBackgroundImage(UIImage(data: imageData), for: .normal)
                        if let title = self.data?.results[indexPath.row].title{
                            cell.movieTitle.text = title
                        }
                    }
                }
            }
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let imageurl : String = data!.results[indexPath.row].imageurl[0]
        let imdbid : String = data!.results[indexPath.row].imdbid
        let title : String = data!.results[indexPath.row].title
        let runtime : String = data!.results[indexPath.row].runtime
        let imdbrating : Float? = data!.results[indexPath.row].imdbrating
        let type : String = data!.results[indexPath.row].type
        let synopsis : String = data!.results[indexPath.row].synopsis
        self.newArraival = NewArraivalModel( imageurl: imageurl, imdbid: imdbid, title: title, runtime: runtime, imdbrating: imdbrating ?? 0.0, type: type, synopsis: synopsis)
        let segues = ["DetailSegu"]
        let segueID = segues[0]
        performSegue(withIdentifier: segueID, sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DetailViewController {
            let vc = segue.destination as? DetailViewController
            vc?.data = self.newArraival
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (DataCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    
    @IBAction func onTextChanged(_ sender: UITextField) {
        print(sender.text!)
        self.search = sender.text!
        if(search == "")
        {
            itemCount = (data?.results.count)!
        }
        else{
            self.itemCount = 1
        }
       
        DataCollectionView.reloadData()
    }
}





