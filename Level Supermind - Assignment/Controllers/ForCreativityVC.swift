//
//  ForCreativityVC.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 26/04/24.
//

import UIKit

protocol ForCreativityDelegate: AnyObject {
 
    func updateMiniPlayerVisibility(isPlaying: Bool)
}

class ForCreativityVC: UIViewController {
    
    

    @IBOutlet weak var miniPlayerview: UIView!
    @IBOutlet weak var playPauseBtnOutlet: UIButton!
    
    @IBOutlet weak var myTv: UITableView!
    var dataSet: [myTvCellDataModel] = []
    var musicPlayerVC: musicPlayerVC?
    
    weak var delegate:ForCreativityDelegate?
    
    @IBOutlet weak var playView: UIView!
    
    var isplaying:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        miniPlayerview.isHidden = true
        myTv.delegate = self
        myTv.dataSource = self
        playView.backgroundColor = UIColor.white.withAlphaComponent(0.0)
      
        let nib = UINib(nibName: "MyTvCell", bundle: nil)
        myTv.register(nib, forCellReuseIdentifier: "MyTvCell")
        
        for _ in 1...30 {
                   dataSet.append(myTvCellDataModel.generateRandomData())
               }
    }
    
    
    @IBAction func playBtnTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "musicPlayerVC") as? musicPlayerVC {
            navigationController?.pushViewController(vc, animated: true)
            
            vc.musicPlayerDelegate = self
            musicPlayerVC = vc
            print("Button tapped")
        } else {
            print("Failed to instantiate ForFocusVC from storyboard")
        }
        
    }
    
    @IBAction func miniPLayerPLayPauseBtnTapped(_ sender: Any) {
      
        
        if isplaying {
               pause()
               musicPlayerVC?.pause()
           } else {
               play()
               musicPlayerVC?.play()
           }
        
    }
    
    
 
    @IBAction func miniPlayerCancelBtnTApped(_ sender: Any) {
        
        self.miniPlayerview.isHidden = true
        pause()
        musicPlayerVC?.pause()
    }
    
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension ForCreativityVC:UITableViewDelegate , UITableViewDataSource {
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
        return 110 // Return the desired row height
    }

}

extension ForCreativityVC:MyTableViewCellDelegate {
    func didTapLikeButton(cell: MyTvCell) {
        
        guard let indexPath = myTv.indexPath(for: cell) else { return }
             dataSet[indexPath.row].isLiked.toggle()
             myTv.reloadData()
    }
    
}

extension ForCreativityVC: MusicPlayerControlDelegate {
    func play() {
        isplaying = true
        playPauseBtnOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        delegate?.updateMiniPlayerVisibility(isPlaying:  true)
    }
    
    func pause() {
        isplaying = false
        playPauseBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
    }
    
    func updateMiniPlayerVisibility(isPlaying: Bool) {
        if isPlaying {
            miniPlayerview.isHidden = false
            isplaying = true
            playPauseBtnOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            delegate?.updateMiniPlayerVisibility(isPlaying: true)
        } else {
            isplaying = false
            playPauseBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }
    }
}



