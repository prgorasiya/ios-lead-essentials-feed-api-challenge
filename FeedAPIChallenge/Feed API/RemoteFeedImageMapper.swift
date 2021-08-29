//
//  RemoteFeedImageMapper.swift
//  FeedAPIChallenge
//
//  Created by paras gorasiya on 29/08/21.
//  Copyright © 2021 Essential Developer Ltd. All rights reserved.
//

import Foundation

struct RemoteFeedImageMapper {
	private struct Root: Decodable {
		let items: [Item]
	}

	private struct Item: Decodable {
		let imageId: UUID
		let imageDesc: String?
		let imageLoc: String?
		let imageUrl: URL

		var item: FeedImage {
			return FeedImage(id: imageId,
			                 description: imageDesc,
			                 location: imageLoc,
			                 url: imageUrl)
		}
	}

	static func feedImages(from data: Data) throws -> [FeedImage] {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		return try jsonDecoder.decode(Root.self, from: data).items.map({ $0.item })
	}
}
