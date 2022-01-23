//
//  SelectableModel.swift
//  FlexiblePickerExample
//
//  Created by Jędrzej Chołuj on 23/01/2022.
//

import Foundation

protocol Selectable: Identifiable, Hashable {
    var displayedName: String { get set }
    var isSelected: Bool { get set }
    
    init(displayedName: String)
}

struct SelectableModel: Selectable, Identifiable {
    static func == (lhs: SelectableModel, rhs: SelectableModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    var displayedName: String
    var isSelected: Bool
    let id: UUID = UUID()
    
    init(displayedName: String) {
        self.displayedName = displayedName
        self.isSelected = false
    }
    
    init(displayedName: String, isSelected: Bool) {
        self.displayedName = displayedName
        self.isSelected = isSelected
    }
}
