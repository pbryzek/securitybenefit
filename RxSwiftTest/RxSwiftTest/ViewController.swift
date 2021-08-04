//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Paul Bryzek on 8/2/21.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private let apiBtn: UIButton = UIButton(type: .system)

    private let stackView = UIStackView()

    private let pageTitle = UILabel(frame: CGRect())

    private let viewModel = ProductViewModel()

    private let activityView = UIActivityIndicatorView(style: .medium)

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // UI Setup
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }

        self.bindTableData();
        self.setButton()
        self.setPageTitle()
        self.setStackView()

        stackView.addArrangedSubview(pageTitle)
        stackView.addArrangedSubview(apiBtn)
        stackView.addArrangedSubview(tableView)

        self.view.backgroundColor = .gray
        self.view.addSubview(stackView)

        //Add Activity Indicator after the stackview is added
        self.setActivityIndicator()
    }

    func setPageTitle() {
        pageTitle.frame = CGRect(x: 0, y: 10, width: view.bounds.width, height: 30)
        pageTitle.text = NSLocalizedString("Security Benefit Test API", comment: "I hope I pass!")
        pageTitle.center.x = self.view.center.x
        pageTitle.textAlignment = .center
    }

    func setStackView(){
        self.stackView.frame = CGRect(x: 0, y: 40, width: view.bounds.width, height: view.bounds.height)
        self.stackView.axis = .vertical
        self.stackView.spacing = 10
        self.stackView.backgroundColor = .orange
    }

    func setActivityIndicator(){
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        container.backgroundColor = .clear

        activityView.center = self.view.center
        container.addSubview(activityView)
        self.view.addSubview(container)
    }

    func showActivityIndicator() {
        activityView.startAnimating()
    }

    func stopActivityIndicator(){
        activityView.stopAnimating()
    }
    
    func setButton() {
        apiBtn.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        apiBtn.center.x = self.view.center.x
        apiBtn.backgroundColor = .black
        apiBtn.setTitle(NSLocalizedString("Lambda GET API Button", comment: "") , for: .normal)
        apiBtn.rx.tap.subscribe { [weak self] _ in
            self?.loadGetData()
        }
        .disposed(by: bag)
    }

    func bindTableData() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        viewModel.items.bind(to:tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){
            row, model, cell in cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)

        tableView.rx.modelSelected(Product.self).bind { product in
            if(product.title == NSLocalizedString("Home", comment: "")) {
                self.show(title: "Info", message: "Home Clicked")
            } else if(product.title == NSLocalizedString("GET API Call", comment: "")) {
                self.loadGetData()
            } else if(product.title == NSLocalizedString("POST API Call", comment: "")) {
                self.loadPostData()
            } else if(product.title == NSLocalizedString("Cancel API Call", comment: "")) {
                self.cancelAPIs()
            }
        }.disposed(by: bag)
        viewModel.fetchItems()
    }

    // Logic to Cancel the API Call
    func cancelAPIs() {
        AF.session.getAllTasks { (tasks) -> Void in
            tasks.forEach({ $0.cancel() })
            DispatchQueue.main.async {
                self.show(title:"Cancelled APIs", message: "All APIs were cancelled!")
                self.stopActivityIndicator()
            }
        }
    }

    func loadGetData() {
        AF.request(URLs.lambdaUrl).validate().responseJSON { response in
            switch response.result {
            case .success(let jsonResponse):
                if let res = jsonResponse as? String {
                    self.setPopUpText(success: true, popUpMsg: res)
                } else {
                    self.setPopUpText(success: true, popUpMsg: "Unexpected JSON")
                }
                self.stopActivityIndicator()
            case .failure(let errorResponse):
                print("error flow")
                print(errorResponse)
                self.setPopUpText(success: true, popUpMsg: "Error from Server!")
                self.stopActivityIndicator()
            }
        }
    }

    func loadPostData() {
        showActivityIndicator()
        AF.request(URLs.lambdaUrl, method:HTTPMethod.post, parameters:nil).validate().responseJSON { response in
            switch response.result {
            case .success(let jsonResponse):
                if let res = jsonResponse as? String {
                    self.setPopUpText(success: true, popUpMsg: res)
                } else {
                    self.setPopUpText(success: true, popUpMsg: "Unexpected JSON")
                }
                self.stopActivityIndicator()
            case .failure(let errorResponse):
                print("error flow")
                print(errorResponse)
                self.setPopUpText(success: true, popUpMsg: "Error from Server!")
                self.stopActivityIndicator()
            }
        }
    }

    func setPopUpText(success: Bool, popUpMsg: String) {
        print(popUpMsg)
        var popUpTitle = ""
        if(success) {
            popUpTitle = "API Success"
        } else {
            popUpTitle = "API Fail"
        }
        self.show(title: popUpTitle, message: popUpMsg)
    }
}

//Add Alert dialogs as an extension to the UIViewController
extension UIViewController {
    func show(title: String, message: String) {
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
