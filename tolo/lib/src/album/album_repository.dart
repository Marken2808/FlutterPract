import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tolo/model/album.dart';
import 'package:tolo/model/photo.dart';

class AlbumRepository {
  AlbumRepository._();
  static final AlbumRepository instance = AlbumRepository._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(
      bucket: 'gs://tolo-1a943.appspot.com', app: FirebaseAuth.instance.app);

  Future getAvatar() async {
    // 1: Streambuilder inside loop of folder[index]
    // 2: GraphQL ref key
    final ref =
        _storage.ref().child('images/avatars/${_auth.currentUser!.uid}.png');
    String url = await ref.getDownloadURL();
    return url;
  }

  // ---------------------------------------------------------

  Future<List<String>> getLink(List<Reference> refs) async {
    return Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
  }

  Future<Album> listAll(String path) async {
    final ref = _storage.ref(path);
    final results = await ref.listAll();
    final urls = await getLink(results.items);

    List<Photo> photos = urls
        .asMap()
        .map((index, url) {
          final ref = results.items[index];
          final name = ref.name;
          final file = Photo(name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();

    return Album(ref: ref, name: path.split("/")[1], photos: photos);
  }

  // Future<List<Album>> listAll(String path) async {
  //   final ref = _storage.ref(path);
  //   final results = await ref.listAll();
  //   final urls = await getLink(results.items);

  //   return urls
  //       .asMap()
  //       .map((index, url) {
  //         final ref = results.items[index];
  //         final name = ref.name;
  //         final file = Album(ref: ref, name: name, url: url);
  //         return MapEntry(index, file);
  //       })
  //       .values
  //       .toList();
  // }

  Stream<String> imageLocation(int index) {
    final ref =
        _storage.ref().child('images/${_auth.currentUser!.uid}/$index.png');
    return ref.getDownloadURL().asStream().map((downloadUrl) => downloadUrl);
  }

  // Future test() async {
  //   final ref = _storage.ref().child('images/Messi_avt.png');
  //   var url = await ref.getDownloadURL();

  //   await _firestore
  //       .collection("images")
  //       .add({"url": url, "name": "imageName"});
  //   return url;
  // }
}
