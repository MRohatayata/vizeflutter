import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'kitap_ekle.dart';
import '../services/firestore.dart';


class KitapListesiSayfasi extends StatefulWidget {
  @override
  _KitapListesiSayfasiState createState() => _KitapListesiSayfasiState();
}

class _KitapListesiSayfasiState extends State<KitapListesiSayfasi> {

  final _fireStoreService = FireStoreService();
  Stream<QuerySnapshot> stream = FireStoreService.listedeYayinlanacakKitaplar.snapshots(); 
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Muhammet Rohat Ayata"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(  
            children: snapshot.data!.docs.map((doc) {
              return Card(
                child: ListTile(
                  leading: Text(doc['isim']),
                  title: Text(doc['yazarlar']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          //Güncelleme işlemi
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KitapEkleSayfasi(
                                kitaplar: doc['isim'],
                                yayinEvleri: doc['yayinEvleri'],
                                yazarlar: doc['yazarlar'],
                                sayfaSayilari: doc['sayfaSayisi'],
                                kategori: doc['kategori'],
                                basimYili: doc['basimYili'],
                                listedeGosterilecekMi: doc['listedeYayinla'],
                                guncellenecekMi: true,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //Silme işlemi
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Silmek istediğinize emin misiniz?"),
                                actions: [
                                  TextButton(
                                    child: Text("İptal"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Sil"),
                                    onPressed: () {
                                      print(doc.id);
                                      _fireStoreService.kitapSil(
                                        doc.id
                                        );
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //Ekleme işlemi
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KitapEkleSayfasi(
                kitaplar: '', yazarlar: '', yayinEvleri: '', sayfaSayilari: 0, kategori: '', basimYili: 0, listedeGosterilecekMi: true, guncellenecekMi: false),
            ),
          );
        },
      ),
    );
  }
}
