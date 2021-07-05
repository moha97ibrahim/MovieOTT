//
//  DetailViewController.swift
//  Movie Info
//
//  Created by Mohammed Ibrahim on 4/7/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var movieTilte: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenere: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    
    var data : NewArraivalModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(data?.imdbid ?? "")

        if let image = data?.imageurl{
            let url = URL(string: image)
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        movieTilte.text = data?.title
        movieYear.text = "2019"
        movieRating.text = String(data!.imdbrating)
        movieSynopsis.text = data?.synopsis
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
