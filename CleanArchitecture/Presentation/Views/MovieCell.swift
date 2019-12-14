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
    
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.backgroundColor = .red
    }
    
    func bind(reactor: Reactor) {
        if let url = reactor.currentState.posterImage, let imageURL = URL(string: url) {
            imageViewPoster.kf.setImage(with: imageURL)
        }
    }
}
