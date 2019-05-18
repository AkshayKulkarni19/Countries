//
//  DatabaseCore.swift
//  Countries
//
//  Created by Akshay Kulkarni on 17/05/19.
//  Copyright © 2019 Akshay. All rights reserved.
//

import Foundation
import RealmSwift

/// Implementation of application-independent database access logic.
open class DatabaseCore: NSObject {
    
    /// Singleton instance for DatabaseCore
    static let sharedInstance: DatabaseCore = DatabaseCore()
    fileprivate var realm: Realm?
    
    override init(){
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    /// Realm instance for perfoming the database operation
    //    fileprivate lazy var realm: Realm? = {
    //        var realm = try? Realm()
    //        return realm
    //    }()
    
    open class func handleDatabaseMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in

                
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
    /// Saves a Realm object in database.
    ///
    /// - Parameter object: The Realm Object to be saved.
    open func saveObject(_ object:RealmSwift.Object, update: Bool = false) -> Void{
        Logger.log(message: "Saving object \(object.description)", messageType: .info)
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do{
                try realm.write{
                    realm.add(object, update: update)
                    Logger.log(message: "DataBase Core : Save Function", messageType: .debug)
                }
            }
            catch (let error){
                Logger.log(message: "Realm Save object error: \(error)", messageType: .error)
            }
        }
    }
    
