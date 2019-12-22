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
    }
    
    func bind(reactor: Reactor) {
        // 이미지 있으면 이미지 아니면 라벨
        if let posterImageUrl = reactor.currentState.posterImageUrl {
            imageViewPoster.kf.setImage(with: posterImageUrl)
            labelMovieTitle.text = ""
        } else {
            imageViewPoster.kf.setImage(with: nil)
            labelMovieTitle.text = reactor.currentState.title
        }
    }
}
