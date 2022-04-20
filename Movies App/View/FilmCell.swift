//
//  filmCell.swift
//  Movies App
//
//  Created by The GORDEEVS on 20.04.2022.
//

import UIKit

class FilmCell: UITableViewCell {
    static let reusableId = "filmCellId"
    var movieId: String?
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Some great label!"
        label.numberOfLines = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var year: UILabel = {
        let label = UILabel()
        label.text = "today"
        label.numberOfLines = 1
        label.textColor = .systemGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imDbRating: UILabel = {
        let label = UILabel()
        label.text = "today"
        label.numberOfLines = 1
        label.textColor = .systemGray
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var image: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "someimage")
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleAspectFill
        imageV.layer.cornerRadius = 10
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func layout(){
        self.contentView.addSubview(image)
        
    }

}
