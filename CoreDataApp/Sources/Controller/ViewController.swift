
import UIKit


class ViewController: UIViewController {
    
    var mainView = MainPageView()


    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        setupUI()
       // guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
    }

    private func setupUI() {
        mainView.delegate = self
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: MainViewDelegate {
    func setGreeting(person: People) {
        let vc = UserController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

