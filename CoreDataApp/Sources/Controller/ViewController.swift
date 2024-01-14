
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
        title = "Users"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}

