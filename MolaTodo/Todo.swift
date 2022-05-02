import Foundation
import UIKit

struct Todo {
    var id = UUID().uuidString
    var details: String = ""
    var type = TodoType.todoList
    var dueDate = Date()
    var isDone = false
    
//func getTypeIndex() -> Int{
//    if type == .todoList{
//        return 0
//    }
//    if type == .shopping{
//        return 1
//    }
//    if type == .work {
//        return 2
//    }
//    return 0
//}
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
