//
//  SessionsDay3InterfaceController.swift
//  trySwift
//
//  Created by Natasha Murashev on 2/23/16.
//  Copyright © 2016 NatashaTheRobot. All rights reserved.
//

import WatchKit
import Foundation
import RealmSwift

class SessionsDay3InterfaceController: WKInterfaceController {

    @IBOutlet private var sessionsTable: WKInterfaceTable!
    
    private let sessions = Session.sessionsSept2
    
    var token: NotificationToken? = nil
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        setTitle("try! Sep 2")
        loadTableData()
        subscribeToChangeNotification()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    deinit {
        token?.stop()
    }

}

private extension SessionsDay3InterfaceController {
    
    func loadTableData() {
        sessionsTable.setNumberOfRows(sessions.count, withRowType: String(SessionTableRowController))
        
        for (index, session) in sessions.enumerate() {
            let row = sessionsTable.rowControllerAtIndex(index) as? SessionTableRowController
            row?.configure(session)
        }
    }
    
    func subscribeToChangeNotification() {
        token = Presentation.presentations.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            self?.loadTableData()
        }
    }
}


