//
//  Model.swift
//  exam2
//
//  Created by Qtec on 2022/10/14.
//

import Foundation

class Ingredients {
    var beans: Int = 0
    var water: Int = 0
    var milk: Int = 0
    
    init(beans: Int, water: Int, milk: Int) {
        self.beans = beans
        self.water = water
        self.milk = milk
    }
    
    func initData() {
        self.beans = 10000
        self.water = 10000
        self.milk = 5000
    }
}

class Coffee {
    
    private(set) var name: String
    private(set) var cost: Int
    private(set) var ingredients: Ingredients
    
    private(set) var totalCost = 0
    
    init(name: String, cost: Int, ingredients: Ingredients) {
        self.name = name
        self.cost = cost
        self.ingredients = ingredients
    }
    
    func addCost() {
        self.totalCost += self.cost
    }
    
    func initTotalCost() {
        self.totalCost = 0
    }
}