    open func saveObjects(_ objects: [RealmSwift.Object], update: Bool = false) -> Void{
        Logger.log(message: "Saving objects \(objects.description)", messageType: .info)
        
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do{
                try realm.write{
                    for obj in objects {
                        realm.add(obj, update: update)
                    }
                }
            }
            catch (let error){
                Logger.log(message: "Realm Save object error: \(error)", messageType: .error)
            }
        }
    }
    
    /// Writes a Realm object in database using the specified closure.
    ///
    /// - Parameter closure: The closure for the write call.
    open func write(_ closure: @escaping () -> Void){
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do{
                try realm.write(closure)
            }
            catch (let error){
                Logger.log(message: "Realm Write error: \(error)", messageType: .error)
            }
        }
    }
    
    //    /// Writes a Realm object in database using the specified closure where the Realm instance is available.
    //    ///
    //    /// - Parameter realmClosure: The closure for the write call.
    //    open func writeWithRealmClosure(_ realmClosure: @escaping (_ realm: Realm) -> Void){
    //        guard let realm = realm
    //            else {
    //                return
    //        }
    //
    ////        _ = try? realm.write{
    ////            realmClosure(realm)
    ////        }
    //
    //        // TODO: updated from above
    //        do{
    //            try realm.write{
    //                realmClosure(realm)
    //            }
    //        }
    //        catch (let e){
    //            notify("realm writeWithRealmClosure error: \(e)", module: .DebugTrip)
    //        }
    //    }
    
    /// Deletes a Realm object from the database.
    ///
    /// - Parameter object: The Realm Object to be deleted.
    open func deleteObject(_ object: RealmSwift.Object, completionHandler: ((_ isSucceed: Bool) -> Void)? = nil) -> Void{
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do{
                try realm.write{
                    realm.delete(object)
                    completionHandler?(true)
                    Logger.log(message: "DataBase Core : Delete Function", messageType: .debug)
                }
            }
            catch (let error){
                Logger.log(message: "Realm delete object error: \(error)", messageType: .error)
            }
        }
    }
    
    /// Deletes a list of Realm objects from the database.
    ///
    /// - Parameter objects: The list of Realm objects to be deleted.
    open func deleteObjects(_ objects: [RealmSwift.Object]) -> Void {
        Logger.log(message: "Deleting objects \(objects.description)", messageType: .info)
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            
            do{
                try realm.write{
                    realm.delete(objects)
                }
            }
            catch (let error){
                Logger.log(message: "Realm delete objects error: \(error)", messageType: .error)
            }
        }
    }
    
    /// Deletes a Realm List from the database.
    ///
    /// - Parameter list: The Realm List to be deleted.
    open func deleteList<T: Object>(_ list: List<T>) {
        Logger.log(message: "Deleting objects List \(list.description)", messageType: .info)
        
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            // TODO: updated from above
            do{
                try realm.write{
                    realm.delete(list)
                }
            }
            catch (let error){
                //                notify("realm deleteList error: \(e)", module: .DebugTrip)
                print("Realm Delete list error: \(error)")
            }
        }
    }
    
    open func deleteObjects<T: Object>(_ results: Results<T>) {
        Logger.log(message: "Deleting results \(results.description)", messageType: .info)
        
        DispatchQueue.main.async { [weak self] in
            guard let realm = self?.realm else {
                return
            }
            // TODO: updated from above
            do{
                try realm.write{
                    realm.delete(results)
                }
            }
            catch (let error){
                Logger.log(message: "Realm Delete List error: \(error)", messageType: .error)
            }
        }
    }
    
    /// Retrieves objects from Realm database.
    ///
    /// - Parameters:
    ///   - type: Class Type of objects to be retrieved.
    ///   - predicate: Predicate to be applied on fetch results.
    /// - Returns: The retrieved objects.
    
    // USE closure for returning
    open func retrieveObjects<T: RealmSwift.Object>(_ type: T.Type, predicate: NSPredicate? = nil, resultClosure: @escaping ((Array<T>) -> Void)){
        DispatchQueue.main.async { [weak self] in
            
            guard let realm = self?.realm else {
                resultClosure([])
                return
            }
            
            var objects: RealmSwift.Results = realm.objects(type)
            if let l_predicate = predicate {
                objects = objects.filter(l_predicate)
            }
            Logger.log(message: "Retrieved results \(objects.count)", messageType: .info)
            resultClosure(Array(objects))
        }
    }
    
    /// Retrieves Realm Results from Realm database.
    ///
    /// - Parameter type: Class Type of objects to be retrieved.
    /// - Returns: The retrieved Realm Results.
    
    // TODO: USE closure for returning
    
    open func retrieveResults<T: RealmSwift.Object>(_ type: T.Type, resultClosure: @escaping ((RealmSwift.Results<T>?) -> Void)) {
        DispatchQueue.main.async { [weak self] in
            
            guard let realm = self?.realm else {
                resultClosure(nil)
                return
            }
            
            let objects = realm.objects(type)
            Logger.log(message: "Retrieved results \(objects.count)", messageType: .info)
            resultClosure(objects)
        }
    }
    
    open func retrieveResults<T: RealmSwift.Object>(_ baseClassType: T.Type, subclassTypes:[T.Type], predicate: NSPredicate? = nil, resultClosure: @escaping (([T]) -> Void)) {
        DispatchQueue.main.async { [weak self] in
            Logger.log(message: "Realm combine table results: for types \((subclassTypes).description)", messageType: .info)
            guard let realm = self?.realm else {
                resultClosure([])
                return
            }
            
            if let l_predicate = predicate {
                let allResults = subclassTypes.flatMap { classType in
                    return Array(realm.objects(classType).filter(l_predicate))
                }
                resultClosure(allResults)
            } else {
                let allResults = subclassTypes.flatMap { classType in
                    return Array(realm.objects(classType))
                }
                Logger.log(message: "Realm: appending results to \(allResults.description)", messageType: .info)
                resultClosure(allResults)
            }
        }
    }
    
    open func numberOfRecords<T: RealmSwift.Object>(_ type: T.Type) -> Int {
        assert(Thread.isMainThread, "Realm should be accessed from main thread")
        //        do{
        guard let realm = self.realm else {
            return 0
        }
        //        }catch {
        //            print(error)
        //        }
        
        let objects = realm.objects(type)
        return objects.count
        
    }
    
    class func convertToListFromArray<T>(_ array: Array<T>) -> List<T> {
        
        let realmList = List<T>()
        
        realmList.append(objectsIn: array)
        
        /*do{
            try realm.write{
                realmList.append(objectsIn: array)
            }
        } catch (let error){
            Logger.log(message: "Realm Delete List error: \(error)", messageType: .error)
        }*/
        
        return realmList
    }
    
}
/*
extension Array<S: Sequence> where S.Iterator.Element == Element {
    func convertToListFromArray<T: Object>() -> List<T> {
        var realmList = List<T>()
        realmList.append(objectsIn: self)
        return realmList
    }
}*/
