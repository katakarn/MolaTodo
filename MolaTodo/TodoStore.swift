//
//  TodoStore.swift
//  MolaTodo
//
//  Created by katakarn supserm on 28/4/2565 BE.
//

import Foundation

protocol TodoStoreProtocal {
    func getTodoList() -> [Todo]
    func save(todoList: [Todo])
}

class TodoStore: TodoStoreProtocal{
    private var todoList: [Todo] = []
    
    func getTodoList() -> [Todo]{
        return todoList
    }
    
    func save(todoList: [Todo]) {
        self.todoList = todoList
    }
}
