import UIKit

import Foundation

protocol Item {
    var name: String { get }
    var quantity: Int { get set }
}

protocol List {
    var items: [Item] { get set }
    
    mutating func addItem(_ item: Item)
    mutating func removeItem(at index: Int)
    func printList()
}

struct GroceryItem: Item {
    var name: String
    var quantity: Int
}

struct GroceryList: List {
    var items: [Item] = []
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    mutating func removeItem(at index: Int) {
        guard index >= 0, index < items.count else { return }
        items.remove(at: index)
    }

    func printList() {
        print("Lista de Compras:")
        for (index, item) in items.enumerated() {
            print("\(index + 1). \(item.name) - \(item.quantity)")
        }
    }
}

// Simulando o uso dos protocolos e structs
var myGroceryList = GroceryList()

let item1 = GroceryItem(name: "Maçãs", quantity: 5)
let item2 = GroceryItem(name: "Leite", quantity: 2)
let item3 = GroceryItem(name: "Pão", quantity: 1)

myGroceryList.addItem(item1)
myGroceryList.addItem(item2)
myGroceryList.addItem(item3)

myGroceryList.printList()

myGroceryList.removeItem(at: 1)
myGroceryList.printList()

// Exemplo de uso de Concorrência com async/await
func processShoppingListConcurrently() async {
    do{
        try await Task.sleep(nanoseconds: 1)
        myGroceryList.addItem(GroceryItem(name: "Cereal", quantity: 3))
        myGroceryList.printList()
    } catch {
        print("Erro ao aguardaro \(error)")
    }
}

Task {
    await processShoppingListConcurrently()
}



