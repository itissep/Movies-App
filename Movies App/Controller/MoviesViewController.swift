//
//  ViewController.swift
//  Movies App
//
//  Created by The GORDEEVS on 20.04.2022.
//

import UIKit

class MoviesViewController: UIViewController {
    
    let selectOptions: [MoviesSearchType] = [
        MoviesSearchType(type: "MostPopularMovies", title: "Most Popular Movies"),
        MoviesSearchType(type: "MostPopularTVs", title: "Most Popular TVs"),
        MoviesSearchType(type: "InTheaters", title: "In Theaters"),
        MoviesSearchType(type: "ComingSoon", title: "Coming Soon"),
        MoviesSearchType(type: "BoxOffice", title: "Box Office"),
        MoviesSearchType(type: "BoxOfficeAllTime", title: "Box Office All Time"),
    ]
    
    var moviesList: [Movie]?
    
    var currentOption = MoviesSearchType(type: "MostPopularMovies", title: "Most Popular Movies")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filmsTable.delegate = self
        filmsTable.dataSource = self
        
        layout()
        
    }
    
    func loadMovies(){
        
//        NetworkManager.shared.loadMovieById(id: "tt1375666") { movie in
//            print(movie?.title)
//        }

        NetworkManager.shared.loadMoviesWithSearch(searchString: "zootopia") { movies in
            for movie in movies {
                print(movie.title)
            }
        }

//        NetworkManager.shared.loadMoviesByType(type: currentOption.type) { movies in
//            for movie in movies {
//                print(movie.title)
//            }
//        }
        
        
    }
    

    

    lazy var btn: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать раздел", for: .normal)
        button.setTitleColor(UIColor.systemOrange, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let deferredMenus = UIMenu(title: "", children: [
                    UIDeferredMenuElement({ completion in
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            let items = self.selectOptions.map { item in
                                UIAction(title: "\(item.title)") { _ in
                                    self.currentOption = item
                                    self.loadMovies()
                                    self.btn.setTitle(self.currentOption.title, for: .normal)
                                    self.btn.updateConfiguration()
                                }
                            }
                            completion([UIMenu(title: "", options: .displayInline, children: items)])
                        }
                    })
                ])
        button.menu = deferredMenus
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    lazy var filmsTable: UITableView = {
        let tableView = UITableView()
        
        tableView.register(FilmCell.self, forCellReuseIdentifier: FilmCell.reusableId)
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var refreshControll: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .systemOrange
        refresh.addTarget(self, action: #selector(self.refreshing), for: .valueChanged)
        
        return refresh
    }()
    
    @objc func refreshing(){
//        loadTableView()
        print("refresher")
    }
    
    
    //MARK: - LAYOUT
    func layout(){
        self.view.backgroundColor = .white
        view.addSubview(btn)
        
        // btn constraints
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            btn.widthAnchor.constraint(equalToConstant: 100),
            btn.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        view.addSubview(filmsTable)
        
        // filmsTable constraints
        NSLayoutConstraint.activate([
            filmsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmsTable.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            filmsTable.widthAnchor.constraint(equalTo: view.widthAnchor),
            filmsTable.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 100),
        ])
        
        filmsTable.rowHeight = 200
    }
}


//MARK: - UITableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    
}


//MARK: - UITableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmCell.reusableId) as! FilmCell
        
        if let movie = moviesList?[indexPath.row] {
//            cell.image = movie.image
            cell.title.text = movie.title
            cell.imDbRating.text = movie.imDbRating
            cell.movieId = movie.id
            cell.year.text = movie.year
        }
        return cell
    }
}
