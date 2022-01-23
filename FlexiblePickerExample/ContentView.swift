//
//  ContentView.swift
//  FlexiblePickerExample
//
//  Created by Jędrzej Chołuj on 23/01/2022.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var data: [SelectableModel] = [
        "bagel", "beans", "beer", "biscuit", "bread", "broth", "burger", "butter", "cake", "candy", "caramel", "caviar", "cheese", "chili", "chocolate", "cider", "cocoa", "coffee", "cookie", "cream", "croissant", "crumble", "cuisine", "curd", "dessert", "dish", "drink", "eggs", "filet", "fish", "flour", "foie gras", "food", "grill", "hamburger", "ice", "juice", "ketchup", "kitchen", "liquor", "margarine", "mayo", "mayonnaise", "meat", "milk", "mousse", "muffin", "mushroom", "noodle", "nut", "oil", "olive", "omelette", "pan", "pasta", "paste", "pie", "pizza", "plate", "poutine", "pudding", "recipe", "rice", "salad", "salsa", "sandwich", "sauce", "soda", "soup", "soy", "spice", "steak", "syrup", "tartar", "taste", "tea", "toast", "vinegar", "waffle", "water", "wheat", "wine", "wok", "yeast", "yogurt"
    ].map { SelectableModel(displayedName: $0) }
}

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        FlexiblePicker<SelectableModel>(inputData: $viewModel.data)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
