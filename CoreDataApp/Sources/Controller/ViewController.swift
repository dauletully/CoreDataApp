
import UIKit
import CoreData


class ViewController: UIViewController {
    
    private var mainView = MainPageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setupUI()
        
    }

    private func setupUI() {
        mainView.delegate = self
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.configure(person: CoreDataManager.shared.fetchData())
    }
}

extension ViewController: MainViewDelegate {
    func setGreeting(person: Person) {
        let vc = UserController()
        vc.userInfo = person
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

