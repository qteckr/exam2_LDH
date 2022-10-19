//
//  ViewController.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import UIKit

class ViewController: UIViewController {
    
    var type = 0 //0: 재료, 1: 정산, 2: 주문
    
    //초기재료
    var ingredients = Ingredients(beans: 10000,
                                  water: 10000,
                                  milk: 5000)
    
    let espresso = Coffee(name: "에스프레소",
                          cost: 4000,
                          ingredients: Ingredients(beans: 100,
                                                   water: 300,
                                                   milk: 0))
    
    let latte = Coffee(name: "라떼",
                       cost: 5000,
                       ingredients: Ingredients(beans: 100,
                                                water: 70,
                                                milk: 30))
    
    let americano = Coffee(name: "아메리카노",
                           cost: 4500,
                           ingredients: Ingredients(beans: 100,
                                                    water: 100,
                                                    milk: 0))
    
    var totalCost = 0
    var orders = [Coffee]()
    
    var ingredientButton: UIButton!
    var calculateButton: UIButton!
    var espressoButton: UIButton!
    var latteButton: UIButton!
    var americanoButton: UIButton!
    var stackView1: UIStackView!
    var stackView2: UIStackView!
    var statusLabel: UILabel!
    var collectionView: UICollectionView!
    var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupControls()
        setupLayout()
    }
    
    @objc private func handleMenu(_ sender: UIButton) {
        switch sender {
        case ingredientButton:
            statusLabel.text = "재료보고"
            
            type = 0
            collectionView.reloadData()
            
        case calculateButton:
            totalCost = espresso.totalCost + latte.totalCost + americano.totalCost
            
            statusLabel.text = "정산보고"
            
            type = 1
            collectionView.reloadData()
            
        case espressoButton:
            if requestOrder(menu: espresso) {
                statusLabel.text = "에스프레소 주문 성공"
            } else {
                statusLabel.text = "에스프레소 주문 실패"
            }
            
        case latteButton:
            if requestOrder(menu: latte) {
                statusLabel.text = "라떼 주문 성공"
            } else {
                statusLabel.text = "라떼 주문 실패"
            }
            
        case americanoButton:
            if requestOrder(menu: americano) {
                statusLabel.text = "아메리카노 주문 성공"
            } else {
                statusLabel.text = "아메리카노 주문 실패"
            }
            
        default:
            break
        }
    }
    
    private func requestOrder(menu coffee: Coffee) -> Bool {
        let ing = coffee.ingredients
        
        guard ingredients.beans >= ing.beans else {
            showFailAlert()
            return false
        }
        ingredients.beans -= ing.beans
        
        guard ingredients.water >= ing.water else {
            showFailAlert()
            return false
        }
        ingredients.water -= ing.water

        guard ingredients.milk >= ing.milk else {
            showFailAlert()
            return false
        }
        ingredients.milk -= ing.milk
        
        coffee.addCost()
        orders.append(coffee)
        
        type = 2
        collectionView.reloadData()
        return true
    }
    
    private func showFailAlert() {
        let alert = UIAlertController(title: "재료소진", message: "종료됩니다.", preferredStyle: .alert)
        
        let done = UIAlertAction(title: "확인", style: .default) { _ in
            exit(EXIT_SUCCESS)
        }
        
        alert.addAction(done)
        present(alert, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch type {
        case 0: //재료
            return 1
        case 1: //정산
            return 3
        default: //주문
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: //재료 잔고 || 총수익금 || 주문 정보
            return 1
        case 1: //제품별 매출 통계
            return 3
        default: //주문내역
            return orders.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellId, for: indexPath) as! Cell

        if type == 0 { //재료
            cell.ingredients = ingredients
            
        } else { //주문
            switch indexPath.section {
            case 0: //총수익금
                cell.totalCost = totalCost
            case 1: //제품별 매출 통계
                if indexPath.item == 0 {
                    cell.coffee = espresso
                } else if indexPath.item == 1 {
                    cell.coffee = latte
                } else {
                    cell.coffee = americano
                }
                
            default: //주문 내역
                cell.index = indexPath.item + 1
                cell.order = orders[indexPath.item]
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type {
        case 0:
            return collectionView.frame.size
        case 1:
            return CGSize(width: collectionView.frame.width, height: 50)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if type == 0 {
            return .zero
        } else {
            return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        }
    }
}

//for View
extension ViewController {
    
    private func setupNavigation() {
        navigationItem.title = "exam2"
    }
    
    private func setupControls() {
        ingredientButton = UIButton.menuButton(title: "재료보고")
        ingredientButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        
        calculateButton = UIButton.menuButton(title: "정산보고")
        calculateButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
            
        espressoButton = UIButton.menuButton(title: "에스프레소")
        espressoButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)

        latteButton = UIButton.menuButton(title: "라떼")
        latteButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        
        americanoButton = UIButton.menuButton(title: "아메리카노")
        americanoButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        
        stackView1 = {
            let sv = UIStackView(arrangedSubviews: [ingredientButton, calculateButton])
            sv.layer.masksToBounds = true
            sv.layer.cornerRadius = 10
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            sv.spacing = 25
            return sv
        }()
        
        stackView2 = {
            let sv = UIStackView(arrangedSubviews: [espressoButton, latteButton, americanoButton])
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
            l.text = "재료보고"
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
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
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
