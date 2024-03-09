//
//  SecurityWrapper.swift
//  SecurePasswordKeyChainDemo
//
//  Created by Ravikanth on 09/03/2024.
//

import Foundation
import Security

func secureStore(secret: String, forKey key: String) -> Bool {
    
    guard !secret.isEmpty || !key.isEmpty else {
        return false
    }
 
    let queryDictionary: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                           kSecValueData as String: secret.data(using: .utf8)!,
                                           kSecAttrAccount as String: key.data(using: .utf8)!]
    
    let foundItem = retrieveItem(forKey: key)
    
    var status: OSStatus
    
    if foundItem == nil {
        status = SecItemAdd(queryDictionary as CFDictionary, nil)
        
    } else {
        let updateQueryDict: [String : Any] = [kSecClass as String: kSecClassGenericPassword,
                                               kSecAttrAccount as String: key.data(using: .utf8)!]
        let attributes: [String: Any] = [kSecValueData as String: secret.data(using: .utf8)!]
        
        status = SecItemUpdate(updateQueryDict as CFDictionary, attributes as CFDictionary)
    }
    
    guard status == errSecSuccess else {
        return false
    }
    return true
}

func retrieveItem(forKey key: String) -> String? {
    
    let queryDictionary: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                          kSecAttrAccount as String: key.data(using: .utf8)!,
                                          kSecReturnData as String: true]
    var item: CFTypeRef?
    let status = SecItemCopyMatching(queryDictionary as CFDictionary, &item)
    
    guard status == errSecSuccess,
          let data = item as? Data else {
        return nil
    }
    return String(data: data, encoding: .utf8)
}

func deleteItem(forKey key: String) -> Bool {
    
    let deleteQuery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                      kSecAttrAccount as String: key.data(using: .utf8)!]
    
    let status = SecItemDelete(deleteQuery as CFDictionary)
    
    guard status == errSecSuccess else {
        return false
    }
    return true
}
