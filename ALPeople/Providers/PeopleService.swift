//
// Created by Alberto Marturelo on 3/9/20.
// Copyright (c) 2020 Alberto Marturelo. All rights reserved.
//

import Moya

enum PeopleService {
    case peoples(page: Int, limit: Int)
}

extension PeopleService: TargetType {
    var baseURL: URL {
        return URL(string: "https://randomuser.me/api")!
    }

    var path: String {
        switch self {
        case .peoples(page: _, limit: _):
            return ""
        }
    }

    var method: Method {
        switch self {
        case .peoples(page: _, limit: _):
            return .get
        }
    }

    var sampleData: Data {
        switch self {
        default:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        }
    }

    var task: Task {
        switch self {
        case let .peoples(page, limit):
            return .requestParameters(parameters: ["results": limit, "page": page], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        nil
    }


}