//
//  UIWindow+.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation
import Cleanse

extension AppDelegate {
    struct Component : Cleanse.RootComponent {
        // When we call build(()) it will return the Root type, which is a RootViewController instance.
        typealias Root = RootPageModule

        // Required function from Cleanse.RootComponent protocol.
        static func configureRoot(binder bind: ReceiptBinder<RootPageModule>) -> BindingReceipt<RootPageModule> {
            return bind.to(factory: RootPageModule.init)
        }

        // Required function from Cleanse.RootComponent protocol.
        static func configure(binder: Binder<Unscoped>) {
            // We will fill out contents later.
            RootPageModule.configure(binder: binder)
        }
    }
}
