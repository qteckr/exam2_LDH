//
//  Model.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import Foundation

enum Menu: Int, CaseIterable {
    case espresso, latte, americano
    
    var title: String {
        switch self {
        case .espresso : return "에스프레소"
        case .latte    : return "라떼"
        case .americano: return "아메리카노"
        }
    }
}

class Ingredients {
    var beans: Int = 0
    var water: Int = 0
    var milk: Int = 0
    
    init() {
        self.beans = 10000
        self.water = 10000
        self.milk = 5000
    }
    
    init(beans: Int, water: Int, milk: Int) {
        self.beans = beans
        self.water = water
        self.milk = milk
    }
    
    func orderable(_ ingredients: Ingredients) -> Bool {
        guard beans >= ingredients.beans else {return false}
        beans -= ingredients.beans
        
        guard water >= ingredients.water else {return false}
        water -= ingredients.water
        
        guard milk >= ingredients.milk else {return false}
        milk -= ingredients.milk
        
        return true
    }
}

class Coffee {
    
    private(set) var name: String
    private(set) var cost: Int
    private(set) var ingredients: Ingredients
    
    init(name: String, cost: Int) {
        self.name = name
        self.cost = cost
        self.ingredients = Ingredients()
    }
}

class Espresso: Coffee {
    
    override var ingredients: Ingredients {
        return Ingredients(beans: 100, water: 300, milk: 0)
    }
    
    init() {
        super.init(name: "에스프레소", cost: 4000)
    }
}

class Latte: Coffee {
    
    override var ingredients: Ingredients {
        return Ingredients(beans: 100, water: 70, milk: 30)
    }
    
    init() {
        super.init(name: "라떼", cost: 5000)
    }
}

class Americano: Coffee {
    
    override var ingredients: Ingredients {
        return Ingredients(beans: 100, water: 100, milk: 0)
    }
    
    init() {
        super.init(name: "아메리카노", cost: 4500)
    }
}
