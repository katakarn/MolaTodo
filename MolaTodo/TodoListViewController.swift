import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, TodoItemViewControllerDelegate, UITableViewDelegate {
    
    var indexSelectCell: Int? = nil
    
    lazy var store: TodoStoreProtocal = {
        return TodoStore()
    }()
    
    var todoList: [Todo] {
        get {
            store.getTodoList()
        }
        set {
            store.save(todoList: newValue)
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoItem = todoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        if let todoListCell = cell as? TodoListTableViewCell {
            todoListCell.detailsLabel.text = todoItem.details
            todoListCell.dueDateLabel.text = todoItem.dueDate.description
            todoListCell.iconImageView.image = todoItem.type.icon
            todoListCell.isDoneSwitch.isOn = todoItem.isDone
            return todoListCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexSelectCell = indexPath.row
        performSegue(withIdentifier: "updateSegue", sender: nil)
//        print("row selected : \(indexPath.row)")
    }
    
    
    
//    @IBAction func addButtonTapped(_ sender: Any) {
//        let newItem = Todo(
//            id: UUID().uuidString,
//            details: "Test \(todoList.count + 1)",
//            type: .todoList,
//            dueDate: Date(),
//            isDone: false
//        )
//        todoList.append(newItem)
//        tableView.reloadData()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? TodoItemViewController{
            if segue.identifier == "updateSegue" {
                if let index = indexSelectCell{
                    vc.todoItem = todoList[index]
                }
            }
            vc.delegate = self
        }
    }
    
    func onUpdated(todoItem: Todo) {
        
        if !store.isAlreadyInList(id: todoItem.id){
            todoList.append(todoItem)
        }else{
            if let index = indexSelectCell {
                todoList[index] = todoItem
            }
        }
        
    }
    
}
