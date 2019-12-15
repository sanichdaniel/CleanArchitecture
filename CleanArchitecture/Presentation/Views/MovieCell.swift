//
//  MovieCell.swift
//  CleanArchitecture
//
//  Created by 김동욱 on 14/12/2019.
//  Copyright © 2019 sanichdaniel. All rights reserved.
//
import UIKit
import ReactorKit
import RxSwift
import Kingfisher

final class MovieCell: UICollectionViewCell, StoryboardView {
    typealias Reactor = MovieCellReactor
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelMovieTitle.textColor = .white
//        self.contentView.backgroundColor = .red
    }
    
    func bind(reactor: Reactor) {
        imageViewPoster.image = nil
        labelMovieTitle.text = nil
        if let url = reactor.currentState.posterImage, !url.isEmpty, let imageURL = URL(string: url) {
            imageViewPoster.kf.setImage(with: imageURL)
            labelMovieTitle.isHidden = true
        } else {
            labelMovieTitle.text = reactor.currentState.title
            labelMovieTitle.isHidden = false
        }
    }
}
