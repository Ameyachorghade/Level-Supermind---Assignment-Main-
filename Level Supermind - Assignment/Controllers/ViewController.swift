//
//  ViewController.swift
//  Level Supermind - Assignment
//
//  Created by Ameya Chorghade on 23/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchMusisView: UIView!
    
    @IBOutlet weak var horSV1View1: UIView!
    @IBOutlet weak var horSV1View2: UIView!
    @IBOutlet weak var horSV1View3: UIView!
    @IBOutlet weak var horSV1View4: UIView!
    
    
    @IBOutlet weak var horSV2View1: UIView!
    @IBOutlet weak var horSV2View2: UIView!
    @IBOutlet weak var horSV2View3: UIView!
    
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var imgView2: UIImageView!
    @IBOutlet weak var imgView3: UIImageView!
    
    // collection View
    @IBOutlet weak var myCv: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let dataManager = DataManager.shared
    
    let itemCount = 3
    
    @IBOutlet weak var horSV3View1: UIView!
    @IBOutlet weak var horSV3View2: UIView!
    @IBOutlet weak var horSV3View3: UIView!
    
    
    @IBOutlet weak var lastMainView: UIView!
    
    @IBOutlet weak var miniplayerView: UIView!
    
    
    @IBOutlet weak var playPauseBtnOutlet: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        myCv.delegate = self
        myCv.dataSource = self
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.miniplayerView.isHidden = true
    }
    
    func initialSetup() {
        
        searchMusisView.layer.cornerRadius = 20
        let viewsArray = [horSV1View1,horSV1View2,horSV1View2,horSV1View3 , horSV1View4]
        
        let viewsArray2 = [horSV2View1,horSV2View2,horSV2View3]

        customizeViews(viewsArray)
        customizeViews2(viewsArray2)
        myCv.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        pageControl.numberOfPages = itemCount
            pageControl.currentPage = 0
        
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
           swipeLeft.direction = .left
           myCv.addGestureRecognizer(swipeLeft)
           
           let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
           swipeRight.direction = .right
           myCv.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
          guard let currentPage = pageControl else { return }
          
          if sender.direction == .left && currentPage.currentPage < itemCount - 1 {
              currentPage.currentPage += 1
          } else if sender.direction == .right && currentPage.currentPage > 0 {
              currentPage.currentPage -= 1
          }
          
          let indexPath = IndexPath(item: currentPage.currentPage, section: 0)
          myCv.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
    
    func customizeViews(_ views: [UIView?]) {
        let cornerRadius: CGFloat = 20
        let borderColor: UIColor = .lightText
        
        for view in views {
           
            
            guard let view = view else { continue }
            view.layer.cornerRadius = cornerRadius
            
            // Apply border color
            view.layer.borderColor = borderColor.cgColor
            view.layer.borderWidth = 1 
        }
    }
    
    func customizeViews2(_ views: [UIView?]) {
        let cornerRadius: CGFloat = 20
        
        
        imgView1.layer.cornerRadius = 10
        imgView2.layer.cornerRadius = 10
        imgView3.layer.cornerRadius =  10
        lastMainView.layer.cornerRadius =  20
        
        for view in views {
            // Apply corner radius
            
            guard let view = view else { continue }
            view.layer.cornerRadius = cornerRadius

        }
    }
    
    
    @IBAction func forFocusBtnTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForFocusVC") as? ForFocusVC {
            navigationController?.pushViewController(vc, animated: true)
            print("Button tapped")
        } else {
            print("Failed to instantiate ForFocusVC from storyboard")
        }

    }
    
    
    @IBAction func forCreativityBtnTapped(_ sender: Any) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ForCreativityVC") as? ForCreativityVC {
            navigationController?.pushViewController(vc, animated: true)
            vc.delegate = self
            print("Button tapped")
        } else {
            print("Failed to instantiate ForFocusVC from storyboard")
        }

        
    }
    
    
    @IBAction func miniPLayerPlayPAuseBtnTApped(_ sender: Any) {
        
    }
    
    @IBAction func miniPlayerCloseBtnATpped(_ sender: Any) {
        self.miniplayerView.isHidden = true
    }
    

}

extension ViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.dataSetArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
//        let dataSet = dataManager.dataSetArray[indexPath.row]
//        cell.blueHEading.text = dataSet.heading ?? ""
//        cell.imgView.image = dataSet.image ?? UIImage()
//        cell.subheadinglbl.text = dataSet.subheading1 ?? ""
//        cell.thirdLbl.text = dataSet.subheading2 ?? ""
        return cell
    }
    
   
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
extension ViewController:ForCreativityDelegate {
    func updateMiniPlayerVisibility(isPlaying: Bool) {
        if isPlaying {
            miniplayerView.isHidden = false
            playPauseBtnOutlet.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playPauseBtnOutlet.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }

    }
    
    
}



