//
//  SuperheroeDetailViewController.swift
//  Superheroes
//
//  Created by Borja Álvaro González Jurado on 25/04/2018.
//  Copyright © 2018 Borja González Jurado. All rights reserved.
//

import UIKit

class SuperheroeDetailViewController: UIViewController {
    
    var superheroeDetailViewModel: SuperheroeDetailViewModel! = nil
    
    @IBOutlet weak var photoImageView: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var groupsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewModel = superheroeDetailViewModel else {
            return ErrorManager.handleError(.dataError("Variable superheroeDetailViewModel equal to nil"),
                                            className: String(describing: SuperheroeDetailViewController.self),
                                            message: "")
        }
        
        photoImageView.fetchImage(url: viewModel.photo)
        nameLabel.text = viewModel.name
        realNameLabel.text = viewModel.realName
        heightLabel.text = viewModel.height
        powerLabel.text = viewModel.power
        abilitiesLabel.text = viewModel.abilities
        groupsLabel.text = viewModel.groups
    }
}
