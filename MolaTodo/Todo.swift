import Foundation
import UIKit

struct Todo {
    var id = UUID().uuidString
    var details: String = ""
    var type = TodoType.todoList
    var dueDate = Date()
    var isDone = false
    
}

enum TodoType: String{
    case todoList = "TodoList"
    case shopping = "Shopping"
    case work = "Work"
    
    static var allItems: [TodoType] {
        return [.todoList, .shopping, .work]
    }
    
    var icon: UIImage? {
        UIImage(named: self.rawValue)
    }
}
