//
//  main.swift
//  Groceries
//
//  Created by Georgios Loulakis on 5.02.22.
//

import Foundation

enum Command: String {
    case l
    case a
    case r
    case s
    case h
    case q
    case endOfFile = "eof"
    case random
    case indexes
}

struct Product {
    private static var nextID:Int = 1
    let id:Int
    var name: String
    var quantity: String
    
    init(name: String, quantity: String){
        self.name = name
        self.quantity = quantity
        self.id = Self.nextID //Use Self to access static properties,which are shared
        Self.nextID += 1
    }
}

func printWelcomeMessage(){
    print("---- Your Grocery List -----")
    print("To see available commands, type \"h\"")
}

func printCommands(){
    print("Available commands:")
    print("\tl - Show grocery list")
    print("\ta - Add new product")
    print("\tr - Remove Products")
    print("\ts - Sort products")
    print("\th - Help")
    print("\tq - Quit")
}

func listProducts(){
    print("--- Grocery list --- ")
    print ("Product count: \(products.count)")
    
    for product in products {
        print("ID: \(product.id) Product name: \(product.name) Product quantity: \(product.quantity)")
    }
}


func addProduct(){
    print("--- Add product --- ")
    let name = readLine(after: "Enter name")
    let quantity = readLine(after: "Enter quantity")
    
    if name.isEmpty == false {
        let product = Product.init(name: name, quantity: quantity)
        products.append(product)
        print("\(product.name) was succesfuly added.")
    } else {
        print ("Product name was empty, don't add anything.")
    }
    
}

func removeProduct(){
    let id = readLine(after: "Enter ID of the product")
    for (index, product) in products.enumerated(){
        if product.id == Int(id) {
            products.remove(at: index)
            print ("Removed \(product.name) from the grocery list!")
        }
    }
}

func readLine(after message: String) -> String{
    print(message, terminator: ": ")
    
    // There is a possibility to receive back a nil value
    // to simulate it, jast try to input a control + D whlile
    // providing a value in the terminal
    
    if let input = readLine() {
        return  input.trimmingCharacters(in: .whitespaces)
    } else {
        // eof - end of file
        return "eof"
    }
}

var isAppRunning = true

var products:[Product] = []

printWelcomeMessage()
printCommands()

while isAppRunning == true {
    
    let inputCommand = readLine(after: "Enter command")
    
    guard let command = Command.init(rawValue: inputCommand)else {
        print ("\(inputCommand): is not found")
        continue
    }
    
    //Command exist here
    
    print ("Received command: \(command)")
        
    switch command {
    case .l:
            // show product list
           listProducts()
            break
            
    case .a:
            // add product to the list
            addProduct()
            break
            
    case .r:
        // remove product from the list
    removeProduct()
            break
            
    case .s:
            
            break
            
    case .h:
            // print available commands
            printCommands()
            break
            
    case .q,.endOfFile:
            // quit application
            isAppRunning = false
            break
    case .random:
        if let product = products.randomElement(){
            print("You should now buy \(product.quantity) \(product.name)")
        }else {
            print ("You have already bought everything! Good for you!")
        }
    case.indexes:
        let countries = ["Latvia","United States","Greece"]
        print(countries[0])
        
        if countries.indices.contains(5){
            print ("You can safely try to access countries[5]")
        } else {
            print ("Error")
        }
}
}
