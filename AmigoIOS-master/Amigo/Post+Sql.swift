//
//  Post+Sql.swift
//  Amigo
//
//  Created by אביעד on 09/03/2020.
//  Copyright © 2020 Shiran Klein. All rights reserved.
//

import Foundation

extension Post{
    static func create_table(database: OpaquePointer?){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
            let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS POSTS (ST_ID TEXT PRIMARY KEY, NAME TEXT, AVATAR TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    
    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO POSTS(ST_ID, NAME, AVATAR) VALUES (?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
           // let id = self.id.cString(using: .utf8)
            let title = self.title.cString(using: .utf8)
            let plaveImage = self.placeImage.cString(using: .utf8)
            let userName = self.userName.cString(using: .utf8)
            let placeLocation = self.placeLocation.cString(using: .utf8)
            let recText = self.recText.cString(using: .utf8)
           // sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, title,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, placeImage,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, placeLocation,-1,nil);
             sqlite3_bind_text(sqlite3_stmt, 3, recText,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, userName,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    static func getAllPostsFromDb()->[Post]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        
        if (sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from POSTS WHERE TITLE='Rishon-Lezion';",-1,&sqlite3_stmt,nil)
            == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let psTitle = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let ps = Post(title: psTitle);
              //  ps.title = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                ps.placeImage = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                ps.userName = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                ps.recText = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                ps.placeLocation = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                data.append(ps)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
    static func setLastUpdate(lastUpdated:Int64){
        return ModelSql.instance.setLastUpdate(name: "POSTS", lastUpdated: lastUpdated);
    }
    
    static func getLastUpdateDate()->Int64{
        return ModelSql.instance.getLastUpdateDate(name: "POSTS")
    }
    
    

}
