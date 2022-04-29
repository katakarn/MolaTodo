import UIKit

protocol TodoItemViewControllerDelegate: AnyObject {
    func onUpdated(todoItem: Todo)
}

class TodoItemViewController: UIViewController{

    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var todoTypePickerView: UIPickerView!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    var todoItem: Todo?
    
    weak var delegate: TodoItemViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTypePickerView.dataSource = self
        todoTypePickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let todoItem = todoItem {
            detailsTextView.text = todoItem.details
            dueDatePickerView.date = todoItem.dueDate
            isDoneSwitch.isOn = todoItem.isDone
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if todoItem == nil {
            todoItem = Todo()
        }
        
        if var todoItem = todoItem {
            todoItem.details = detailsTextView.text
            todoItem.dueDate = dueDatePickerView.date
            todoItem.isDone = isDoneSwitch.isOn
            
            delegate?.onUpdated(todoItem: todoItem)
            
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - UIPickerView DataSource & Delegate Handler

extension TodoItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TodoType.allItems.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TodoType.allItems[row].rawValue
    }
    
}

