import Foundation
import SwiftKeychainWrapper

protocol CryptProtocol {
    func createKey()
    func getKey() -> [UInt32]
    func changeKey(arrayKey: [UInt32])
    func toBinaryCode(str: String) -> Array<UInt8>
    func fromBinaryCode(binaryArray: Array<UInt8>) -> String
    func shift(_ base: UInt32, _ shift: UInt32) -> UInt32
    func strToSafeCode(str: String, key: [UInt32]) -> Array<UInt32>
    func safeCodeToStr(array: [UInt32], key: [UInt32]) -> String
}

class Crypt: CryptProtocol {
    
    func createKey(){
        for i in 1...4{
            let a = arc4random()
            KeychainWrapper.standard.set(Int(a), forKey: "key\(i)", withAccessibility: .alwaysThisDeviceOnly, isSynchronizable: false)
        }
    }
    
    func getKey() -> [UInt32]{
        var key: [UInt32] = []
        for i in 1...4{
            key.append(UInt32(KeychainWrapper.standard.integer(forKey: "key\(i)")!))
        }
        return key
    }
    
    func changeKey(arrayKey: [UInt32]){
        for i in 1...4{
            KeychainWrapper.standard.set(Int(arrayKey[i-1]), forKey: "key\(i)", withAccessibility: .alwaysThisDeviceOnly, isSynchronizable: false)
        }
    }
    
    
    
    func toBinaryCode(str: String) -> Array<UInt8>{
        let data = Data(str.utf8) //строка в data
        
        let binaryArray = data.map({(byte) -> UInt8 in
            let str = UInt8(byte)
            return str
        })
        return binaryArray
    }
    
    func fromBinaryCode(binaryArray: Array<UInt8>) -> String{
        let newData = binaryArray.withUnsafeBufferPointer {Data(buffer: $0)} //преобразовываем обратно в Data
        let newStr = String(decoding: newData, as: UTF8.self)
        return newStr
    }
    
    
    
    func shift(_ data: UInt32, _ shift: UInt32) -> UInt32 {
        let shiftNew = shift & 0x1F
        return (data << shiftNew) | (data >> (32 - shiftNew))
    }
    
    private func encrypt (value: inout [UInt32],key: [UInt32]) ->[UInt32] {
        var new0 = value[0] &+ key[0]
        var new1 = value[1] &+ key[1]
        
        var sum : UInt32 = 0
        let delta : UInt32 = 0x9e3779b9
        
        for _ in 0...31 {
            let first1 = ((new1 << 4) ^ (new1 >> 5))
            let second1 = shift(key[Int(sum & UInt32(3))], new1)
            
            new0 &+= first1 &+ (new1 ^ sum) &+ second1
            sum &+= delta
            
            let first2 = ((new0 << 4) ^ (new0 >> 5))
            let second2 = shift(key[Int((sum >> 11) & 3)], new0)
            new1 &+= first2 &+ (new0 ^ sum) &+ second2
        }
        
        value[0] = new0 ^ key[2]
        value[1] = new1 ^ key[3]
        
        return value
    }
    
    private func decrypt (value: inout [UInt32], key: [UInt32]) -> [UInt32] {
        var new0 = value[0] ^ key[2]
        var new1 = value[1] ^ key[3]
        
        let delta : UInt32 = 0x9e3779b9
        var sum = delta &* 32
        
        for _ in 0...31 {
            
            let first1 = (new0 << 4) ^ (new0 >> 5)
            let second1 = shift(key[Int((sum >> 11) & 3)],new0)
            new1 &-=  first1 &+ (new0 ^ sum) &+ second1
            sum &-= delta
            
            
            let first2 = ((new1 << 4) ^ (new1 >> 5))
            let second2 = shift(key[Int(sum & 3)], new1)
            new0 &-= first2 &+ (new1 ^ sum) &+ second2
            
        }
        value[1] = new1 &- key[1]
        value[0] = new0 &- key[0]
        
        return value
    }
    
    
    
    func strToSafeCode(str: String, key: [UInt32]) -> Array<UInt32> {
        var unsafetyArray = toBinaryCode(str: str)
        
        var safeArray: [UInt32] = []
        
        var emptyValue = 0
        if unsafetyArray.count % 8 != 0 {
            emptyValue = 8 - (unsafetyArray.count % 8)
        }
        
        for _ in 0..<emptyValue{
            unsafetyArray.append(0x01)
        }
        
        for i in stride(from: 0, through: unsafetyArray.count-1, by: 8){
            let block1 = [unsafetyArray[i], unsafetyArray[i+1], unsafetyArray[i+2], unsafetyArray[i+3]].withUnsafeBytes { $0.load(as: UInt32.self) }
            let block2 = [unsafetyArray[i+4], unsafetyArray[i+5], unsafetyArray[i+6], unsafetyArray[i+7]].withUnsafeBytes { $0.load(as: UInt32.self) }
            var doubleBlock: [UInt32] = [block1, block2]
            let doubleUInt32 = (encrypt(value: &doubleBlock, key: key))  //шифруем
            safeArray.append(doubleUInt32[0])
            safeArray.append(doubleUInt32[1])
        }
        return safeArray
    }
    
    func safeCodeToStr(array: [UInt32], key: [UInt32]) -> String {
        var newArray: [UInt32] = []
        for i in stride(from: 0, through: array.count - 1, by: 2){
            var doubleArray = [array[i], array[i+1]]
            doubleArray = decrypt(value: &doubleArray, key: key)  //расшифровываем
            newArray.append(doubleArray[0])
            newArray.append(doubleArray[1])
        }
        
        var uint8Array: [UInt8] = []
        for i in 0...newArray.count-1{
            var uint8Block = withUnsafeBytes(of: newArray[i].bigEndian) {
                Array($0)
            }
            uint8Block.reverse()
            uint8Array.append(contentsOf: uint8Block)
        }
        
        print(uint8Array)
        let str = fromBinaryCode(binaryArray: uint8Array)
        print(str)
        return(str)
    }
}
