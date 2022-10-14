//
//  ViewController.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {

    var menu1Button: UIButton!
    var menu2Button: UIButton!
    var menu3Button: UIButton!
    var menu4Button: UIButton!
    var menu5Button: UIButton!
    var stackView1: UIStackView!
    var stackView2: UIStackView!
    var statusLabel: UILabel!
    var collectionView: UICollectionView!
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "exam2"
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        setupControls()
        setupLayout()
    }
    
    @objc private func handleMenu1() {
        print("didTapMenu1")
    }
    
    @objc private func handleMenu2() {
        print("didTapMenu2")
    }
    
    @objc private func handleMenu3() {
        print("didTapMenu3")
    }
    
    @objc private func handleMenu4() {
        print("didTapMenu4")
    }
    
    @objc private func handleMenu5() {
        print("didTapMenu5")
    }
}

extension ViewController {
    
    private func setupControls() {
        menu1Button = UIButton.menuButton(title: "메뉴1")
        menu1Button.addTarget(self, action: #selector(handleMenu1), for: .touchUpInside)
        
        menu2Button = UIButton.menuButton(title: "메뉴2")
        menu2Button.addTarget(self, action: #selector(handleMenu2), for: .touchUpInside)
            
        menu3Button = UIButton.menuButton(title: "메뉴3")
        menu3Button.addTarget(self, action: #selector(handleMenu3), for: .touchUpInside)

        menu4Button = UIButton.menuButton(title: "메뉴4")
        menu4Button.addTarget(self, action: #selector(handleMenu4), for: .touchUpInside)
        
        menu5Button = UIButton.menuButton(title: "메뉴5")
        menu5Button.addTarget(self, action: #selector(handleMenu5), for: .touchUpInside)
        
        stackView1 = {
            let sv = UIStackView(arrangedSubviews: [menu1Button, menu2Button])
            sv.layer.masksToBounds = true
            sv.layer.cornerRadius = 10
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            sv.spacing = 25
            return sv
        }()
        
        stackView2 = {
            let sv = UIStackView(arrangedSubviews: [menu3Button, menu4Button, menu5Button])
            sv.layer.masksToBounds = true
            sv.layer.cornerRadius = 10
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            sv.spacing = 15
            return sv
        }()
        
        statusLabel = {
            let l = UILabel()
            l.layer.masksToBounds = true
            l.layer.cornerRadius = 10
            l.backgroundColor = .white
            l.text = "라벨"
            l.textAlignment = .center
            l.textColor = .black
            l.font = .boldSystemFont(ofSize: 25)
            return l
        }()
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.layer.masksToBounds = true
            cv.layer.cornerRadius = 10
            cv.backgroundColor = .white
            
            cv.dataSource = self
            cv.delegate = self
            
            cv.register(Cell.self, forCellWithReuseIdentifier: Cell.cellId)
            return cv
        }()
        
        stackView = {
            let sv = UIStackView(arrangedSubviews: [stackView1, stackView2, statusLabel])
            sv.backgroundColor = .clear
            sv.axis = .vertical
            sv.distribution = .fill
            sv.spacing = 20
            return sv
        }()
    }

    private func setupLayout() {
        view.addSubview(stackView)
        stackView.anchor(t: view.safeAreaLayoutGuide.topAnchor, l: view.leftAnchor, b: nil, r: view.rightAnchor, ct: 25, cl: 15, cb: 0, cr: 15)
        NSLayoutConstraint.activate([
            stackView1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            stackView2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            statusLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.29)
        ])
        
        view.addSubview(collectionView)
        collectionView.anchor(t: stackView.bottomAnchor, l: view.leftAnchor, b: view.safeAreaLayoutGuide.bottomAnchor, r: view.rightAnchor, ct: 15, cl: 15, cr: 15)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellId, for: indexPath) as! Cell
        
        cell.model = DataModel(title: String(indexPath.item + 1))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let cell = cell as? Cell,
              let model = cell.model
        else {return}
        
        print("didSelectItemAt:", model.title ?? "nil")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
