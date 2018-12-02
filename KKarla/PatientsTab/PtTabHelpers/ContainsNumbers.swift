//
//  ContainsNumbers.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

extension String {
    var containsNumbers: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return !Set(self).intersection(nums).isEmpty
    }
}
