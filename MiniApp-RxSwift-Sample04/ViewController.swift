//
//  ViewController.swift
//  MiniApp-RxSwift-Sample04
//
//  Created by 近藤米功 on 2022/07/27.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var addressLabel: UILabel!

    let disposeBag = DisposeBag()

    private let maxNameFieldSize = 10
    private let maxAddressFieldSize = 50

    let limitText: (Int) -> String = {
        return "あと\($0)文字"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings(){
        // mapでtextの中身を見る
        nameTextField.rx.text.map { [weak self] text -> String? in
            guard let text = text else{ return nil }
            guard let maxNameFieldSize = self?.maxNameFieldSize else { return nil}
            let limitCount = maxNameFieldSize - text.count
            return self?.limitText(limitCount)
        }
        .bind(to: nameLabel.rx.text)
        .disposed(by: disposeBag)

        addressTextField.rx.text.map { [weak self] text -> String? in
            guard let text = text else{ return nil}
            guard let maxAddressFieldSize = self?.maxAddressFieldSize else { return nil }
            let limitCount = maxAddressFieldSize - text.count
            return self?.limitText(limitCount)
        }
        .bind(to: addressLabel.rx.text)
        .disposed(by: disposeBag)
    }

}

