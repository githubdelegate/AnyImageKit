//
//  PermissionDeniedView.swift
//  AnyImageKit
//
//  Created by 蒋惠 on 2019/9/30.
//  Copyright © 2019-2021 AnyImageProject.org. All rights reserved.
//

import UIKit

final class PermissionDeniedView: UIView {
    
    private lazy var label: UILabel = {
        let view = UILabel(frame: .zero)
        let text = String(format: Permission.camera.localizedAlertMessage, BundleHelper.appName)
        view.text = text
        view.textAlignment = .center
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var button: UIButton = {
        let view = UIButton(type: .custom)
        view.setTitle(BundleHelper.localizedString(key: "GO_TO_SETTINGS", module: .core), for: .normal)
        view.addTarget(self, action: #selector(settingsButtonTapped(_:)), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(button)
        label.snp.makeConstraints { maker in
            maker.top.left.right.equalToSuperview().inset(15)
        }
        button.snp.makeConstraints { maker in
            maker.top.equalTo(label.snp.bottom).offset(10)
            maker.left.right.equalToSuperview()
            maker.height.equalTo(40)
        }
    }
}

// MARK: - Target
extension PermissionDeniedView {
    
    @objc private func settingsButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

// MARK: - PickerOptionsConfigurable
extension PermissionDeniedView: PickerOptionsConfigurable {
    
    func update(options: PickerOptionsInfo) {
        label.textColor = options.theme[color: .text]
        button.setTitleColor(options.theme[color: .main], for: .normal)
        backgroundColor = options.theme[color: .background]
    }
}
