import 'encrypted_value.dart';


/// # KeyEncryptor
/// ## Info
/// this is an interface clas, a generic one to implement
/// any Encryptor it's algorithm use keys to decrypt
/// ============================================================
/// ## Functions
/// 
/// [encrypt] : to implement the encryption function
///
/// [decrypt] : to implement the decryption function
abstract class KeyEncryptor{
  String _encryptionKey = "";
  String get getKey => _encryptionKey;
  set setKey(String key)=> _encryptionKey = key;
  EncryptedValue encrypt(String value);
  dynamic decrypt(EncryptedValue encryptedValue);
}