//
//  ForFocusVC.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 25/04/24.
//

import UIKit



class ForFocusVC: UIViewController {
    

    @IBOutlet weak var myTv: UITableView!
    var dataSet: [myTvCellDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myTv.delegate = self
        myTv.dataSource = self
      
        let nib = UINib(nibName: "MyTvCell", bundle: nil)
        myTv.register(nib, forCellReuseIdentifier: "MyTvCell")
        
        for _ in 1...30 {
                   dataSet.append(myTvCellDataModel.generateRandomData())
               }

        
    }


    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ForFocusVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTvCell", for: indexPath) as! MyTvCell
          
        
        let data = dataSet[indexPath.row]

        cell.heading1.text = data.title
               cell.heading2?.text = data.description
               cell.heading3?.text = data.description
        cell.likeImgView.image = data.isLiked ? UIImage(named: "favoriteSelected") : UIImage(named: "favorite")
        
               cell.myImgView?.image = data.image
        cell.delegate = self 
      
          
          return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

}

extension ForFocusVC:MyTableViewCellDelegate {
    func didTapLikeButton(cell: MyTvCell) {
        
        guard let indexPath = myTv.indexPath(for: cell) else { return }
             dataSet[indexPath.row].isLiked.toggle()
             myTv.reloadData()
    }
    
    
    
}
