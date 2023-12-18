import 'package:flutter/material.dart';

import '../services/firestore.dart';

class KitapEkleSayfasi extends StatefulWidget {
  final String kitaplar;
  final String yazarlar;
  final String yayinEvleri;
  final int sayfaSayilari;
  final int basimYili;
  final String kategori;
  final bool listedeGosterilecekMi;
  final bool guncellenecekMi;

  KitapEkleSayfasi({
    required this.kitaplar,
    required this.yazarlar,
    required this.yayinEvleri,
    required this.sayfaSayilari,
    required this.kategori,
    required this.basimYili,
    required this.listedeGosterilecekMi,
    required this.guncellenecekMi,
  });

  @override
  // ignore: no_logic_in_create_state
  _KitapEkleSayfasiState createState() => _KitapEkleSayfasiState(
    kitaplar_text: kitaplar,
    yazarlar_text: yazarlar,
    yayinEvleri_text: yayinEvleri,
    sayfaSayilari_text: sayfaSayilari,
    kategori_text: kategori,
    basimYili_text: basimYili,
    guncellenecekMi: guncellenecekMi,
  );
}


class _KitapEkleSayfasiState extends State<KitapEkleSayfasi> {
  final kitaplar = TextEditingController();
  final yayinEvleri = TextEditingController();
  final yazarlar = TextEditingController();
  final kategori = TextEditingController();
  final sayfaSayilari = TextEditingController();
  final basimYili = TextEditingController();
  
  final String kitaplar_text;
  final String yazarlar_text;
  final String yayinEvleri_text;
  final int sayfaSayilari_text;
  final int basimYili_text;
  final String kategori_text;
  final bool guncellenecekMi;
  bool listedeGosterilecekMi=false;

  _KitapEkleSayfasiState({
    required this.kitaplar_text,
    required this.yazarlar_text,
    required this.yayinEvleri_text,
    required this.sayfaSayilari_text,
    required this.kategori_text,
    required this.basimYili_text,
    required this.guncellenecekMi,
  });
  String? idString;
  @override
  void initState() {
    super.initState();

    // controller'ı başlatın
    kitaplar.text = kitaplar_text;
    yayinEvleri.text = yayinEvleri_text;
    yazarlar.text = yazarlar_text;
    kategori.text = kategori_text;
    sayfaSayilari.text = sayfaSayilari_text.toString();
    basimYili.text = basimYili_text.toString();
    if (guncellenecekMi){
      idString = idBul().toString();
      print(idString);
    }
    else{
      idString="";
    }
  }

  //async id bulma metodu
  Future<String> idBul() async{
    final Future<String> idFuture = FireStoreService.kitaplar
          .where('isim', isEqualTo: kitaplar_text)
          .where('yayinEvleri', isEqualTo: yayinEvleri_text)
          .where('yazarlarlar', isEqualTo: yazarlar_text)
          .where('kategori', isEqualTo: kategori_text)
          .where('sayfaSayilari', isEqualTo: int.parse(sayfaSayilari_text.toString()))
          .where('basimYili', isEqualTo: int.parse(basimYili_text.toString()))
          .get()
          .then((value) => value.docs[0].id);

        idFuture.then((value) => idString = value);
        
        return idString ?? "";
  }
  
  final _fireStoreService = FireStoreService();

  void clearText(){
    kitaplar.clear();
      yayinEvleri.clear();
      yazarlar.clear();
      kategori.clear();
      sayfaSayilari.clear();
      basimYili.clear();
      listedeGosterilecekMi = false;
  }
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Kitap Ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Kitap Adı",
              ),
              controller: kitaplar,
              
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Yayınevi",
              ),
              controller: yayinEvleri,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "yazarlarlar",
              ),
              controller: yazarlar,
            ),
            DropdownButtonFormField(
              onChanged: (value) {
                kategori.text = value.toString();
              },
              items: [
                DropdownMenuItem(
                  child: Text("Roman"),
                  value: "Roman",
                ),
                DropdownMenuItem(
                  child: Text("Tarih"),
                  value: "Tarih",
                ),
                DropdownMenuItem(
                  child: Text("Edebiyat"),
                  value: "Edebiyat",
                ),
                DropdownMenuItem(
                  child: Text("Şiir"), 
                  value: "Şiir",
                ),
                DropdownMenuItem(
                  child: Text("Ansiklopedi"),
                  value: "Ansiklopedi",
                ),
                DropdownMenuItem(
                  child: Text("Biyografi"),
                  value: "Biyografi",
                ),
              ],
              value: "Roman",
              decoration: InputDecoration(
                labelText: "Kategori",
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Sayfa Sayısı",
              ),
              keyboardType: TextInputType.number,
              controller: sayfaSayilari,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Basım Yılı",
              ),
              keyboardType: TextInputType.number,
              controller: basimYili,
            ),
            CheckboxListTile(
              title: Text("Listede Yayınlanacak mı?"),
              value: listedeGosterilecekMi,
              onChanged: (value) {
                setState(() {
                  listedeGosterilecekMi = value ?? false;
                });
              },
            ),
            ElevatedButton(
              child: Text("Kaydet"),
              onPressed: () {
                //Kaydet
                if(guncellenecekMi){
                  _fireStoreService.kitapGuncelle(
                    idString ?? "",
                    kitaplar.text ?? "",
                    yayinEvleri.text ?? "",
                    yazarlar.text ?? "",
                    kategori.text ?? "",
                    int.tryParse(sayfaSayilari.text) ?? 0,
                    int.tryParse(basimYili.text) ?? 0,
                    listedeGosterilecekMi ?? false
                    );
                }
                else{
                  _fireStoreService.kitapEkle(
                    kitaplar.text ?? "", 
                    yayinEvleri.text ?? "",
                    yazarlar.text ?? "",
                    kategori.text ?? "",
                    int.tryParse(sayfaSayilari.text) ?? 0,
                    int.tryParse(basimYili.text) ?? 0,
                    listedeGosterilecekMi ?? false
                    );
                }
                if(guncellenecekMi){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Kitap Güncellendi"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    )
                  );
                }
                else{
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Kitap Eklendi"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    )
                  );
                }
                //Tum alanlari temizle
                clearText();
              },
            ),
          ],
        ),
      ),
    );
  }
}
