import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{

  //Kitaplari geitiren stream
  static final kitaplar = FirebaseFirestore.instance.collection('kitaplar');
  static final listedeYayinlanacakKitaplar = kitaplar.where('listedeYayinla', isEqualTo: true);

  Future<void> kitapEkle(String isim, String yayinEvleri,String yazarlarim, String kategori, int sayfaSayisi, int basimYili, bool listedeYayinla) async {
    return await kitaplar
        .add({
          'isim': isim,
          'yayinEvleri': yayinEvleri,
          'yazarlar':yazarlarim,
          'kategori': kategori,
          'sayfaSayisi': sayfaSayisi,
          'basimYili': basimYili,
          'listedeYayinla': listedeYayinla,
          'id': FieldValue.increment(1) // Her kitap için ID'yi 1 artır
        })
        .then((value) => print("Kitap Eklendi"))
        .catchError((error) => print("Kitap Eklenemedi: $error"));
  }

  Future<void> kitapGuncelle(String id, String isim, String yayinEvleri, String yazarlarim, String kategori, int sayfaSayisi, int basimYili, bool listedeYayinla) async {
    if (id == ""){
      print("id boş");
      return null;
    }
    return await kitaplar
        .doc(id)
        .update({
          'isim': isim,
          'yayinEvleri': yayinEvleri,
          'yazarlar':yazarlarim,
          'kategori': kategori,
          'sayfaSayisi': sayfaSayisi,
          'basimYili': basimYili,
          'listedeYayinla': listedeYayinla,
        })
        .then((value) => print("Kitap Güncellendi"))
        .catchError((error) => print("Kitap Güncellenemedi: $error"));
  }
  Future<void> kitapSil(String id) async {
    return await kitaplar
        .doc(id)
        .delete()
        .then((value) => print("Kitap Silindi"))
        .catchError((error) => print("Kitap Silinemedi: $error"));
  }
}